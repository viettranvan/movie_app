import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class ItemMedia extends StatelessWidget {
  final String? imageUrl;
  final String? originalLanguage;
  final String? title;
  final String? overview;
  final String? releaseDate;
  final String? voteAverage;
  const ItemMedia({
    super.key,
    this.imageUrl,
    this.originalLanguage,
    this.title,
    this.overview,
    this.releaseDate,
    this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: RepaintBoundary(
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: greyColor,
                blurRadius: 5,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 11),
                      Text(
                        title ?? '',
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        overview ?? 'Coming soon',
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: greyColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: overview!.contains('Coming soon') ? 45 : 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              releaseDate ?? '',
                              style: TextStyle(
                                fontSize: 15,
                                color: indigoColor,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              voteAverage ?? '',
                              style: TextStyle(
                                color: yellowColor,
                                fontSize: 15,
                              ),
                            ),
                            Icon(
                              Icons.star_rounded,
                              color: yellowColor,
                            ),
                            const SizedBox(width: 6),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: gainsBoroColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                originalLanguage ?? '',
                                style: TextStyle(
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl ?? '',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fitHeight,
                    progressIndicatorBuilder: (context, url, progress) => Center(
                      child: CupertinoActivityIndicator(
                        color: darkBlueColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
