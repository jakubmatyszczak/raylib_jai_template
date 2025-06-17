Basic :: #import "Basic";
#import "Math";
#import "Random";
rl :: #import "raylib";
#load "src/global.jai";

main :: ()
{
    random_seed(Basic.current_time_monotonic().low);
    g.screenSize = .{1920, 1080};
    g.renderSize = .{384, 216};
    rl.InitWindow(xx g.screenSize.x, xx g.screenSize.y, "no.6");
    rl.InitAudioDevice();
    content_init(*g.content);
    g.renderTarget= rl.LoadRenderTexture(xx g.renderSize.x, xx g.renderSize.y);

    rl.SetTargetFPS(60);
    // rl.ToggleFullscreen();

    // while game(*music)
    //     reset_state();
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
            g.camera.target.y += 0.5;
        if(rl.IsKeyDown(rl.KeyboardKey.KEY_S))
            g.camera.target.y -= 0.5;
        if(rl.IsKeyDown(rl.KeyboardKey.KEY_A))
            g.camera.target.x += 0.5;
        if(rl.IsKeyDown(rl.KeyboardKey.KEY_D))
            g.camera.target.x -= 0.5;

        //draw
        rl.BeginTextureMode(g.renderTarget);
        rl.DrawRectangleGradientV(0, 0, xx g.screenSize.x, xx g.screenSize.y, .{140, 190, 124, 255}, .{92, 140, 77, 255});
        rl.BeginMode2D(g.camera);
            rl.DrawTexturePro(g.content.textures[TexId.BOX], .{0, 0, 32, 32}, .{0, 0, 32, 32}, .{16, 16}, g.time * 16., rl.RED);
        rl.EndMode2D();
        rl.EndTextureMode();

        rl.BeginDrawing();
            rl.DrawTexturePro(g.renderTarget.texture, .{0, 0, xx g.renderTarget.texture.width, xx g.renderTarget.texture.height}, .{0., 0., xx g.screenSize.x, xx g.screenSize.y}, .{}, 0., rl.WHITE);
            rl.DrawFPS(25,25);
        rl.EndDrawing();
    }
    return false;
}

