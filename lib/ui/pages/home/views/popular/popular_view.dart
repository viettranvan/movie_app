import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/ui/pages/home/views/popular/bloc/popular_bloc.dart';
import 'package:movie_app/utils/utils.dart';

class PopularView extends StatelessWidget {
  const PopularView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularBloc()
        ..add(FetchData(
          page: 1,
          region: '',
          language: 'en-US',
        )),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          final bloc = BlocProvider.of<PopularBloc>(context);
          state is HomeSuccess && bloc.state.listPopular.isNotEmpty ? reloadList(context) : null;
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryText(
              title: 'Popular',
              visibleIcon: true,
              onTapViewAll: () {},
              icon: Icon(
                Icons.stars_outlined,
                color: greyColor,
              ),
            ),
            SizedBox(height: 15.h),
            BlocBuilder<PopularBloc, PopularState>(
              builder: (context, state) {
                final bloc = BlocProvider.of<PopularBloc>(context);
                if (state is PopularInitial) {
                  return SizedBox(
                    height: 200.h,
                    child: const CustomIndicator(),
                  );
                }
                if (state is PopularError) {
                  return SizedBox(
                    height: 200.h,
                    child: Center(
                      child: Text(state.runtimeType.toString()),
                    ),
                  );
                }
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CarouselSlider.builder(
                      carouselController: bloc.controller,
                      itemBuilder: itemBuilder,
                      itemCount: state.listPopular.isNotEmpty
                          ? (state.listPopular.length / 2).round()
                          : 10,
                      options: CarouselOptions(
                        autoPlayAnimationDuration: const Duration(milliseconds: 500),
                        // autoPlay: true,
                        height: 200.h,
                        viewportFraction: 1,
                        enableInfiniteScroll: true,
                        onPageChanged: (index, reason) =>
                            bloc.add(SlidePageView(selectedIndex: index)),
                      ),
                    ),
                    SliderIndicator(
                      indexIndicator: state.selectedIndex %
                          (state.listPopular.isNotEmpty
                              ? (state.listPopular.length / 2).round()
                              : 10),
                      length: state.listPopular.isNotEmpty
                          ? (state.listPopular.length / 2).round()
                          : 10,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index, int realIndex) {
    final state = BlocProvider.of<PopularBloc>(context).state;
    final list = state.listPopular;
    return SliderItem(
      isBackdrop: true,
      imageUrlBackdrop: '${AppConstants.kImagePathBackdrop}${list[index].backdropPath}',
      onTap: () => Navigator.of(context).push(
        CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ),
      ),
    );
  }

  reloadList(BuildContext context) {
    final bloc = BlocProvider.of<PopularBloc>(context);
    bloc.add(FetchData(
      page: 1,
      region: '',
      language: 'en-US',
    ));
    if (bloc.controller.ready && bloc.state is PopularSuccess) {
      bloc.controller.jumpToPage(0);
    }
  }
}
