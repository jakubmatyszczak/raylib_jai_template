TexId :: enum u32
{
    NONE :: 0;
    ATLAS_BOXES :: 1;
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
    c.textures[TexId.ATLAS_BOXES] = rl.LoadTexture("res/atlas_boxes.png");

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

