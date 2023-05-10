import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/genre_bloc.dart';
import 'widgets/index.dart';

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
          var bloc = BlocProvider.of<GenreBloc>(context);
          if (state is GenreInitial) {
            return const SizedBox(
              height: 30,
            );
          }
          return Stack(
            children: [
              Visibility(
                visible: state.visibleMovie,
                child: AnimatedOpacity(
                  onEnd: () => bloc.add(VisbleList(
                    visibleMovie: false,
                    visibleTv: true,
                  )),
                  opacity: isActive ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                    height: 30,
                    child: ListView.separated(
                      primary: true,
                      padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: separatorBuilderMovie,
                      separatorBuilder: separatorBuilder,
                      itemCount: state.listGenreMovie.length,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: state.visibleTv,
                child: AnimatedOpacity(
                  onEnd: () => bloc.add(VisbleList(
                    visibleMovie: true,
                    visibleTv: false,
                  )),
                  opacity: isActive ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                    height: 30,
                    child: ListView.separated(
                      primary: true,
                      padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: itemBuilderTv,
                      separatorBuilder: separatorBuilder,
                      itemCount: state.listGenreTv.length,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget separatorBuilderMovie(BuildContext context, int index) {
    var listGenre = (BlocProvider.of<GenreBloc>(context).state as GenreSuccess).listGenreMovie;
    return ItemGenre(
      genreName: listGenre[index].name,
      onTap: () {
        log('yeah');
      },
    );
  }

  Widget itemBuilderTv(BuildContext context, int index) {
    var listGenre = (BlocProvider.of<GenreBloc>(context).state as GenreSuccess).listGenreTv;
    return ItemGenre(
      genreName: listGenre[index].name,
      onTap: () {
        log('yo');
      },
    );
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(width: 10);
  }
}
