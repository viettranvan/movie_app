import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/details/details_page.dart';
import 'package:movie_app/ui/home/widgets/index.dart';
import 'package:movie_app/utils/index.dart';

class NowPlayingView extends StatelessWidget {
  const NowPlayingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ItemNowPlaying(
      title: 'Peaky Blinders',
      season: 6, // lay latest season
      episode: 3, // lay latest episode
      overview:
          'A gangster family epic set in 1919 Birmingham, England and centered on a gang who sew razor blades in the peaks...',
      image: Image.network(
        '${AppConstants.kImagePathPoster}/vUUqzWa2LnHIVqkaKVlVGkVcZIW.jpg',
      ).image,
      colors: [darkTealColor, tealColor],
      onTap: () => Navigator.of(context).push(
        CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ),
      ),
    );
  }
}
