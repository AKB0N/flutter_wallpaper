import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_wallpaper/flutter_wallpaper.dart';

/// The main entry point of the application.
void main() {
  runApp(const MyApp());
}

/// The root widget of the application.
///
/// This widget is stateful and manages the application's UI and state.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

/// The state class for the `MyApp` widget.
///
/// This class holds the mutable state for the `MyApp` widget and provides
/// methods to initialize, update, and interact with the UI.
class MyAppState extends State<MyApp> {
  //----------------------------------------------------------------------------
  // State Variables
  //----------------------------------------------------------------------------

  /// Stores the platform version, retrieved from the native side.
  String _platformVersion = 'Unknown';

  /// Stores the height and width of the wallpaper image.
  String __heightWidth = 'Unknown';

  /// Stores the size of the wallpaper image as a human-readable string.
  String __size = 'Unknown';

  /// The URL of the wallpaper image to be displayed and used.
  String imageURL =
      'https://raw.githubusercontent.com/AKB0N/Mo-Salah-Wallpapers/refs/heads/master/pixel/1.png';

  //----------------------------------------------------------------------------
  // Initialization
  //----------------------------------------------------------------------------

  /// Initializes the state of the widget and fetches initial data.
  ///
  /// Overrides the default `initState` method to call `initAppState`
  /// after the widget has been inserted into the tree.
  @override
  void initState() {
    super.initState();
    initAppState();
  }

  void clearWallpaper() async {
    bool success = await WallpaperManager.clearWallpaper();

    if (success) {
      debugPrint('Wallpaper cleared successfully!');
    } else {
      debugPrint('Failed to clear wallpaper.');
    }
  }

  //----------------------------------------------------------------------------
  // Initial App State Setup
  //----------------------------------------------------------------------------

  /// Asynchronously initializes the app state by fetching platform version,
  ///  image dimensions, and image size.
  ///
  /// It catches PlatformExceptions that can occur during method calls and sets
  /// default values for the state variables in case of exceptions.
  Future<void> initAppState() async {
    String platformVersion;
    String heightWidth;
    String size;

    // Fetch platform version
    try {
      platformVersion =
          await WallpaperManager.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // Fetch image height, width, and size
    try {
      int getHeight = await WallpaperManager.getWallpaperHeight(imageURL);
      int getWidth = await WallpaperManager.getWallpaperWidth(imageURL);
      String getSize = await WallpaperManager.getWallpaperSize(imageURL);

      size = 'Size = $getSize';
      heightWidth = 'Width = $getWidth Height = $getHeight';
    } on PlatformException {
      size = 'Failed to get Size';
      heightWidth = 'Failed to get Height and Width';
    }

    // Update state if the widget is still mounted.
    if (!mounted) return;

    setState(() {
      __size = size;
      __heightWidth = heightWidth;
      _platformVersion = platformVersion;
    });
  }

  //----------------------------------------------------------------------------
  // Build Widget UI
  //----------------------------------------------------------------------------

  /// Builds the user interface for the application.
  ///
  /// This method constructs the visual structure of the app, which includes
  /// an AppBar, an Image widget, Text widgets to display information, and several
  /// TextButton widgets for interacting with the WallpaperManager.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(imageURL),
              Text('Running on: $_platformVersion\n'),
              const SizedBox(
                height: 10,
              ),
              Text('$__heightWidth\n'),
              Text('$__size\n'),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () => {
                        WallpaperManager.setWallpaper(
                          imageURL,
                          WallpaperManager.bothScreen,
                        )
                      },
                  child: const Text('Set Wallpaper')),
              TextButton(
                  onPressed: () => {
                        WallpaperManager.downloadWallpaper(
                          imageURL,
                          'test',
                          100,
                        )
                      },
                  child: const Text('Download Wallpaper')),
              TextButton(
                  onPressed: () => {clearWallpaper()},
                  child: const Text('Clear Wallpaper')),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
