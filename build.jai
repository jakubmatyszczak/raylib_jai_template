#import "Compiler";
#import "Process";
Basic :: #import "Basic";

#if OS == .WINDOWS
{
    Windows_Resources :: #import "Windows_Resources";
    Ico_File :: #import "Ico_File";
}

rl :: #import "mengine/raylib";
Content :: #import "mengine/Content";

#run {
    executable_name := "game";

    w := compiler_create_workspace();
    options := get_build_options(w);
    args := options.compile_time_command_line;
    isReleaseBuild := false;
    for arg : args
    {
        if arg ==
        {
            case "release";
                Basic.print("Building in Release mode.\n");
                isReleaseBuild = true;
                options.backend = .LLVM;
                set_optimization(*options, .OPTIMIZED);
            case "debug";
                options.backend = .X64;
        }
    }
    if !isReleaseBuild
        set_optimization(*options, .DEBUG);

    options.output_executable_name = executable_name;
    set_build_options(options, w);
    compiler_begin_intercept(w);

    atlas, names := Content.code_gen_texture_atlas("res/images", "res/atlas.png");
    add_build_string(Content.generate_enum_for_atlas(names, atlas, "res/atlas.png"), w);

    add_build_file("src/main.jai", w);

    runGame := false;
    while true
    {
        message := compiler_wait_for_message();
        if message.kind == .COMPLETE
        {
            messageComplete := cast(*Message_Complete)message;
            if messageComplete.error_code == .NONE
                runGame = true;
            break;
        }
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
    if runGame
        run_command("./game");
}

