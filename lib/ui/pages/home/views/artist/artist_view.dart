import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/home/views/artist/bloc/artist_bloc.dart';
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
              itemCount: state.listArtist.isNotEmpty ? state.listArtist.length + 1 : 21,
            ),
          );
        },
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var list = BlocProvider.of<ArtistBloc>(context).state.listArtist;
    if (list.isEmpty) {
      return const SizedBox(
        height: 140,
        width: 67,
        child: CustomIndicator(),
      );
    } else {
      String? name = index != list.length ? list[index].name : '';
      String? profilePath = index != list.length ? list[index].profilePath : '';
      return SecondaryItemList(
        title: name,
        imageUrl: profilePath != null
            ? '${AppConstants.kImagePathPoster}$profilePath'
            : 'https://nileshsupermarket.com/wp-content/uploads/2022/07/no-image.jpg',
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
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(width: 14);
  }
}
