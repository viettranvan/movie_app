import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class ItemPopular extends StatelessWidget {
  final VoidCallback? onTap;
  final String urlImage;
  const ItemPopular({
    super.key,
    this.onTap,
    required this.urlImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: CachedNetworkImage(
          imageUrl: urlImage,
          width: double.infinity,
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, progress) => Center(
            child: CupertinoActivityIndicator(
              color: darkBlueColor,
            ),
          ),
          errorWidget: (context, url, error) => Center(
            child: CupertinoActivityIndicator(
              color: darkBlueColor,
            ),
          ),
        ),
      ),
    );
  }
}
