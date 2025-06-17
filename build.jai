#import "Compiler";
Basic :: #import "Basic";

#if OS == .WINDOWS
{
    Windows_Resources :: #import "Windows_Resources";
    Ico_File :: #import "Ico_File";
}

#run {
    executable_name := "a.out";

    w := compiler_create_workspace();
    options := get_build_options(w);
    args := options.compile_time_command_line;
    isReleaseBuild := false;
    for arg : args
    {
        if arg ==
        {
            case "release";
            {
                Basic.print("Building in Release mode.\n");
                isReleaseBuild = true;
                options.backend = .LLVM;
                set_optimization(*options, .OPTIMIZED);
            }
        }
    }
    if !isReleaseBuild
        set_optimization(*options, .DEBUG);

    options.output_executable_name = executable_name;
    set_build_options(options, w);

    compiler_begin_intercept(w);

    add_build_file("main.jai", w);

    while true
    {
        message := compiler_wait_for_message();

        if message.kind == .COMPLETE
            break;
    }
    compiler_end_intercept(w);

    #if OS == .WINDOWS
    {
        exe_name := Basic.sprint("%.exe", options.output_executable_name);
        ico_data := Ico_File.create_ico_file_from_bitmap_filename("res\\icon.png");
        if !ico_data then
            Basic.print("Could not load image for icon.\n");
        Windows_Resources.disable_runtime_console();
        Windows_Resources.set_icon_by_data(exe_name, ico_data);
        manifest_options: Windows_Resources.Manifest_Options;
        Windows_Resources.add_manifest_to_executable(exe_name, manifest_options);
    }
    set_build_options_dc(.{do_output=false});
}

