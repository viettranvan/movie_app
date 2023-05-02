import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/details/details_page.dart';
import 'package:movie_app/ui/home/views/artist/bloc/artist_bloc.dart';
import 'package:movie_app/ui/home/views/artist/widgets/index.dart';
import 'package:movie_app/utils/utils.dart';

class ArtistView extends StatelessWidget {
  const ArtistView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArtistBloc()
        ..add(FetchData(
          language: 'en-US',
          page: 1,
        )),
      child: BlocBuilder<ArtistBloc, ArtistState>(
        builder: (context, state) {
          if (state is ArtistInitial) {
            return const SizedBox(height: 150);
          }
          return SizedBox(
            height: 150,
            child: ListView.separated(
              primary: true,
              padding: const EdgeInsets.fromLTRB(17, 5, 17, 5),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: itemBuilder,
              separatorBuilder: separatorBuilder,
              itemCount: state.listArtist.length + 1,
            ),
          );
        },
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var list = (BlocProvider.of<ArtistBloc>(context).state as ArtistSuccess).listArtist;
    String? name = index != list.length ? list[index].name : '';
    String? profilePath = index != list.length ? list[index].profilePath : '';
    return ItemArtist(
      title: name,
      image: Image.network(
        '${AppConstants.kImagePathPoster}$profilePath',
      ).image,
      index: index,
      itemCount: list.length,
      onTapItem: () => Navigator.of(context).push(
        CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ),
      ),
      onTapViewAll: () {},
    );
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(width: 14);
  }
}
