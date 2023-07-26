import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/ui/pages/home/views/genre/bloc/genre_bloc.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';

class Genreview extends StatelessWidget {
  const Genreview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenreBloc()..add(FetchData(language: 'en-US')),
      child: MultiBlocListener(
        listeners: [
          BlocListener<NavigationBloc, NavigationState>(
            listener: (context, state) {
              if (state is NavigationInitial) {
                switchMovie(context);
              }
            },
          ),
          BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is HomeSuccess) {
                reloadState(context);
              }
            },
          ),
        ],
        child: BlocBuilder<GenreBloc, GenreState>(
          builder: (context, state) {
            final bloc = BlocProvider.of<GenreBloc>(context);
            if (state is GenreInitial) {
              return const SizedBox(
                height: 30,
              );
            }
            return Column(
              children: [
                SecondaryText(
                  title: 'Popular Genres',
                  leftWidget: CustomSwitch(
                    isActive: state.isActive,
                    onSwitchMovie: () => switchMovie(context),
                    onSwitchTV: () => switchTv(context),
                  ),
                ),
                const SizedBox(height: 12),
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 400),
                  crossFadeState:
                      state.isActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  firstChild: SizedBox(
                    height: 30,
                    child: ListView.separated(
                      controller: bloc.movieController,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: itemBuilderMovie,
                      separatorBuilder: separatorBuilder,
                      itemCount: state.listGenreMovie.isNotEmpty ? state.listGenreMovie.length : 21,
                    ),
                  ),
                  secondChild: SizedBox(
                    height: 30,
                    child: ListView.separated(
                      controller: bloc.tvController,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: itemBuilderTv,
                      separatorBuilder: separatorBuilder,
                      itemCount: state.listGenreTv.isNotEmpty ? state.listGenreTv.length : 21,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget itemBuilderMovie(BuildContext context, int index) {
    var list = BlocProvider.of<GenreBloc>(context).state.listGenreMovie;
    if (list.isEmpty) {
      return const SizedBox(
        height: 30,
        width: 53,
        child: CustomIndicator(),
      );
    } else {
      return PrimaryItemList(
        title: list[index].name,
        onTap: () {},
      );
    }
  }

  Widget itemBuilderTv(BuildContext context, int index) {
    var list = BlocProvider.of<GenreBloc>(context).state.listGenreTv;
    if (list.isEmpty) {
      return const SizedBox(
        height: 30,
        width: 53,
        child: CustomIndicator(),
      );
    } else {
      return PrimaryItemList(
        title: list[index].name,
        onTap: () {},
      );
    }
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(width: 10);

  switchMovie(BuildContext context) {
    final bloc = BlocProvider.of<GenreBloc>(context);
    bloc.add(SwitchType(isActive: false));
    bloc.movieController.jumpTo(0);
  }

  switchTv(BuildContext context) {
    final bloc = BlocProvider.of<GenreBloc>(context);
    bloc.add(SwitchType(isActive: true));
    bloc.tvController.jumpTo(0);
  }

  reloadState(BuildContext context) {
    final bloc = BlocProvider.of<GenreBloc>(context);
    bloc.add(FetchData(language: 'en-US'));
    bloc.add(SwitchType(isActive: false));
    bloc.movieController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
    bloc.tvController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }
}
