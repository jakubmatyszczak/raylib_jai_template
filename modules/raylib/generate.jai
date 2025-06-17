LIBRARY_NAME :: "raylib";

#run {
   set_build_options_dc(.{
      do_output = false,
      write_added_strings = false,
   });

   print(".. generating bindings for % (platform: %)\n\n", LIBRARY_NAME, OS);

   opts: Generate_Bindings_Options;
   opts.strip_flags                   = 0;
   opts.generate_library_declarations = false;

   // not working right now.
   // opts.visitor = (decl: *Declaration, parent: *Declaration) -> Declaration_Visit_Result {
   //    if decl.kind == .FUNCTION {
   //       // Make foreign functions use 'raylib' instead of 'raylib_version'
   //       func := cast(*Function)decl;
   //       if func.library && func.library.name.count {
   //          func.library.name = "raylib";
   //       }

   //       // Save any procs starting with Begin (used later)
   //       if starts_with(decl.name, "Begin") {
   //          array_add(*begin_end_procs, decl);
   //       }
   //    };

   //    return .RECURSE;
   // };

   #if OS == .WINDOWS {
      array_add(*opts.libpaths, "win");
   } else #if OS == .LINUX {
      array_add(*opts.libpaths, "linux");
   } else #if OS == .MACOS {
      array_add(*opts.libpaths, "mac");
      array_add(*opts.system_include_paths, "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include");
   } else {
      assert(false, "Unsupported OS: %", OS);
   }

   array_add(*opts.libnames, LIBRARY_NAME);
   array_add(*opts.source_files, "lib/raylib.h", "lib/raymath.h", "lib/rlgl.h");
   array_add(*opts.extra_clang_arguments, "-x", "c");
   array_add(*opts.system_include_paths, GENERATOR_DEFAULT_SYSTEM_INCLUDE_PATH);

   assert(generate_bindings(opts, "raylib.jai"), "unable to generate bindings for raylib!");

   print("\n.. finished generating bindings\n");

   print(".. generating 'extras.jai'\n");

   builder: String_Builder;
   append(*builder, "// Auto-generated utility macros\n\n");

   for begin_end_procs {
      func := cast(*Function)it;
      type := func.type.type_of_function;

      name_no_prefix := it.output_name;
      name_no_prefix.data  += 5;
      name_no_prefix.count -= 5;

      macro_name := tprint("BeginEnd%", name_no_prefix);

      get_func_args_for_printing := context.generator_options.get_func_args_for_printing;
      args := get_func_args_for_printing(func, type, .OUTER_WRAPPER);

      generate_proc_header :: (name: string, args: []*Declaration, add_code_arg: bool) -> string {
         b: String_Builder;
         print_to_builder(*b, "% :: (", name);

         for args {
            if it_index defer append(*b, ", ");
            flags := Print_Decl_Flags.NO_SEMICOLON | .NO_INDENT | .IN_FUNCTION_ARGS;
            print_declaration_to_builder(*b, it, it.parent, flags);
         }

         if add_code_arg {
            if args.count > 0 {
               append(*b, ", ");
            }

            append(*b, "block: Code");
         }

         append(*b, ") #expand");

         return builder_to_string(*b);
      }

      // Generate macro without code argument
      append(*builder, generate_proc_header(macro_name, args, false));
      append(*builder, " {\n");

      print_to_builder(*builder, "\tBegin%(", name_no_prefix);
      for args {
         if it_index defer append(*builder, ", ");
         append(*builder, it.name);
      }
      append(*builder, ");\n");
      print_to_builder(*builder, "\t`defer End%();\n", name_no_prefix);
      print_to_builder(*builder, "}\n");

      // Generate macro with code argument
      append(*builder, generate_proc_header(macro_name, args, true));
      append(*builder, " {\n");

      print_to_builder(*builder, "\tBegin%(", name_no_prefix);
      for args {
         if it_index defer append(*builder, ", ");
         append(*builder, it.name);
      }
      append(*builder, ");\n");

      append(*builder, "\t#insert block;\n");
      print_to_builder(*builder, "\tEnd%();\n", name_no_prefix);
      print_to_builder(*builder, "}\n\n");
   }

   assert(write_entire_file("extras.jai", builder_to_string(*builder)), "unable to generate 'extras.jai'");

   print(".. finished generating 'extras.jai'\n");
}

begin_end_procs: [..]*Declaration;

#import "File";
#import "Basic";
#import "String";
#import "Compiler";
#import "Hash_Table";
#import "Bindings_Generator";
