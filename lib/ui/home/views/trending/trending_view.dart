import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/details/details_page.dart';
import 'package:movie_app/ui/home/widgets/index.dart';
import 'package:movie_app/utils/index.dart';

class TrendingView extends StatelessWidget {
  const TrendingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 213,
      child: ListView.separated(
        primary: true,
        padding: const EdgeInsets.fromLTRB(17, 5, 17, 5),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: itemBuilder,
        separatorBuilder: separatorBuilder,
        itemCount: 11,
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return ItemMovieTv(
      title: 'Thor: Love and Thunder',
      index: index,
      itemCount: 10,
      image: Image.network(
        '${AppConstants.kImagePathPoster}/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg',
      ).image,
      onTapViewAll: () {},
      onTapItem: () => Navigator.of(context).push(
        CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ),
      ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(width: 14);
  }
}
