import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/index.dart';

class ItemUpcoming extends StatelessWidget {
  final ImageProvider image;
  final VoidCallback? onTap;
  final String? title;
  final double? voteAverage;

  const ItemUpcoming({
    super.key,
    required this.image,
    this.onTap,
    this.title,
    this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2.5),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: lightGreyColor,
              blurRadius: 5,
            ),
          ],
          image: DecorationImage(
            image: image,
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
          ),
        ),
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
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.yellow,
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
    );
  }
}
