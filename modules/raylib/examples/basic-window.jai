main :: () {
   rl.InitWindow(1280, 720, "Hello, Jai!");
   defer rl.CloseWindow();

   rl.SetTargetFPS(60);

   while !rl.WindowShouldClose() {
      rl.BeginDrawing();
      rl.ClearBackground(rl.RAYWHITE);
      rl.DrawText("Hello, from Jai!", 10, 10, 24, rl.BLACK);
      rl.EndDrawing();
   }
}

rl :: #import,file "../module.jai"(WITH_INTEROP = true);
