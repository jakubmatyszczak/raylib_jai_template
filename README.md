# Raylib + JAI + mEngine
This repository is a template for creating application using (currently 2D) framework mEngine, based on raylib.

# Features
A `DrawQueue`, to help out with:
- drawing (pos, rotation, scaling, tinting, frame-by-frame animating etc.),
- sorting (sprites covering each other),
- layering.

Texture Atlas:
- assembles all sprites (.png) in `res/images` into unified texture atlas during build `res/atlas.png`,
- sprites are added to `Atlas` struct, and `AtlasId` enum for easy access,
- `AtlasEntry` contains origin (in atlas.png) and size (Vector2) in pixels.
- easy access to pass to DrawQueue with `atlas_getTexture(AtlasId)`.

# Building 
Just do:
```
jai build.jai
```

