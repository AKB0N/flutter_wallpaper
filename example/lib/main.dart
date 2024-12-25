import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_wallpaper/flutter_wallpaper.dart';

/// The main entry point of the application.
void main() {
  runApp(MyApp());
}

/// The root widget of the application.
///
/// This widget is stateful and manages the application's UI and state.
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

/// The state class for the `MyApp` widget.
///
/// This class holds the mutable state for the `MyApp` widget and provides
/// methods to initialize, update, and interact with the UI.
class _MyAppState extends State<MyApp> {
  //----------------------------------------------------------------------------
  // State Variables
  //----------------------------------------------------------------------------

  /// Stores the platform version, retrieved from the native side.
  String _platformVersion = 'Unknown';

  /// Stores the height and width of the wallpaper image.
  String __heightWidth = "Unknown";

  /// Stores the size of the wallpaper image as a human-readable string.
  String __size = "Unknown";

  /// The URL of the wallpaper image to be displayed and used.
  String imageURL =
      "https://raw.githubusercontent.com/AKB0N/Mo-Salah-Wallpapers/refs/heads/master/pixel/1.png";

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
    String _heightWidth;
    String _size;

    // Fetch platform version
    try {
      platformVersion =
          await WallpaperManager.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // Fetch image height, width, and size
    try {
      int height = await WallpaperManager.getWallpaperHeight(imageURL);
      int width = await WallpaperManager.getWallpaperWidth(imageURL);
      String size = await WallpaperManager.getWallpaperSize(imageURL);

      _size = "Size = " + size.toString();
      _heightWidth =
          "Width = " + width.toString() + " Height = " + height.toString();
    } on PlatformException {
      _size = "Failed to get Size";
      _heightWidth = "Failed to get Height and Width";
    }

    // Update state if the widget is still mounted.
    if (!mounted) return;

    setState(() {
      __size = _size;
      __heightWidth = _heightWidth;
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
              SizedBox(
                height: 10,
              ),
              Text('$__heightWidth\n'),
              Text('$__size\n'),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () => {
                        WallpaperManager.setWallpaper(
                          imageURL,
                          WallpaperManager.BOTH_SCREEN,
                        )
                      },
                  child: Text("Set Wallpaper")),
              TextButton(
                  onPressed: () => {
                        WallpaperManager.downloadWallpaper(
                          imageURL,
                          'test',
                          100,
                        )
                      },
                  child: Text("Download Wallpaper")),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
