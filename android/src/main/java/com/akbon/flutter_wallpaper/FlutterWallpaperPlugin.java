package com.akbon.flutter_wallpaper;

import androidx.annotation.NonNull;

import android.annotation.SuppressLint;
import android.app.WallpaperManager;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.os.Build;

import java.io.IOException;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * A Flutter plugin for managing device wallpapers on Android.
 *
 * This plugin provides methods to set, clear, and retrieve wallpaper information
 * through a method channel.
 */
public class FlutterWallpaperPlugin implements FlutterPlugin, MethodCallHandler {

    private MethodChannel channel;
    private Context context;

    /**
     *  Initializes the plugin and sets up the method channel.
     *
     * @param flutterPluginBinding The binding that connects the plugin to Flutter.
     */
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        context = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_wallpaper");
        channel.setMethodCallHandler(this);
    }

    /**
     * Handles method calls from Flutter.
     *
     * This method is invoked when a method call is received over the method channel.
     * It delegates calls to specific handlers based on the method name.
     *
     * @param call The method call containing the method name and arguments.
     * @param result The result object used to return results to Flutter.
     */
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        }
        else if(call.method.equals("setWallpaperFromFile")){
            result.success(setWallpaperFromFile((String) call.argument("filePath"), (int) call.argument("wallpaperLocation")));
        }
        else if(call.method.equals("clearWallpaper")){
            result.success(clearWallpaper());
        }
        else if(call.method.equals("getDesiredMinimumHeight")){
            result.success(getDesiredMinimumHeight());
        }
        else if(call.method.equals("getDesiredMinimumWidth")){
            result.success(getDesiredMinimumWidth());
        }
        else {
            result.notImplemented();
        }
    }

    /**
     * Clears the method channel when the plugin is detached.
     *
     * @param binding The binding that connects the plugin to Flutter.
     */
    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    /**
     * Sets the device wallpaper from a file path.
     *
     * This method decodes the image from the file path, scales it to the correct
     * dimensions for the device wallpaper, and sets it as the device wallpaper.
     *
     * @param filePath The file path to the wallpaper image.
     * @param wallpaperLocation An integer representing where the wallpaper should be set.
     * @return An integer result, usually 1 on success and -1 on failure.
     */
    @SuppressLint("MissingPermission")
    private int setWallpaperFromFile(String filePath, int wallpaperLocation) {
        int result = -1;
        Bitmap originalBitmap = BitmapFactory.decodeFile(filePath);
        if (originalBitmap == null) {
            return -1;
        }

        WallpaperManager wm = WallpaperManager.getInstance(context);

        int desiredWidth = wm.getDesiredMinimumWidth();
        int desiredHeight = wm.getDesiredMinimumHeight();

        Bitmap scaledBitmap;
        scaledBitmap = scaleBitmap(originalBitmap, desiredWidth, desiredHeight);

        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                result = wm.setBitmap(scaledBitmap, null, false, wallpaperLocation);
            } else {
                wm.setBitmap(scaledBitmap);
                result = 1;
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            // Recycle bitmaps to free memory
            if (originalBitmap != null && !originalBitmap.isRecycled()){
                originalBitmap.recycle();
                originalBitmap = null;
            }
            if (scaledBitmap != null && !scaledBitmap.isRecycled()){
                scaledBitmap.recycle();
                scaledBitmap = null;
            }
        }
        return result;
    }
    /**
     * Scales a bitmap to the desired width and height.
     *
     * @param bitmap The original Bitmap to be scaled.
     * @param desiredWidth The desired width for the scaled Bitmap.
     * @param desiredHeight The desired height for the scaled Bitmap.
     * @return The scaled Bitmap.
     */
    private Bitmap scaleBitmap(Bitmap bitmap, int desiredWidth, int desiredHeight){
        int bitmapWidth = bitmap.getWidth();
        int bitmapHeight = bitmap.getHeight();

        float scaleWidth = ((float) desiredWidth) / bitmapWidth;
        float scaleHeight = ((float) desiredHeight) / bitmapHeight;
        float scaleFactor = Math.max(scaleWidth, scaleHeight);

        Matrix matrix = new Matrix();
        matrix.postScale(scaleFactor, scaleFactor);
        Bitmap scaledBitmap = Bitmap.createBitmap(bitmap, 0, 0, bitmapWidth, bitmapHeight, matrix, true);

        return scaledBitmap;
    }

    /**
     * Clears the device wallpaper.
     *
     * This method calls the system's `WallpaperManager` to clear the current wallpaper.
     *
     * @return A boolean, `true` if successful, `false` otherwise
     */
    @SuppressLint("MissingPermission")
    private boolean clearWallpaper() {
        Boolean result = false;
        WallpaperManager wm = WallpaperManager.getInstance(context);
        try {
            wm.clear();
            result = true;
        } catch (IOException e) {
            // Log exception
        }
        return result;
    }

    /**
     * Gets the desired minimum height for the device wallpaper.
     *
     * @return The desired minimum height of the wallpaper.
     */
    @SuppressLint("MissingPermission")
    private int getDesiredMinimumHeight() {
        WallpaperManager wm = WallpaperManager.getInstance(context);
        return wm.getDesiredMinimumHeight();
    }

    /**
     * Gets the desired minimum width for the device wallpaper.
     *
     * @return The desired minimum width of the wallpaper.
     */
    @SuppressLint("MissingPermission")
    private int getDesiredMinimumWidth() {
        WallpaperManager wm = WallpaperManager.getInstance(context);
        return wm.getDesiredMinimumWidth();
    }
}