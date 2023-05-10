import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/pages/home/views/popular/bloc/popular_bloc.dart';
import 'package:movie_app/ui/pages/index.dart';
import 'package:movie_app/utils/utils.dart';

import 'widgets/index.dart';

class PopularView extends StatelessWidget {
  const PopularView({super.key});

  @override
  Widget build(BuildContext context) {
    CarouselController popularController = CarouselController();
    return BlocProvider(
      create: (context) => PopularBloc()
        ..add(FetchData(
          page: 1,
          region: '',
          language: 'en-US',
        )),
      child: BlocBuilder<PopularBloc, PopularState>(
        builder: (context, state) {
          if (state is PopularInitial) {
            return const SizedBox(
              height: 200,
            );
          }
          var bloc = BlocProvider.of<PopularBloc>(context);
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider.builder(
                carouselController: popularController,
                itemBuilder: itemBuilder,
                itemCount: (state.listPopular.length / 2).round(),
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  onPageChanged: (index, reason) => bloc.add(SlidePageView(selectedIndex: index)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: List.generate(
                  (state.listPopular.length / 2).round(),
                  (index) => Indicator(
                    isActive: state.selectedIndex % (state.listPopular.length / 2).round() == index
                        ? true
                        : false,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index, int realIndex) {
    var list = (BlocProvider.of<PopularBloc>(context).state as PopularSuccess).listPopular;
    return ItemPopular(
      urlImage: '${AppConstants.kImagePathBackdrop}${list[index].backdropPath}',
      onTap: () => Navigator.of(context).push(
        CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ),
      ),
    );
  }
}
