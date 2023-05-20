import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/home/views/popular/bloc/popular_bloc.dart';
import 'package:movie_app/ui/pages/home/views/popular/widgets/index.dart';
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
      child: BlocBuilder<PopularBloc, PopularState>(
        builder: (context, state) {
          var bloc = BlocProvider.of<PopularBloc>(context);
          if (state is PopularInitial) {
            return const SizedBox(
              height: 200,
            );
          }
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider.builder(
                carouselController: bloc.controller,
                itemBuilder: itemBuilder,
                itemCount: (state.listPopular.length / 2).round(),
                options: CarouselOptions(
                  autoPlayAnimationDuration: const Duration(milliseconds: 500),
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
      urlImage: list[index].backdropPath != null
          ? '${AppConstants.kImagePathBackdrop}${list[index].backdropPath}'
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
