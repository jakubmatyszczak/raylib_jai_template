# Raylib

[Raylib](https://www.raylib.com) 5.0 bindings for Jai.

## Usage

See: `examples/`

## Notes

- These are generated using Jai's `Bindings_Generator` library (`jai generate.jai`)
- `extras.jai` contains auto-generated macros for Begin/End procs
- `interop.jai` contains overloads to make calling into Raylib easier

To generate bindings for a different version:

- Place headers in `lib/` and dynamic libraries in `win/`, `mac/`, or `linux/`
- Change `LIBRARY_NAME` in `generate.jai` to match the dynamic library's name (no extension)
- Run `jai generate.jai`
