import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/index.dart';

class ItemNowPlaying extends StatelessWidget {
  final VoidCallback? onTap;
  final ImageProvider image;
  final List<Color>? colors;
  final String? title;
  final int? season;
  final int? episode;
  final String? overview;
  const ItemNowPlaying({
    super.key,
    this.onTap,
    required this.image,
    this.colors,
    this.title,
    this.season,
    this.episode,
    this.overview,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 175,
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            alignment: Alignment.centerLeft,
            filterQuality: FilterQuality.high,
            fit: BoxFit.fitHeight,
            image: image,
          ),
          boxShadow: [
            BoxShadow(
              color: lightGreyColor,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 114),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  gradient: LinearGradient(
                    stops: const [0, 1],
                    colors: colors ?? [],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 9),
                      Text(
                        title ?? '',
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        'Season $season | Episode $episode',
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 11),
                      SizedBox(
                        width: 200,
                        child: Text(
                          overview??'',
                          maxLines: 4,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              ImagesPath.tvShowIcon.assetName,
                              filterQuality: FilterQuality.high,
                              color: whiteColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Watch now!',
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
