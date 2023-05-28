import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';

class GridItem extends StatelessWidget {
  final String imageUrl;
  final String? title;
  final String? releaseYear;
  final VoidCallback? onTap;
  const GridItem({
    super.key,
    required this.imageUrl,
    this.onTap,
    this.title,
    this.releaseYear,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RepaintBoundary(
        child: IntrinsicHeight(
          child: SizedBox(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: darkWhiteColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: lightGreyColor,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                      height: 240,
                      width: double.infinity,
                      progressIndicatorBuilder: (context, url, prgress) => const CustomIndicator(),
                      errorWidget: (context, url, error) => const CustomIndicator(),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: title,
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 15,
                        ),
                      ),
                      const WidgetSpan(
                        child: SizedBox(width: 5),
                      ),
                      TextSpan(
                        text: releaseYear,
                        style: TextStyle(
                          color: greyColor,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
