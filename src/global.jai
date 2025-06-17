TexId :: enum u32
{
    NONE :: 0;
    BOX :: 1;
}
SfxId :: enum u32
{
    NONE :: 0;
    BONK :: 1;
}
Content :: struct
{
    textures : [64]rl.Texture2D;
    sfx : [32]rl.Sound;
    shaders : [8]rl.Shader;
    music : [32]rl.Music;
}
content_init :: (c : *Content)
{
    c.textures[TexId.BOX] = rl.LoadTexture("res/box.png");

    c.sfx[SfxId.BONK] = rl.LoadSound("res/sfx/bonk.mp3");
}
sound_play :: (id: SfxId, volume: float = 1.0, pitch: float = 1.0)
{
    sound := g.content.sfx[id];
    rl.SetSoundVolume(sound, volume);
    rl.SetSoundPitch(sound, pitch);
    rl.PlaySound(sound);
}
Globals :: struct
{
    content : Content;
    camera : rl.Camera2D;
    cameraVel : Vector2;
    screenSize : Vector2;
    renderSize : Vector2;
    renderTarget : rl.RenderTexture2D;
    mouseScreen : Vector2;
    mouseWorld : Vector2;
    time : float;
}
g := Globals.{};

polarToXY :: (angle: float, radius : float) -> Vector2
{
    xy : Vector2 = ---;
    xy.x = sin(angle) * radius;
    xy.y = cos(angle) * radius;
    return xy;
}
radToDeg :: (angle: float) -> float
{
    ratio :: 180. / 3.14159;
    return angle * ratio;
}
clamp :: (min: float, max: float, value: float) -> float
{
    if value < min
        return min;
    if value > max
        return max;
    return value;
}
random_vector2 :: (range : float) -> Vector2
{
    return .{random_get_within_range(-range, range), random_get_within_range(-range, range)};
}
random_float :: (min: float = 0., max : float = 1.) -> float
{
    return random_get_within_range(min, max);
}

