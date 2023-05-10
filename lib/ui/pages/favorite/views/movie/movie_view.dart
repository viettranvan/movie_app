import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/ui/pages/favorite/widgets/index.dart';
import 'package:movie_app/utils/utils.dart';
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
    return const ItemMedia(
      title: 'The Super Mario Bros. Movie',
      voteAverage: '7.5',
      releaseDate: '2021/12/15',
      overview:
          'While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.',
      imageUrl: '${AppConstants.kImagePathPoster}/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg',
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(height: 18);
}
