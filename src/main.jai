#import "mengine";
dq :: #import "mengine/DrawQueue";
rl :: #import "mengine/raylib";

#import "Math";

main :: () 
{
    rl.InitWindow(800, 450, "mengine example");
    rl.SetTargetFPS(60);
    defer rl.CloseWindow();

    main: dq.DrawQueue(64);
    atlas := rl.LoadTexture("res/atlas.png");

    t : float;

    dude1 := atlas_getTexture(.RED_DUDE);       // AtlasId (.RED_DUDE) auto generated from filename during compile
    dude2 := atlas_getTexture(.GREEN_DUDE);
    dude2_position : Vector2 = .{250, 250};

    while !rl.WindowShouldClose() 
    {
        dt := rl.GetFrameTime();
        t += dt;

        input := Vector2.{x = cast(float)rl.IsKeyDown(.KEY_D) - cast(float)rl.IsKeyDown(.KEY_A), 
                            y = cast(float)rl.IsKeyDown(.KEY_S) - cast(float)rl.IsKeyDown(.KEY_W)};
        dude2_position += input;

        // Set up drawing
        dq.push_text(*main, .{200, 180}, 20, rl.LIGHTGRAY, "raylib + jai + mengine: %", t);
        dq.push_text(*main, .{200, 200}, 20, rl.LIGHTGRAY, "move green dude with WASD");
        dq.push(*main, dude1.origin, dude1.size, pos = .{50., 50}, rot = t, scale = .{3., 3.});
        dq.push(*main, dude2.origin, dude2.size, pos = dude2_position, scale = .{3., 3.});

        rl.BeginDrawing();

        rl.ClearBackground(rl.RAYWHITE);

        dq.draw(*main, atlas);
        
        rl.EndDrawing();
    }
}
