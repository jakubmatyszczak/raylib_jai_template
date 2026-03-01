Basic :: #import "Basic";
#import "Math";
#import "Random";

#load "src/global.jai";

rl :: #import "raylib";
engine :: #import "mengine";

main :: ()
{
    random_seed(Basic.current_time_monotonic().low);
    g.screenSize = .{1920, 1080};
    g.renderSize = .{1920, 1080};
    rl.InitWindow(xx g.screenSize.x, xx g.screenSize.y, "game");
    rl.InitAudioDevice();
    content_init(*g.content);
    g.renderTarget= rl.LoadRenderTexture(xx g.renderSize.x, xx g.renderSize.y);

    rl.SetTargetFPS(60);
    // rl.ToggleFullscreen();

    game();

    if rl.IsWindowFullscreen()
        rl.ToggleFullscreen();
    rl.CloseWindow();
}

game :: () -> bool
{
    start := true;
    g.camera = .{offset= .{xx (g.renderSize.x / 2), xx (g.renderSize.y / 2)},
                    target=.{0,0}, rotation=0., zoom=1.};

    default := engine.drawQueue_make(.{32., 32.});

    while start
    {
        dt := rl.GetFrameTime();
        g.time += dt;
        g.mouseScreen = rl.GetMousePosition();
        g.mouseWorld = rl.GetScreenToWorld2D(g.mouseScreen, g.camera);

        if(rl.IsKeyPressed(cast(s32)rl.KeyboardKey.KEY_ESCAPE))
            start = false;
        
        if(rl.IsKeyPressed(rl.KeyboardKey.KEY_X))
            sound_play(SfxId.BONK);

        if(rl.IsKeyDown(rl.KeyboardKey.KEY_W))
            g.camera.target.y += 10.5;
        if(rl.IsKeyDown(rl.KeyboardKey.KEY_S))
            g.camera.target.y -= 10.5;
        if(rl.IsKeyDown(rl.KeyboardKey.KEY_A))
            g.camera.target.x += 10.5;
        if(rl.IsKeyDown(rl.KeyboardKey.KEY_D))
            g.camera.target.x -= 10.5;

        engine.drawQueue_add(*default, .{0., 0.}, pos = {0., 0.}, rot = g.time * 60.);
        engine.drawQueue_add(*default, .{1., 0.}, pos = {0., 50.});
        engine.drawQueue_add(*default, .{2., 0.}, pos = {0., 100.});

        //draw
        rl.BeginDrawing();
        rl.DrawRectangleGradientV(0, 0, xx g.screenSize.x, xx g.screenSize.y, .{140, 190, 124, 255}, .{92, 140, 77, 255});
        rl.BeginMode2D(g.camera);
            engine.drawQueue_draw(*default, g.content.textures[TexId.ATLAS_BOXES]);
        rl.EndMode2D();
        rl.DrawFPS(25,25);
        rl.EndDrawing();
    }
    return false;
}

