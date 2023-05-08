import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/details/details_page.dart';
import 'package:movie_app/ui/home/views/trending/bloc/trending_bloc.dart';
import 'package:movie_app/ui/home/widgets/index.dart';
import 'package:movie_app/utils/utils.dart';

class TrendingView extends StatelessWidget {
  const TrendingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrendingBloc()
        ..add(FetchData(
          mediaType: 'movie',
          timeWindow: 'day',
          page: 1,
          language: 'en-US',
        )),
      child: BlocBuilder<TrendingBloc, TrendingState>(
        builder: (context, state) {
          if (state is TrendingInitial) {
            return const SizedBox(
              height: 213,
            );
          }
          return SizedBox(
            height: 215,
            child: ListView.separated(
              primary: true,
              padding: const EdgeInsets.fromLTRB(17, 5, 17, 5),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: itemBuilder,
              separatorBuilder: separatorBuilder,
              itemCount: state.listTrending.length + 1,
            ),
          );
        },
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var list = (BlocProvider.of<TrendingBloc>(context).state as TrendingSuccess).listTrending;
    String? title = index != list.length ? (list[index].title ?? list[index].name) : '';
    String? posterPath = index != list.length ? list[index].posterPath : '';
    return ItemMediaSynthesis(
      title: title,
      index: index,
      itemCount: list.length,
      imageUrl: '${AppConstants.kImagePathPoster}$posterPath',
      onTapViewAll: () {},
      onTapItem: () => Navigator.of(context).push(
        CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ),
      ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(width: 14);
  }
}
