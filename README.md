# Flutter Wallpaper Plugin

A Flutter plugin for managing device wallpapers on Android and iOS. This plugin allows you to set, clear, download, and retrieve information about wallpapers programmatically.

## Features

-   **Set Wallpaper:** Set a wallpaper from a local file to the home screen, lock screen, or both.
-   **Clear Wallpaper:** Remove the current wallpaper.
-   **Download Wallpaper:** Download an image from a URL and save it to the gallery.
-   **Get Wallpaper Dimensions:** Retrieve the height and width of a wallpaper image from a URL.
-   **Get Wallpaper Size:** Retrieve the size of a wallpaper image from a URL as a human-readable string (e.g., "1.2 MB").
-   **Platform Version:** Get the device's platform version.

## Installation

Add the plugin to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_wallpaper:
    git:
      url: https://github.com/<your_github_username>/flutter_wallpaper.git # Replace with your repository URL
      ref: main # Replace with your branch
```

Then, run flutter pub get in your terminal.

* Usage
* Setting the Wallpaper

```dart
import 'package:flutter_wallpaper/flutter_wallpaper.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  String imageUrl = "https://example.com/wallpaper.jpg";
  File file = await DefaultCacheManager().getSingleFile(imageUrl);
  // Set wallpaper to home screen
  bool success = await WallpaperManager.setWallpaperFromFile(file.path, WallpaperManager.HOME_SCREEN);
  print("Set wallpaper to home screen: $success");

  // Set wallpaper to lock screen
  success = await WallpaperManager.setWallpaperFromFile(file.path, WallpaperManager.LOCK_SCREEN);
    print("Set wallpaper to lock screen: $success");

  // Set wallpaper to both screens
   success = await WallpaperManager.setWallpaperFromFile(file.path, WallpaperManager.BOTH_SCREEN);
  print("Set wallpaper to both screen: $success");
}
```

* Clearing the Wallpaper

```dart
import 'package:flutter_wallpaper/flutter_wallpaper.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  bool success = await WallpaperManager.clearWallpaper();
  print("Wallpaper cleared: $success");
}
```

* Downloading a Wallpaper

```dart
import 'package:flutter_wallpaper/flutter_wallpaper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String imageUrl = "https://example.com/wallpaper.jpg";
  await WallpaperManager.downloadWallpaper(imageUrl, "my_wallpaper", 100);
  print("Wallpaper downloaded and saved to gallery.");
}
```

* Getting Wallpaper Information

```dart
import 'package:flutter_wallpaper/flutter_wallpaper.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  String imageUrl = "https://example.com/wallpaper.jpg";

  String? size = await WallpaperManager.getWallpaperSize(imageUrl);
  print("Wallpaper size: $size");

  int? height = await WallpaperManager.getWallpaperHeight(imageUrl);
  print("Wallpaper height: $height");

    int? width = await WallpaperManager.getWallpaperWidth(imageUrl);
  print("Wallpaper width: $width");
}
```

Getting Platform Version

```dart
import 'package:flutter_wallpaper/flutter_wallpaper.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  String? version = await WallpaperManager.platformVersion;
  print("Platform version: $version");
}
```

* Constants
- WallpaperManager.HOME_SCREEN: Constant representing the home screen wallpaper location.
- WallpaperManager.LOCK_SCREEN: Constant representing the lock screen wallpaper location.
- WallpaperManager.BOTH_SCREEN: Constant representing both home and lock screen wallpaper locations.

* API Reference
WallpaperManager Class
static Future<String?> get platformVersion

- Retrieves the platform version of the device.
- Returns: A String representing the platform version, or null if it cannot be retrieved.

static Future<bool> setWallpaperFromFile(String filePath, int wallpaperLocation)

- Sets the device wallpaper using the provided file path and location.
- filePath: The path to the image file.
- wallpaperLocation: Where to set the wallpaper (e.g., HOME_SCREEN, LOCK_SCREEN, BOTH_SCREEN).
- Returns: true if successful, false otherwise.

static Future<void> downloadWallpaper(String wallpaperUrl, String wallpaperName, int quality)

- Downloads a wallpaper image from the given URL and saves it to the device's gallery.
- wallpaperUrl: The URL of the wallpaper image.
- wallpaperName: The desired file name for the saved image.
- quality: The quality of the saved image (0-100).

static Future<bool> clearWallpaper()

- Clears the current wallpaper on the device.
- Returns: true if successful, false otherwise.

static Future<int?> getWallpaperHeight(String url)

- Retrieves the height of an image from the given URL.
- url: The URL of the image.
- Returns: The height of the image or null if an error occurs.

static Future<int?> getWallpaperWidth(String url)

- Retrieves the width of an image from the given URL.
- url: The URL of the image.
- Returns: The width of the image or null if an error occurs.

static Future<String?> getWallpaperSize(String url)

- Retrieves the size of an image from the given URL as a human-readable string.
- url: The URL of the image.
- Returns: A formatted string representing the size of the image (e.g., "1.2 MB") or null if an error occurs.

* Permissions
* Android

- The plugin requires the following permissions:
    - android.permission.SET_WALLPAPER
    - android.permission.READ_EXTERNAL_STORAGE.
- These permissions should be automatically added during the plugin installation.

* iOS
- There are no extra permissions needed in iOS

* Issues and Contributions
If you encounter any issues or have suggestions, please feel free to open an issue or submit a pull request on the GitHub repository.

* License
This plugin is licensed under the MIT License.

**Changes Made:**

-   **Removed "iOS Only" Notes:** All mentions of "iOS Only" for the `downloadWallpaper` method have been removed.
-   **Clear Functionality:** The description and feature lists now state that the plugin supports downloading wallpapers on both platforms.

**Important Considerations:**

*   **Testing:** It's essential to thoroughly test the download functionality on various Android devices and versions to ensure its stability.
*   **Error Handling:** Make sure your plugin has robust error handling in place to catch any exceptions or issues that might arise during download or saving operations.

