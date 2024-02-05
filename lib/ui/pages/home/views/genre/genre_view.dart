import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/home/views/genre/bloc/genre_bloc.dart';

class Genreview extends StatelessWidget {
  const Genreview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenreBloc()..add(FetchData(language: 'en-US')),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<GenreBloc, GenreState>(
            builder: (context, state) {
              return PrimaryText(
                title: 'Popular Genres',
                enableRightWidget: true,
                rightWidget: BlocBuilder<GenreBloc, GenreState>(
                  builder: (context, state) {
                    if (state is GenreError) {
                      return SizedBox(height: 22.h);
                    }
                    return CustomSwitch(
                      title: state.isActive ? 'Tv Shows' : 'Movies',
                      onTapItem: () => state.isActive ? changeMovie(context) : changeTv(context),
                    );
                  },
                ),
              );
            },
          ),
          SizedBox(height: 15.h),
          BlocBuilder<GenreBloc, GenreState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<GenreBloc>(context);
              if (state is GenreInitial) {
                return SizedBox(
                  height: 30.h,
                  child: const CustomIndicator(),
                );
              }
              if (state is GenreError) {
                return SizedBox(
                  height: 30.h,
                  child: Center(
                    child: Text(state.runtimeType.toString()),
                  ),
                );
              }
              return AnimatedCrossFade(
                duration: const Duration(milliseconds: 400),
                crossFadeState:
                    state.isActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                firstChild: SizedBox(
                  height: 30.h,
                  child: ListView.separated(
                    controller: bloc.movieController,
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(17.w, 0, 17.w, 0),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: itemBuilderMovie,
                    separatorBuilder: separatorBuilder,
                    itemCount: state.listGenreMovie.isNotEmpty ? state.listGenreMovie.length : 21,
                  ),
                ),
                secondChild: SizedBox(
                  height: 30.h,
                  child: ListView.separated(
                    controller: bloc.tvController,
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(17.w, 0.h, 17.w, 0.h),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: itemBuilderTv,
                    separatorBuilder: separatorBuilder,
                    itemCount: state.listGenreTv.isNotEmpty ? state.listGenreTv.length : 20,
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
    final state = BlocProvider.of<GenreBloc>(context).state;
    final item = state.listGenreMovie.isNotEmpty ? state.listGenreMovie[index] : null;
    return PrimaryItem(
      title: item?.name,
      onTapItem: () {},
    );
  }

  Widget itemBuilderTv(BuildContext context, int index) {
    final state = BlocProvider.of<GenreBloc>(context).state;
    final item = state.listGenreTv.isNotEmpty ? state.listGenreTv[index] : null;
    return PrimaryItem(
      title: item?.name,
      onTapItem: () {},
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 10.w);

  changeMovie(BuildContext context) {
    final bloc = BlocProvider.of<GenreBloc>(context);
    bloc.add(SwitchType(isActive: false));
  }

  changeTv(BuildContext context) {
    final bloc = BlocProvider.of<GenreBloc>(context);
    bloc.add(SwitchType(isActive: true));
  }
}
