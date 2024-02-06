import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';

class OctonaryItem extends StatelessWidget {
  final VoidCallback? onTapItem;
  final String? title;
  final List<Color>? colors;
  final List<double>? stops;
  const OctonaryItem({
    super.key,
    this.onTapItem,
    required this.title,
    this.colors,
    this.stops,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: Container(
        width: 150.w,
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: lightGreyColor,
              blurRadius: 5,
            ),
          ],
        ),
        child: CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w780/dQeAar5H991VYporEjUspolDarG.jpg',
          // imageUrl: imageUrl,
          width: double.infinity,
          height: double.infinity,
          filterQuality: FilterQuality.high,
          fit: BoxFit.fill,
          progressIndicatorBuilder: (context, url, progress) => const CustomIndicator(),
          errorWidget: (context, url, error) => Image.asset(
            ImagesPath.noImage.assetName,
            width: double.infinity,
            height: double.infinity,
            filterQuality: FilterQuality.high,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
