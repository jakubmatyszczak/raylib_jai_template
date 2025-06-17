WIDTH  :: 1280;
HEIGHT :: 720;

main :: () {
   rl.InitWindow(WIDTH, HEIGHT, "Hello, from Jai!");
   defer rl.CloseWindow();

   rl.SetTargetFPS(60);

   ball_pos := rl.Vector2.{ x = WIDTH / 2, y = HEIGHT / 2 };

   while !rl.WindowShouldClose() {
      dt := rl.GetFrameTime();

      raw_dir: rl.Vector2;

      if rl.IsKeyDown(.W) then raw_dir.y -= 1;
      if rl.IsKeyDown(.S) then raw_dir.y += 1;
      if rl.IsKeyDown(.A) then raw_dir.x -= 1;
      if rl.IsKeyDown(.D) then raw_dir.x += 1;

      dir := rl.Vector2Normalize(raw_dir);
      ball_pos.x += dir.x * 200 * dt;
      ball_pos.y += dir.y * 200 * dt;

      rl.BeginDrawing();
         rl.ClearBackground(rl.RAYWHITE);
         rl.DrawText("Move the ball with WASD", 10, 10, 24, rl.BLACK);
         rl.DrawCircleV(ball_pos, 50, rl.RED);
      rl.EndDrawing();
   }
}

#import "Basic";

rl :: #import,file "../module.jai"(true);
