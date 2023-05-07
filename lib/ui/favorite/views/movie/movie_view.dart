import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/ui/favorite/widgets/custom_load_more.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MovieView extends StatelessWidget {
  const MovieView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RefreshController();
    return SmartRefresher(
      controller: controller,
      onRefresh: () {},
      onLoading: () {},
      enablePullDown: true,
      enablePullUp: true,
      footer: const CustomLoadMore(
        height: 130,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        controller: ScrollController(),
        padding: const EdgeInsets.fromLTRB(25, 18, 25, 0),
        itemBuilder: itemBuilder,
        separatorBuilder: separatorBuilder,
        itemCount: 10,
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {},
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
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 15, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Spider-Man: No Way Home',
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Peter Parker is unmasked and no longer able to separate his normal life from the high-stakeaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: indigoColor.withAlpha(128),
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '2021/12/15',
                            style: TextStyle(
                              fontSize: 15,
                              color: indigoColor,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '7.5',
                            style: TextStyle(
                              color: yellowColor,
                              fontSize: 15,
                            ),
                          ),
                          Icon(
                            Icons.star_border_rounded,
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
                              'en',
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
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org//t/p/w220_and_h330_face/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fitHeight,
                  progressIndicatorBuilder: (context, url, progress) => CupertinoActivityIndicator(
                    color: darkBlueColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(height: 18);
}
