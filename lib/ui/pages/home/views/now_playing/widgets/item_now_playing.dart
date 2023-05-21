import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/index.dart';

class ItemNowPlaying extends StatelessWidget {
  final VoidCallback? onTap;
  final String imageUrl;
  final List<Color>? colors;
  final List<double>? stops;
  final Color? textColor;
  final String? title;
  final int? season;
  final int? episode;
  final String? overview;
  const ItemNowPlaying({
    super.key,
    this.onTap,
    required this.imageUrl,
    this.colors,
    this.title,
    this.season,
    this.episode,
    this.overview,
    this.stops,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RepaintBoundary(
        child: IntrinsicHeight(
          child: Container(
            margin: const EdgeInsets.fromLTRB(17, 0, 17, 0),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: lightGreyColor,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  child: CachedNetworkImage(
                    width: 115,
                    imageUrl: imageUrl,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
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
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: whiteColor,
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
                      padding: const EdgeInsets.fromLTRB(15, 0, 25, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            title ?? '',
                            overflow: TextOverflow.clip,
                            softWrap: false,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            'Season $season | Episode $episode',
                            overflow: TextOverflow.clip,
                            softWrap: false,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 11),
                          Text(
                            overview ?? '',
                            maxLines: 4,
                            softWrap: false,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            height: (overview ?? '').contains('Comming soon') ? 59 : 18,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  ImagesPath.tvShowIcon.assetName,
                                  colorFilter: ColorFilter.mode(
                                    textColor ?? whiteColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Watch now!',
                                  style: TextStyle(
                                    color: textColor,
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
        ),
      ),
    );
  }
}
