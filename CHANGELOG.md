## 0.0.8
* Added commas for better formatting in method calls and parameters.

## 0.0.7
* Fix for [Issue 1](https://github.com/AKB0N/flutter_wallpaper/issues/1).
  In `image_gallery_saver`, build with GradleKotlinCompilerWorkAction.
- Updated the Flutter SDK constraint to `>=3.7.2 <4.0.0`.
- Updated the minimum Flutter version to `>=3.29.3`.
- Replaced `image_gallery_saver_plus` with `flutter_image_gallery_saver` dependency, now at version `0.0.2`.
- Adjusted `ndkVersion` to `"27.0.12077973"` in `example/android/app/build.gradle`.

## 0.0.6
* Updated `image_gallery_saver` to `image_gallery_saver_plus` version `3.0.5`.
- Replaced `ImageGallerySaver.saveImage` with `ImageGallerySaverPlus.saveImage` in `flutter_wallpaper.dart`.

## 0.0.5
* Remove cached_network_image dependency
- Removed `cached_network_image` from `pubspec.yaml` dependencies.
- Removed unused dependency from the project.

## 0.0.4
* Update example app and refactor wallpaper management
- Updated the example app to display and fetch wallpaper details, such as height, width, and size.
- Refactored wallpaper management constants to use camelCase: `homeScreen`, `lockScreen`, and `bothScreen`.
- Refactored code to use debugPrint.
- Added error handling for wallpaper operations.
- Added error message if getting the platform version fails.

## 0.0.3
* fix README.md

## 0.0.2
* Update dependencies and enhance error handling
- Updated `flutter_cache_manager` to version `3.4.1`.
- Updated `cached_network_image` to version `3.4.1`.
- Updated `image_gallery_saver` to version `2.0.3`.
- Improved error handling for `getWallPaperHeight`, `getWallPaperWidth`, and `getWallPaperSize` methods to throw exceptions when encountering issues instead of returning null.

## 0.0.1
* Open beta release of the `Flutter Wallpaper` plugin.
  Please see the [README](https://github.com/AKB0N/flutter_wallpaper/blob/main/README.md) for updated integration steps.
```bash
flutter pub add flutter_wallpaper
```