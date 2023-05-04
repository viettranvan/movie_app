import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class ItemMovieTv extends StatelessWidget {
  final int itemCount;
  final int index;
  final VoidCallback? onTapItem;
  final VoidCallback? onTapViewAll;
  final String imageUrl;
  final String? title;
  const ItemMovieTv({
    super.key,
    required this.itemCount,
    required this.index,
    this.onTapItem,
    this.onTapViewAll,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: index == itemCount ? onTapViewAll : onTapItem,
      child: RepaintBoundary(
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                color: lightGreyColor,
                blurRadius: 5,
              ),
            ],
          ),
          child: index == itemCount
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: darkBlueColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Positioned.fill(
                            right: 10,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: whiteColor,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'View all',
                        style: TextStyle(
                          color: darkBlueColor,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 171,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          filterQuality: FilterQuality.high,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, progress) =>
                              CupertinoActivityIndicator(
                            color: darkBlueColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7),
                      child: Text(
                        title ?? '',
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(
                          fontSize: 14.5,
                          overflow: TextOverflow.clip,
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
