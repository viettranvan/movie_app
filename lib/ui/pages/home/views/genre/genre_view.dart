import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/home/views/genre/bloc/genre_bloc.dart';

class Genreview extends StatelessWidget {
  final bool isActive;
  const Genreview({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenreBloc()..add(FetchData(language: 'en-US')),
      child: BlocBuilder<GenreBloc, GenreState>(
        builder: (context, state) {
          if (state is GenreInitial) {
            return const SizedBox(
              height: 30,
            );
          }
          return AnimatedCrossFade(
            duration: const Duration(milliseconds: 400),
            crossFadeState: isActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: SizedBox(
              height: 30,
              child: ListView.separated(
                primary: true,
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: separatorBuilderMovie,
                separatorBuilder: separatorBuilder,
                itemCount: state.listGenreMovie.isNotEmpty ? state.listGenreMovie.length : 21,
              ),
            ),
            secondChild: SizedBox(
              height: 30,
              child: ListView.separated(
                primary: true,
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
          );
        },
      ),
    );
  }

  Widget separatorBuilderMovie(BuildContext context, int index) {
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
        onTap: () {
          log('yeah');
        },
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
        onTap: () {
          log('yeah');
        },
      );
    }
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(width: 10);
  }
}
