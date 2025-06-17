#module_parameters(WITH_INTEROP := false, WITH_EXTRAS := false);

#scope_export

va_list :: *void;

DARKGRAY   :: Color.{ 80, 80, 80, 255 };      // Dark Gray
YELLOW     :: Color.{ 253, 249, 0, 255 };     // Yellow
YELLOWISH  :: Color.{ 255, 255, 150, 255 };     // Yellow
GOLD       :: Color.{ 255, 203, 0, 255 };     // Gold
ORANGE     :: Color.{ 255, 161, 0, 255 };     // Orange
PINK       :: Color.{ 255, 109, 194, 255 };   // Pink
RED        :: Color.{ 230, 41, 55, 255 };     // Red
RED_CLEAR  :: Color.{ 230, 41, 55, 155 };     // Red with transparency
MAROON     :: Color.{ 190, 33, 55, 255 };     // Maroon
GREEN      :: Color.{ 0, 228, 48, 255 };      // Green
GREEN_CLEAR:: Color.{ 0, 228, 48, 155 };      // Green with transparency
LIME       :: Color.{ 0, 158, 47, 255 };      // Lime
DARKGREEN  :: Color.{ 0, 117, 44, 255 };      // Dark Green
SKYBLUE    :: Color.{ 102, 191, 255, 255 };   // Sky Blue
BLUE       :: Color.{ 0, 121, 241, 255 };     // Blue
BLUE_CLEAR :: Color.{ 0, 121, 241, 155 };     // Blue with transparency
DARKBLUE   :: Color.{ 0, 82, 172, 255 };      // Dark Blue
PURPLE     :: Color.{ 200, 122, 255, 255 };   // Purple
VIOLET     :: Color.{ 135, 60, 190, 255 };    // Violet
DARKPURPLE :: Color.{ 112, 31, 126, 255 };    // Dark Purple
BEIGE      :: Color.{ 211, 176, 131, 255 };   // Beige
BROWN      :: Color.{ 127, 106, 79, 255 };    // Brown
DARKBROWN  :: Color.{ 76, 63, 47, 255 };      // Dark Brown
WHITE      :: Color.{ 255, 255, 255, 255 };   // White
WHITE_CLEAR:: Color.{ 255, 255, 255, 155 };   // White with transparency
BLACK      :: Color.{ 0, 0, 0, 255 };         // Black
BLACK_CLEAR:: Color.{ 0, 0, 0, 205 };         // Black with transparency
BLACK_CLEAR_CLEAR:: Color.{ 0, 0, 0, 50 };         // Black with transparency
BLANK      :: Color.{ 0, 0, 0, 0 };           // Blank (Transparent)
MAGENTA    :: Color.{ 255, 0, 255, 255 };     // Magenta
RAYWHITE        :: Color.{ 245, 245, 245, 255 };
RAYWHITE_CLEAR  :: Color.{ 235, 235, 235, 225 };

#if OS == {
   case .WINDOWS;
      raylib :: #library,no_dll "win/raylib";
   case .MACOS;
      raylib :: #library,no_dll "mac/raylib";
   case .LINUX;
      raylib :: #library,no_dll "linux/raylib";
}

#load "raylib.jai";

#if WITH_INTEROP {
   #load "interop.jai";
}

#if WITH_EXTRAS {
   #load "extras.jai";
}

#if OS == .WINDOWS {
   user32  :: #library,system,link_always "user32";
   winmm   :: #library,system,link_always "winmm";
   gdi32   :: #library,system,link_always "gdi32";
   shell32 :: #library,system,link_always "shell32";
}
