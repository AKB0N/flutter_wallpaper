# flutter_wallpaper

A Flutter plugin for managing device wallpapers.

[![pub package](https://img.shields.io/pub/v/flutter_wallpaper.svg)](https://pub.dev/packages/flutter_wallpaper)
[![License: BSD](https://img.shields.io/badge/License-BSD-yellow.svg)](https://opensource.org/license/bsd-3-clause)

This plugin provides a simple and efficient way to set, download, clear, and retrieve information about device wallpapers in your Flutter applications. It supports setting wallpapers for the home screen, lock screen, or both.

## Features

-   **Set Wallpaper from URL:** Download an image from a URL and set i
-   **Download Wallpaper:** Download an image from a URL and save it to the device's gallery.
-   **Clear Wallpaper:** Remove the current device wallpaper.
-   **Get Wallpaper Dimensions:** Retrieve the height and width of an image from a URL.
-   **Get Wallpaper Size:** Get the file size of an image from a URL.
-   **Supports Home, Lock and Both Screens**: Allows setting the wallpaper to Home screen, Lock screen or Both.

## Installation

Add `flutter_wallpaper` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_wallpaper: ^0.0.5
```

Then, run `flutter pub get` in your terminal.

## Usage

Here's how to use the `WallpaperManager` class in your Flutter project:

### Initialization

There is no need to do initialization.

### Setting a Wallpaper

#### From a URL

```dart
import 'package:flutter_wallpaper/flutter_wallpaper.dart';

void setWallpaperFromUrl() async {
  String imageUrl = 'https://raw.githubusercontent.com/AKB0N/Mo-Salah-Wallpapers/refs/heads/master/pixel/1.png'; // Replace with your image URL
  int wallpaperLocation = WallpaperManager.bothScreen; // Use homeScreen, lockScreen, or bothScreen

  await WallpaperManager.setWallpaper(imageUrl, wallpaperLocation);
}
```

### Downloading a Wallpaper

```dart
import 'package:flutter_wallpaper/flutter_wallpaper.dart';

void downloadWallpaper() async {
  String imageUrl = 'https://raw.githubusercontent.com/AKB0N/Mo-Salah-Wallpapers/refs/heads/master/pixel/1.png'; // Replace with your image URL
  String imageName = 'my_wallpaper.jpg'; // Desired file name
  int quality = 100; // Image quality (0-100)

  await WallpaperManager.downloadWallpaper(imageUrl, imageName, quality);
}
```

### Clearing the Wallpaper

```dart
import 'package:flutter_wallpaper/flutter_wallpaper.dart';

void clearWallpaper() async {
  bool success = await WallpaperManager.clearWallpaper();

  if(success) {
    print('Wallpaper cleared successfully!');
  } else {
    print('Failed to clear wallpaper.');
  }
}
```

### Getting Wallpaper Information

#### Get Height

```dart
import 'package:flutter_wallpaper/flutter_wallpaper.dart';

void getWallpaperHeight() async {
  String imageUrl = 'https://raw.githubusercontent.com/AKB0N/Mo-Salah-Wallpapers/refs/heads/master/pixel/1.png'; // Replace with your image URL
  int? height = await WallpaperManager.getWallpaperHeight(imageUrl);

  if(height != null) {
    print('Wallpaper height: $height');
  } else {
    print('Failed to get wallpaper height.');
  }
}
```

#### Get Width

```dart
import 'package:flutter_wallpaper/flutter_wallpaper.dart';

void getWallpaperWidth() async {
  String imageUrl = 'https://raw.githubusercontent.com/AKB0N/Mo-Salah-Wallpapers/refs/heads/master/pixel/1.png'; // Replace with your image URL
  int? width = await WallpaperManager.getWallpaperWidth(imageUrl);

  if(width != null) {
     print('Wallpaper width: $width');
  } else {
     print('Failed to get wallpaper width.');
  }
}
```

#### Get Size

```dart
import 'package:flutter_wallpaper/flutter_wallpaper.dart';

void getWallpaperSize() async {
  String imageUrl = 'https://raw.githubusercontent.com/AKB0N/Mo-Salah-Wallpapers/refs/heads/master/pixel/1.png'; // Replace with your image URL
  String? size = await WallpaperManager.getWallpaperSize(imageUrl);

  if (size != null) {
    print('Wallpaper size: $size');
  } else {
    print('Failed to get wallpaper size.');
  }
}
```

## Constants

The following constants are available within the `WallpaperManager` class:

-   `WallpaperManager.homeScreen`: Represents the home screen wallpaper location.
-   `WallpaperManager.lockScreen`: Represents the lock screen wallpaper location.
-   `WallpaperManager.bothScreen`: Represents both the home and lock screen wallpaper locations.

## Permissions

This plugin relies on the following permissions:

  **Android:**
  -   `<uses-permission
        android:name="android.permission.SET_WALLPAPER"/>` (for setting wallpapers)
  -   `<uses-permission
        android:name="android.permission.WRITE_EXTERNAL_STORAGE"
        android:maxSdkVersion="29"/>` (for downloading images)

  **iOS:**
  -   **Setting Wallpaper:** Due to Apple's security restrictions, programmatically setting the wallpaper on iOS is **not supported**. This plugin cannot change the home screen or the lock screen wallpaper on iOS.
  -   **Downloading Wallpapers:** Downloading and saving Wallpapers to the photo gallery is fully supported on iOS using this package.
  -   Permission for saving an image to gallery is required: add this to `ios/Runner/Info.plist`
       ```xml
       <key>NSPhotoLibraryAddUsageDescription</key>
       <string>This app requires photo library access to save the wallpaper.</string>
       ```

## Platform Notes

   **Android:** This plugin works seamlessly on all supported Android versions.
   
   **iOS:**
  -   **Downloading Wallpapers:** Downloading and saving Wallpapers to the photo gallery is fully supported on iOS using this package.

## Contributing

Contributions are welcome! If you find a bug or have a feature request, please open an issue on GitHub. Feel free to submit pull requests with improvements or fixes.

## Developer
By [Ibrahim Fathelbab](https://www.akbon.dev/ "Ibrahim Fathelbab")

&copy; All rights reserved.