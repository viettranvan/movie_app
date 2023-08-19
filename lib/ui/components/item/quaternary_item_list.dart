import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/color.dart';
import 'package:movie_app/ui/components/components.dart';

class QuaternaryItemList extends StatelessWidget {
  final String? imageUrl;
  final String? originalLanguage;
  final String? title;
  final String? overview;
  final String? releaseDate;
  final String? voteAverage;
  final VoidCallback? onTap;
  const QuaternaryItemList({
    super.key,
    this.imageUrl,
    this.originalLanguage,
    this.title,
    this.overview,
    this.releaseDate,
    this.voteAverage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RepaintBoundary(
        child: IntrinsicHeight(
          child: Container(
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
                    padding: const EdgeInsets.fromLTRB(12, 11, 6, 11),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                          padding: const EdgeInsets.fromLTRB(1, 0, 8, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                size: 18,
                              ),
                              const SizedBox(width: 2),
                              Flexible(
                                flex: 5,
                                child: Text(
                                  releaseDate ?? '',
                                  maxLines: 1,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: indigoColor,
                                  ),
                                ),
                              ),
                              const Spacer(flex: 3),
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
                              const SizedBox(width: 3),
                              Container(
                                width: 23,
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
                SizedBox(
                  width: 90,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl ?? '',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                      progressIndicatorBuilder: (context, url, progress) => const CustomIndicator(),
                      errorWidget: (context, url, error) => const CustomIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
