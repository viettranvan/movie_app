import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/explore/views/movie_provider/bloc/movie_provider_bloc.dart';

class MovieProviderView extends StatelessWidget {
  const MovieProviderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieProviderBloc(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<MovieProviderBloc, MovieProviderState>(
            builder: (context, state) {
              return PrimaryText(
                title: 'Movie premiere platforms',
                onTapViewAll: () {},
                visibleIcon: true,
                icon: SvgPicture.asset(
                  ImagesPath.bornTodayIcon.assetName,
                  fit: BoxFit.cover,
                ),
                enableRightWidget: true,
                rightWidget: BlocBuilder<MovieProviderBloc, MovieProviderState>(
                  builder: (context, state) {
                    // if (state is GenreError) {
                    //   return SizedBox(height: 22.h);
                    // }
                    return CustomSwitch(
                      title: 'Tv Shows',
                      onTapItem: () {},
                    );
                  },
                ),
              );
            },
          ),
          SizedBox(height: 15.h),
          BlocBuilder<MovieProviderBloc, MovieProviderState>(
            builder: (context, state) {
              // final bloc = BlocProvider.of<MovieProviderBloc>(context);
              // if (state is GenreInitial) {
              //   return SizedBox(
              //     height: 30.h,
              //     child: const CustomIndicator(),
              //   );
              // }
              // if (state is GenreError) {
              //   return SizedBox(
              //     height: 30.h,
              //     child: Center(
              //       child: Text(state.runtimeType.toString()),
              //     ),
              //   );
              // }
              return AnimatedCrossFade(
                duration: const Duration(milliseconds: 400),
                crossFadeState:
                    // state.isActive ?
                    // CrossFadeState.showSecond :
                    CrossFadeState.showFirst,
                firstChild: SizedBox(
                  height: 30.h,
                  child: ListView.separated(
                    // controller: bloc.movieController,
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(17.w, 0, 17.w, 0),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: itemBuilderMovie,
                    separatorBuilder: separatorBuilder,
                    itemCount: 20,
                    // itemCount: state.listGenreMovie.isNotEmpty ? state.listGenreMovie.length : 21,
                  ),
                ),
                secondChild: SizedBox(
                  height: 30.h,
                  child: ListView.separated(
                    // controller: bloc.tvController,
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(17.w, 0.h, 17.w, 0.h),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: itemBuilderTv,
                    separatorBuilder: separatorBuilder,
                    itemCount: 20,
                    // itemCount: state.listGenreTv.isNotEmpty ? state.listGenreTv.length : 20,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget itemBuilderMovie(BuildContext context, int index) {
    return OctonaryItem(
      title: 'item.name',
      onTapItem: () {},
    );
  }

  Widget itemBuilderTv(BuildContext context, int index) {
    return OctonaryItem(
      title: 'item.name',
      onTapItem: () {},
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 10.w);
}
