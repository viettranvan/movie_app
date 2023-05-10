import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/pages/index.dart';
import 'package:movie_app/utils/utils.dart';

import 'bloc/upcoming_bloc.dart';
import 'widgets/index.dart';

class UpcomingView extends StatelessWidget {
  const UpcomingView({super.key});

  @override
  Widget build(BuildContext context) {
    CarouselController upcomingController = CarouselController();

    return BlocProvider(
      create: (context) => UpcomingBloc()
        ..add(FetchData(
          language: 'en-US',
          page: 1,
          region: '',
        )),
      child: BlocBuilder<UpcomingBloc, UpcomingState>(
        builder: (context, state) {
          if (state is UpcomingInitial) {
            return const SizedBox(height: 365);
          }
          return CarouselSlider.builder(
            carouselController: upcomingController,
            itemBuilder: itemBuilder,
            itemCount: state.listUpcoming.length,
            disableGesture: false,
            options: CarouselOptions(
              height: 365,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              viewportFraction: 0.8,
            ),
          );
        },
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index, int realIndex) {
    var list = (BlocProvider.of<UpcomingBloc>(context).state as UpcomingSuccess).listUpcoming;
    return ItemUpcoming(
      title: list[index].title,
      voteAverage: list[index].voteAverage?.toDouble(),
      imageUrl: '${AppConstants.kImagePathPoster}${list[index].posterPath}',
      onTap: () => Navigator.of(context).push(
        CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ),
      ),
    );
  }
}
