import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/pages/home/views/best_drama/bloc/best_drama_bloc.dart';
import 'package:movie_app/ui/pages/home/widgets/index.dart';
import 'package:movie_app/ui/pages/index.dart';
import 'package:movie_app/utils/utils.dart';

class BestDramaView extends StatelessWidget {
  const BestDramaView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BestDramaBloc()
        ..add(FetchData(
          language: 'en-US',
          page: 1,
          withGenres: [18],
        )),
      child: BlocBuilder<BestDramaBloc, BestDramaState>(
        builder: (context, state) {
          if (state is BestDramaInitial) {
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
              itemCount: state.listBestDrama.length + 1,
            ),
          );
        },
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var list = (BlocProvider.of<BestDramaBloc>(context).state as BestDramaSuccess).listBestDrama;
    String? name = index != list.length ? list[index].name : '';
    String? posterPath = index != list.length ? list[index].posterPath : '';
    return ItemMediaSynthesis(
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
