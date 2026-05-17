#import "mengine";
dq :: #import "mengine/DrawQueue";
rl :: #import "mengine/raylib";

#import "Math";

main :: () 
{
    main: dq.DrawQueue(64);

    rl.InitWindow(800, 450, "mengine example");
    defer rl.CloseWindow();

    atlas := rl.LoadTexture("res/atlas.png");
    t : float;
    while !rl.WindowShouldClose() 
    {
        t += rl.GetFrameTime();
        dq.push_text(*main, .{190, 200}, 20, rl.LIGHTGRAY, "raylib + jai + mengine: %", t);
        dq.push(*main, .{0., 0.}, .{8., 8.}, .{100, 100}, 0., .{10,10});

        rl.BeginDrawing();

        rl.ClearBackground(rl.RAYWHITE);

        dq.draw(*main, atlas);
        
        rl.EndDrawing();
    }
}
