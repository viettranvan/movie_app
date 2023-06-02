import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/ui/pages/home/views/upcoming/bloc/upcoming_bloc.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';
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
      child: BlocListener<NavigationBloc, NavigationState>(
        listener: (context, state) {
          BlocProvider.of<UpcomingBloc>(context).controller.jumpToPage(0);
        },
        child: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeSuccess) {
              reloadState(context);
            }
          },
          child: BlocBuilder<UpcomingBloc, UpcomingState>(
            builder: (context, state) {
              var bloc = BlocProvider.of<UpcomingBloc>(context);
              if (state is UpcomingInitial) {
                return const SizedBox(height: 365);
              }
              return Column(
                children: [
                  PrimaryTitle(
                    visibleIcon: true,
                    title: 'Upcoming',
                    visibleViewAll: true,
                    onTapViewAll: () {},
                    icon: Image.asset(
                      ImagesPath.upcomingIcon.assetName,
                      filterQuality: FilterQuality.high,
                      color: greyColor,
                      scale: 2,
                    ),
                  ),
                  const SizedBox(height: 15),
                  CarouselSlider.builder(
                    carouselController: bloc.controller,
                    itemBuilder: itemBuilder,
                    itemCount: state.listUpcoming.length,
                    disableGesture: false,
                    options: CarouselOptions(
                      height: 400,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      viewportFraction: 0.8,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index, int realIndex) {
    var state = BlocProvider.of<UpcomingBloc>(context).state;
    var list = state.listUpcoming;
    if (state is UpcomingError) {
      return const SizedBox(
        height: 365,
        child: CustomIndicator(),
      );
    }
    return SliderItem(
      isBackdrop: false,
      title: list[index].title,
      voteAverage: list[index].voteAverage?.toDouble(),
      imageUrlPoster: list[index].posterPath != null
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

  reloadState(BuildContext context) {
    final bloc = BlocProvider.of<UpcomingBloc>(context);
    bloc.add(FetchData(
      language: 'en-US',
      page: 1,
      region: '',
    ));
    bloc.controller.animateToPage(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }
}
