import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/color.dart';
import 'package:movie_app/ui/components/components.dart';

class SliderItem extends StatelessWidget {
  final String? imageUrlPoster;
  final VoidCallback? onTap;
  final String? imageUrlBackdrop;
  final String? title;
  final double? voteAverage;
  final bool isBackdrop;
  const SliderItem({
    super.key,
    this.onTap,
    this.title,
    this.voteAverage,
    required this.isBackdrop,
    this.imageUrlPoster,
    this.imageUrlBackdrop,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RepaintBoundary(
        child: isBackdrop
            ? SizedBox(
                child: CachedNetworkImage(
                  imageUrl: imageUrlBackdrop ?? '',
                  width: double.infinity,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, progress) => const CustomIndicator(),
                  errorWidget: (context, url, error) => const CustomIndicator(),
                ),
              )
            : Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2.5),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: lightGreyColor,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: imageUrlPoster ?? '',
                        width: double.infinity,
                        height: double.infinity,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) =>
                            const CustomIndicator(),
                        errorWidget: (context, url, error) => const CustomIndicator(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Stack(
                            children: [
                              const BlurBackground(
                                heightBackground: 53,
                                radiusCorner: 15,
                                width: 90,
                              ),
                              Container(
                                width: 90,
                                height: 53,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: whiteColor.withOpacity(0.4),
                                    strokeAlign: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xffDADADA).withOpacity(0.3),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18),
                                      child: Text(
                                        'IMDb',
                                        style: TextStyle(
                                          color: whiteColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          color: yellowColor,
                                          size: 25,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '$voteAverage',
                                          style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              const BlurBackground(
                                heightBackground: 88,
                                radiusCorner: 20,
                              ),
                              Container(
                                width: double.infinity,
                                height: 88,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    strokeAlign: 1,
                                    color: whiteColor.withOpacity(0.4),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xffDADADA).withOpacity(0.3),
                                ),
                                child: Text(
                                  title ?? '',
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
