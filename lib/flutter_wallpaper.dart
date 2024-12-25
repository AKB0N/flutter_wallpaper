import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

/// A Flutter plugin for managing device wallpapers.
///
/// This class provides methods for setting, downloading, clearing, and
/// retrieving information about wallpapers.
class WallpaperManager {
  //----------------------------------------------------------------------------
  // Constants
  //----------------------------------------------------------------------------

  /// Method channel used for communication with platform-specific code.
  static const MethodChannel _channel =
      const MethodChannel('flutter_wallpaper');

  /// Constant representing the home screen wallpaper location.
  static int HOME_SCREEN = 1;

  /// Constant representing the lock screen wallpaper location.
  static int LOCK_SCREEN = 2;

  /// Constant representing both home and lock screen wallpaper locations.
  static int BOTH_SCREEN = 3;

  //----------------------------------------------------------------------------
  // Platform Version Retrieval
  //----------------------------------------------------------------------------

  /// Returns the platform version of the device.
  ///
  /// This method uses a method call to native code to retrieve the platform
  /// version.
  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  //----------------------------------------------------------------------------
  // Set Wallpaper
  //----------------------------------------------------------------------------

  /// Sets the device wallpaper using the provided file path and location.
  ///
  /// The [filePath] argument specifies the path to the image file.
  /// The [wallpaperLocation] argument specifies where to set the wallpaper
  ///  (e.g., home screen, lock screen, both).
  /// Returns `true` if the wallpaper is set successfully, `false` otherwise.
  static Future<bool> setWallpaperFromFile(
      String filePath, int wallpaperLocation) async {
    final int result = await _channel.invokeMethod('setWallpaperFromFile',
        {'filePath': filePath, 'wallpaperLocation': wallpaperLocation});
    return result > 0 ? true : false;
  }

  //----------------------------------------------------------------------------
  // Set Wallpaper
  //----------------------------------------------------------------------------

  /// Asynchronously sets the device wallpaper using a URL.
  ///
  /// It uses the `WallpaperManager` to download the image from the given URL
  /// and sets it as the wallpaper for both home and lock screens.
  ///  Errors from the native side are caught.
  static Future<void> setWallpaper(imageURL, location) async {
    try {
      var file = await DefaultCacheManager().getSingleFile(imageURL);
      final bool result = await WallpaperManager.setWallpaperFromFile(
        file.path,
        location,
      );
      print(result);
    } on PlatformException {}
  }

  //----------------------------------------------------------------------------
  // Download Wallpaper
  //----------------------------------------------------------------------------

  /// Downloads a wallpaper image from the given URL and saves it to the device's gallery.
  ///
  /// The [wallpaperUrl] argument is the URL of the wallpaper image.
  /// The [wallpaperName] argument is the desired file name for the saved image.
  /// The [quality] argument specifies the quality of the saved image.
  static Future<void> downloadWallpaper(
      wallpaperUrl, wallpaperName, quality) async {
    File file = await DefaultCacheManager().getSingleFile(wallpaperUrl);
    Uint8List bytes = file.readAsBytesSync();
    await ImageGallerySaver.saveImage(
      bytes,
      quality: quality,
      name: wallpaperName,
    );
  }

  //----------------------------------------------------------------------------
  // Clear Wallpaper
  //----------------------------------------------------------------------------

  /// Clears the current wallpaper on the device.
  ///
  /// Returns `true` if the wallpaper is cleared successfully, `false` otherwise.
  static Future<bool> clearWallpaper() async {
    final bool result = await _channel.invokeMethod('clearWallpaper');
    return result;
  }

  //----------------------------------------------------------------------------
  // Get Wallpaper Height
  //----------------------------------------------------------------------------

  /// Retrieves the height of an image from the given URL.
  ///
  /// The [url] argument is the URL of the image.
  /// Returns the height of the image or `null` if an error occurs during retrieval.
  static Future<int> getWallpaperHeight(url) async {
    try {
      File image = await DefaultCacheManager().getSingleFile(url);
      var imageResolution = await decodeImageFromList(image.readAsBytesSync());
      int height = imageResolution.height;
      return height;
    } on Exception catch (err) {
      debugPrint(
          '$err,WallpapersSelected: Wallpaper will reload after Connection return.');
      return Future.value(null);
    }
  }

  //----------------------------------------------------------------------------
  // Get Wallpaper Width
  //----------------------------------------------------------------------------

  /// Retrieves the width of an image from the given URL.
  ///
  /// The [url] argument is the URL of the image.
  /// Returns the width of the image or `null` if an error occurs during retrieval.
  static Future<int> getWallpaperWidth(url) async {
    try {
      File image = await DefaultCacheManager().getSingleFile(url);
      var imageResolution = await decodeImageFromList(image.readAsBytesSync());
      int width = imageResolution.width;
      return width;
    } on Exception catch (err) {
      debugPrint(
          '$err,WallpapersSelected: Wallpaper will reload after Connection return.');
      return Future.value(null);
    }
  }

  //----------------------------------------------------------------------------
  // Get Wallpaper Size
  //----------------------------------------------------------------------------

  /// Retrieves the size of an image from the given URL as a human-readable string.
  ///
  /// The [url] argument is the URL of the image.
  /// Returns a formatted string representing the size of the image
  ///  (e.g., "1.2 MB"). Returns `null` if an error occurs during retrieval.
  static Future<String> getWallpaperSize(url) async {
    try {
      File image = await DefaultCacheManager().getSingleFile(url);
      String wallpaperSize = 'Loading...';
      int imageBytes = await image.length();
      if (imageBytes <= 0) '0 B';
      const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
      var i = (log(imageBytes) / log(1024)).floor();
      wallpaperSize =
          '${(imageBytes / pow(1024, i)).toStringAsFixed(1)} ${suffixes[i]}';
      return wallpaperSize;
    } on Exception catch (err) {
      debugPrint(
          '$err,WallpapersSelected: Wallpaper will reload after Connection return.');
      return Future.value(null);
    }
  }
}
