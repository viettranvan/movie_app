import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/details/details_page.dart';
import 'package:movie_app/ui/home/views/upcoming/widgets/index.dart';
import 'package:movie_app/utils/index.dart';

class UpcomingView extends StatelessWidget {
  const UpcomingView({super.key});

  @override
  Widget build(BuildContext context) {
    CarouselController upcomingController = CarouselController();

    return CarouselSlider.builder(
      carouselController: upcomingController,
      itemBuilder: itemBuilder,
      itemCount: 5,
      disableGesture: false,
      options: CarouselOptions(
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        height: 365,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        viewportFraction: 0.8,
        onPageChanged: (index, reason) {},
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index, int realIndex) {
    return ItemUpcoming(
      title: 'Spider-Man: No way home',
      voteAverage: 0.0,
      image: Image.network(
        '${AppConstants.kImagePathPoster}/uJYYizSuA9Y3DCs0qS4qWvHfZg4.jpg',
      ).image,
      onTap: () => Navigator.of(context).push(
        CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ),
      ),
    );
  }
}
