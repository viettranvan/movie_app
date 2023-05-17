import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class AppUtils {
  static final AppUtils _instance = AppUtils._();
  AppUtils._();
  factory AppUtils() => _instance;
  int pixelsPerAxis = 8;
  Color getAverageColor(List<Color> colors) {
    int r = 0, g = 0, b = 0, a = 0;
    for (int i = 0; i < colors.length; i++) {
      r += colors[i].red; // all red of image
      g += colors[i].green; // all green of image
      b += colors[i].blue; // all blue of image
      a += colors[i].alpha; // all alpha of image
    }
    r = r ~/ colors.length; // average red of image
    g = g ~/ colors.length; // average green of image
    b = b ~/ colors.length; // average blue of image
    a = a ~/ colors.length; // average alpha of image
    return Color.fromARGB(a, r, g, b);
  }

  Color argbToColor(int argbColor) {
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    int hex = (argbColor & 0xFF00FF00) | (b << 16) | r;
    return Color(hex);
  }

  List<Color> sortColors(List<Color> colors) {
    List<Color> sorted = [];
    sorted.addAll(colors);
    sorted.sort((a, b) => b.computeLuminance().compareTo(a.computeLuminance()));
    return sorted;
  }

  List<Color> generatePalette(Map<String, dynamic> params) {
    List<Color> colors = [];
    List<Color> palette = [];
    colors.addAll(sortColors(params['palette']));
    int numberOfItems = params['numberOfItems'];
    if (numberOfItems <= colors.length) {
      final chunkSize = colors.length ~/ numberOfItems; // 16/16
      for (int i = 0; i < numberOfItems; i++) {
        final sublistColor = colors.sublist(i * chunkSize, (i + 1) * chunkSize);
        final averageColor = getAverageColor(sublistColor);
        palette.add(averageColor);
      }
    }
    return palette;
  }

  List<Color> extractPixelsColors(Uint8List? bytes) {
    List<Color> colors = [];
    //decode image
    final values = bytes!.buffer.asUint8List();
    final image = img.decodeImage(values);
    final pixels = [];
    int width = image?.width ?? 0;
    int height = image?.height ?? 0;
    int xChunk = (width ~/ (pixelsPerAxis + 1));
    int yChunk = (height ~/ (pixelsPerAxis + 1));
    for (int j = 1; j < pixelsPerAxis + 1; j++) {
      for (int i = 1; i < pixelsPerAxis + 1; i++) {
        int? pixel = image?.getPixel(xChunk * i, yChunk * j);
        pixels.add(pixel);
        colors.add(argbToColor(pixel!));
      }
    }

    return colors;
  }

  double getLuminance(List<Color> paletteColors) {
    double totalLuminance = 0;
    for (final paletteColor in paletteColors) {
      totalLuminance += paletteColor.computeLuminance();
    }
    double averageLuminance = totalLuminance / paletteColors.length;
    return averageLuminance;
  }

  String getSortTitle(String sortBy) {
    if (sortBy.contains('created_at.desc')) {
      return 'Newest';
    } else {
      return 'Oldest';
    }
  }
}
