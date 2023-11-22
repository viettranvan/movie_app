import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/ui/pages/home/views/upcoming/bloc/upcoming_bloc.dart';
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
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          final bloc = BlocProvider.of<UpcomingBloc>(context);
          state is HomeSuccess && bloc.state.listUpcoming.isNotEmpty ? reloadList(context) : null;
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryText(
              title: 'Upcoming',
              visibleIcon: true,
              onTapViewAll: () {},
              icon: Image.asset(
                ImagesPath.upcomingIcon.assetName,
                filterQuality: FilterQuality.high,
                color: greyColor,
                scale: 2,
              ),
            ),
            SizedBox(height: 15.h),
            BlocBuilder<UpcomingBloc, UpcomingState>(
              builder: (context, state) {
                final bloc = BlocProvider.of<UpcomingBloc>(context);
                if (state is UpcomingInitial) {
                  return SizedBox(
                    height: 365.h,
                    child: const CustomIndicator(),
                  );
                }
                if (state is UpcomingError) {
                  return SizedBox(
                    height: 365.h,
                    child: Center(
                      child: Text(state.runtimeType.toString()),
                    ),
                  );
                }
                return CarouselSlider.builder(
                  carouselController: bloc.controller,
                  itemBuilder: itemBuilder,
                  itemCount: state.listUpcoming.length,
                  disableGesture: false,
                  options: CarouselOptions(
                    height: 400.h,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    viewportFraction: 0.8,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index, int realIndex) {
    final state = BlocProvider.of<UpcomingBloc>(context).state;
    final list = state.listUpcoming;
    return SliderItem(
      isBackdrop: false,
      title: list[index].title,
      voteAverage: double.parse(list[index].voteAverage?.toStringAsFixed(1) ?? ''),
      imageUrlPoster: '${AppConstants.kImagePathPoster}${list[index].posterPath}',
      onTap: () => Navigator.of(context).push(
        CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ),
      ),
    );
  }

  reloadList(BuildContext context) =>
      BlocProvider.of<UpcomingBloc>(context).add(FetchData(language: 'en-US', page: 1, region: ''));
}
