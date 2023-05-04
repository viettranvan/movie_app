import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/details/details_page.dart';
import 'package:movie_app/ui/home/views/top_tv/bloc/top_tv_bloc.dart';
import 'package:movie_app/ui/home/widgets/index.dart';
import 'package:movie_app/utils/utils.dart';

class TopTvView extends StatelessWidget {
  const TopTvView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopTvBloc()
        ..add(FetchData(
          language: 'en-US',
          page: 1,
        )),
      child: BlocBuilder<TopTvBloc, TopTvState>(
        builder: (context, state) {
          if (state is TopTvInitial) {
            return const SizedBox(height: 213);
          }
          return SizedBox(
            height: 213,
            child: ListView.separated(
              primary: true,
              padding: const EdgeInsets.fromLTRB(17, 5, 17, 5),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: itemBuilder,
              separatorBuilder: separatorBuilder,
              itemCount: state.listTopTv.length + 1,
            ),
          );
        },
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
      var list = (BlocProvider.of<TopTvBloc>(context).state as TopTvSuccess).listTopTv;
    String? name = index != list.length ? list[index].name : '';
    String? posterPath = index != list.length ? list[index].posterPath : '';
    return ItemMovieTv(
      title: name,
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
