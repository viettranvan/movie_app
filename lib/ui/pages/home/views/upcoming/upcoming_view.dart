import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/home/views/upcoming/bloc/upcoming_bloc.dart';
import 'package:movie_app/ui/pages/home/views/upcoming/widgets/index.dart';
import 'package:movie_app/utils/utils.dart';

class UpcomingView extends StatelessWidget {
  const UpcomingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpcomingBloc()
        ..add(FetchData(
          language: 'en-US',
          page: 1,
          region: '',
        )),
      child: BlocBuilder<UpcomingBloc, UpcomingState>(
        builder: (context, state) {
          var bloc = BlocProvider.of<UpcomingBloc>(context);
          if (state is UpcomingInitial) {
            return const SizedBox(height: 365);
          }
          return CarouselSlider.builder(
            carouselController: bloc.controller,
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
    var state = BlocProvider.of<UpcomingBloc>(context).state;
    var list = state.listUpcoming;
    if (state is UpcomingError) {
      return const SizedBox(
        height: 365,
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }
    return ItemUpcoming(
      title: list[index].title,
      voteAverage: list[index].voteAverage?.toDouble(),
      imageUrl: list[index].posterPath != null
          ? '${AppConstants.kImagePathPoster}${list[index].posterPath}'
          : 'https://nileshsupermarket.com/wp-content/uploads/2022/07/no-image.jpg',
      onTap: () => Navigator.of(context).push(
        CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ),
      ),
    );
  }
}
