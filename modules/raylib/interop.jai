// This file contains helpful overloads

InitWindow :: inline (width: s32, height: s32, title: string) {
   InitWindow(width, height, temp_c_string(title));
}

IsWindowState :: inline (flag: ConfigFlags) -> bool {
   return IsWindowState(cast(u32)flag);
}

SetWindowState :: inline (flags: ConfigFlags) {
   SetWindowState(cast(u32)flags);
}

ClearWindowState :: inline (flags: ConfigFlags) {
   ClearWindowState(cast(u32)flags);
}

SetWindowTitle :: inline (title: string) {
   SetWindowTitle(temp_c_string(title));
}

SetClipboardText :: inline (text: string) {
   SetWindowTitle(temp_c_string(text));
}

LoadShader :: inline (vsFileName: string, fsFileName: string) -> Shader {
   return LoadShader(temp_c_string(vsFileName), temp_c_string(fsFileName));
}

LoadShaderFromMemory :: inline (vsCode: string, fsCode: string) -> Shader {
   return LoadShaderFromMemory(temp_c_string(vsCode), temp_c_string(fsCode));
}

TakeScreenshot :: inline (fileName: string) {
   return TakeScreenshot(temp_c_string(fileName));
}

SetConfigFlags :: inline (flags: ConfigFlags) {
   SetConfigFlags(cast(s32)flags);
}

IsGamepadButtonPressed :: inline (gamepad: s32, button: GamepadButton) -> bool {
   return IsGamepadButtonPressed();
}

IsGamepadButtonDown :: inline (gamepad: s32, button: GamepadButton) -> bool {
   return IsGamepadButtonDown(gamepad, cast(s32)button);
}

IsGamepadButtonReleased :: inline (gamepad: s32, button: GamepadButton) -> bool {
   return IsGamepadButtonReleased(gamepad, cast(s32)button);
}

IsGamepadButtonUp :: inline (gamepad: s32, button: GamepadButton) -> bool {
   return IsGamepadButtonUp(gamepad, cast(s32)button);
}

IsKeyPressed :: inline (key: KeyboardKey) -> bool {
   return IsKeyPressed(cast(s32)key);
}

IsKeyDown :: inline (key: KeyboardKey) -> bool {
   return IsKeyDown(cast(s32)key);
}

IsKeyReleased :: inline (key: KeyboardKey) -> bool {
   return IsKeyReleased(cast(s32)key);
}

IsKeyUp :: inline (key: KeyboardKey) -> bool {
   return IsKeyUp(cast(s32)key);
}

SetExitKey :: inline (key: KeyboardKey) {
   SetExitKey(cast(s32)key);
}

IsGestureDetected :: inline (gesture: Gesture) -> bool {
   return IsGestureDetected(cast(s32)gesture);
}

SetCameraMode :: inline (camera: Camera, mode: CameraMode) {
   SetCameraMode(camera, cast(s32)mode);
}

LoadFont :: inline (fileName: string) -> Font {
   return LoadFont(temp_c_string(fileName));
}

LoadFontEx :: inline (fileName: string, fontSize: s32, fontChars: *s32, glyphCount: s32) -> Font {
   return LoadFontEx(temp_c_string(fileName), fontSize, fontChars, glyphCount);
}

ExportFontAsCode :: inline (font: Font, fileName: string) -> bool {
   return ExportFontAsCode(font, temp_c_string(fileName));
}

DrawTextEx :: inline (font: Font, text: string, position: Vector2, fontSize: float, spacing: float, tint: Color) {
   DrawTextEx(font, temp_c_string(text), position, fontSize, spacing, tint);
}

DrawTextPro :: inline (font: Font, text: string, position: Vector2, origin: Vector2, rotation: float, fontSize: float, spacing: float, tint: Color) {
   DrawTextPro(font, temp_c_string(text), position, origin, rotation, fontSize, spacing, tint);
}

MeasureText :: inline (text: string, fontSize: s32) -> s32 {
   return MeasureText(temp_c_string(text), fontSize);
}

MeasureTextEx :: inline (font: Font, text: string, fontSize: float, spacing: float) -> Vector2 {
   return MeasureTextEx(font, temp_c_string(text), fontSize, spacing);
}

LoadCodepoints :: inline (text: string, count: *s32) -> *s32 {
   return LoadCodepoints(temp_c_string(text), count);
}

GetCodepointCount :: inline (text: string) -> s32 {
   return GetCodepointCount(temp_c_string(text));
}

GetCodepoint :: inline (text: string, bytesProcessed: *s32) -> s32 {
   return GetCodepoint(temp_c_string(text), bytesProcessed);
}

LoadModel :: inline (fileName: string) -> Model {
   return LoadModel(temp_c_string(fileName));
}

ExportMesh :: inline (mesh: Mesh, fileName: string) -> bool {
   return ExportMesh(mesh, temp_c_string(fileName));
}

LoadMaterials :: inline (fileName: string, materialCount: *s32) -> *Material {
   return LoadMaterials(temp_c_string(fileName), materialCount);
}

LoadModelAnimations :: inline (fileName: string, animCount: *u32) -> *ModelAnimation {
   return LoadModelAnimations(temp_c_string(fileName), animCount);
}

LoadWave :: inline (fileName: string) -> Wave {
   return LoadWave(temp_c_string(fileName));
}

LoadSound :: inline (fileName: string) -> Sound {
   return LoadSound(temp_c_string(fileName));
}

ExportWave :: inline (wave: Wave, fileName: string) -> bool {
   return ExportWave(wave, temp_c_string(fileName));
}

LoadMusicStream :: inline (fileName: string) -> Music {
   return LoadMusicStream(temp_c_string(fileName));
}
