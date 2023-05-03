import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/index.dart';

class ItemNowPlaying extends StatelessWidget {
  final VoidCallback? onTap;
  final ImageProvider image;
  final List<Color>? colors;
  final List<double>? stops;
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
    this.stops,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 175,
        margin: const EdgeInsets.fromLTRB(17, 0, 17, 0),
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(left: 113),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: stops,
                    colors: colors ?? [],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 9),
                      Text(
                        title ?? '',
                        overflow: TextOverflow.clip,
                        softWrap: false,
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        'Season $season | Episode $episode',
                        overflow: TextOverflow.clip,
                        softWrap: false,
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 11),
                      SizedBox(
                        width: 300,
                        child: Text(
                          overview ?? '',
                          maxLines: 4,
                          // softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: overview!.contains('Comming soon') ? 59 : 18,
                      ),
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
