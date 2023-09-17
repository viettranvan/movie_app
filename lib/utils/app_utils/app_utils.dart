import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:movie_app/utils/utils.dart';

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

  Future<List<Color>> generatePalette(Map<String, dynamic> params) async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(
      generatePaletteColor,
      [receivePort.sendPort, params],
    );
    final palette = await receivePort.first as List<Color>;
    receivePort.close();
    isolate.kill();
    return palette;
  }

  Future<List<Color>> extractColors(Uint8List? bytes) async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(
      extractPixelsColor,
      [receivePort.sendPort, bytes],
    );
    final colors = await receivePort.first as List<Color>;
    receivePort.close();
    isolate.kill();
    return colors;
  }

  void generatePaletteColor(List<dynamic> arguments) {
    SendPort sendPort = arguments[0];
    Map<String, dynamic> params = arguments[1];
    List<Color> colors = [];
    List<Color> palette = [];
    colors.addAll(sortColors(params['palette']));
    int numberOfItems = params['numberOfItemsPixel'];
    if (numberOfItems <= colors.length) {
      final chunkSize = colors.length ~/ numberOfItems; // 16/16
      for (int i = 0; i < numberOfItems; i++) {
        final sublistColor = colors.sublist(i * chunkSize, (i + 1) * chunkSize);
        final averageColor = getAverageColor(sublistColor);
        palette.add(averageColor);
      }
    }
    sendPort.send(palette);
  }

  void extractPixelsColor(List<dynamic> arguments) {
    SendPort sendPort = arguments[0];
    Uint8List bytes = arguments[1];
    List<Color> colors = [];
    //decode image
    final values = bytes.buffer.asUint8List();
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
    sendPort.send(colors);
  }

  Future<double> getLuminance(List<Color> paletteColors) async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(
      getLuminanceColor,
      [receivePort.sendPort, paletteColors],
    );
    final averageLuminance = await receivePort.first as double;
    receivePort.close();
    isolate.kill();
    return averageLuminance;
  }

  void getLuminanceColor(List<dynamic> arguments) {
    SendPort sendPort = arguments[0];
    List<Color> paletteColors = arguments[1];
    double totalLuminance = 0;
    for (final paletteColor in paletteColors) {
      totalLuminance += paletteColor.computeLuminance();
    }
    double averageLuminance = totalLuminance / paletteColors.length;
    sendPort.send(averageLuminance);
  }

  String getSortTitle(String sortBy) {
    return sortBy.contains('created_at.desc') ? 'Newest' : 'Oldest';
  }

  String formatDate(String date) {
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.parse(date);
    var outputDateTime = DateFormat('dd-MM-yyyy').format(outputDate);
    return outputDateTime;
  }

  String getImageUrl(String? posterPath, String? profilePath) {
    return posterPath != null
        ? '${AppConstants.kImagePathPoster}$posterPath'
        : '${AppConstants.kImagePathPoster}$profilePath';
  }

  String getYearReleaseOrDepartment(
    String? releaseDate,
    String? firstAirDate,
    String mediaType,
    String? knownForDepartment,
  ) {
    switch (mediaType) {
      case 'movie':
        {
          return releaseDate != '' ? (releaseDate ?? '').substring(0, 4) : '';
        }

      case 'tv':
        {
          return firstAirDate != '' ? (firstAirDate ?? '').substring(0, 4) : '';
        }
      case 'person':
        {
          return knownForDepartment != '' || knownForDepartment != null
              ? '${(knownForDepartment)}'
              : '';
        }
      default:
        {
          return '';
        }
    }
  }

  showCustomDialog({
    required BuildContext context,
    required AlignmentGeometry alignment,
    Widget? child,
  }) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      useSafeArea: true,
      context: context,
      builder: (context) => Align(
        alignment: alignment,
        child: child,
      ),
    );
  }
}




  // List<Color> generatePalette(Map<String, dynamic> params) {
  //   List<Color> colors = [];
  //   List<Color> palette = [];
  //   colors.addAll(sortColors(params['palette']));
  //   int numberOfItems = params['numberOfItems'];
  //   if (numberOfItems <= colors.length) {
  //     final chunkSize = colors.length ~/ numberOfItems; // 16/16
  //     for (int i = 0; i < numberOfItems; i++) {
  //       final sublistColor = colors.sublist(i * chunkSize, (i + 1) * chunkSize);
  //       final averageColor = getAverageColor(sublistColor);
  //       palette.add(averageColor);
  //     }
  //   }
  //   return palette;
  // }

  // List<Color> extractPixelsColors(Uint8List? bytes) {
  //   List<Color> colors = [];
  //   //decode image
  //   final values = bytes!.buffer.asUint8List();
  //   final image = img.decodeImage(values);
  //   final pixels = [];
  //   int width = image?.width ?? 0;
  //   int height = image?.height ?? 0;
  //   int xChunk = (width ~/ (pixelsPerAxis + 1));
  //   int yChunk = (height ~/ (pixelsPerAxis + 1));
  //   for (int j = 1; j < pixelsPerAxis + 1; j++) {
  //     for (int i = 1; i < pixelsPerAxis + 1; i++) {
  //       int? pixel = image?.getPixel(xChunk * i, yChunk * j);
  //       pixels.add(pixel);
  //       colors.add(argbToColor(pixel!));
  //     }
  //   }

  //   return colors;
  // }

  // double getLuminance(List<Color> paletteColors) {
  //   double totalLuminance = 0;
  //   for (final paletteColor in paletteColors) {
  //     totalLuminance += paletteColor.computeLuminance();
  //   }
  //   double averageLuminance = totalLuminance / paletteColors.length;
  //   return averageLuminance;
  // }