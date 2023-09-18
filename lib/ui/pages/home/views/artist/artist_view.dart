import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/home/bloc/home_bloc.dart';
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
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          final bloc = BlocProvider.of<ArtistBloc>(context);
          state is HomeSuccess && bloc.state.listArtist.isNotEmpty ? reloadList(context) : null;
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SecondaryText(
              title: 'Popular Artist',
              onTapViewAll: () {},
            ),
            SizedBox(height: 12.h),
            BlocBuilder<ArtistBloc, ArtistState>(
              builder: (context, state) {
                final bloc = BlocProvider.of<ArtistBloc>(context);
                if (state is ArtistInitial) {
                  return SizedBox(
                    height: 150.h,
                    child: const CustomIndicator(),
                  );
                }
                if (state is ArtistError) {
                  return SizedBox(
                    height: 150.h,
                    child: Center(
                      child: Text(state.runtimeType.toString()),
                    ),
                  );
                }
                return SizedBox(
                  height: 150.h,
                  child: ListView.separated(
                    controller: bloc.scrollController,
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    padding: EdgeInsets.fromLTRB(17.w, 5.h, 17.w, 5.h),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: itemBuilder,
                    separatorBuilder: separatorBuilder,
                    itemCount: state.listArtist.isNotEmpty ? state.listArtist.length + 1 : 21,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final state = BlocProvider.of<ArtistBloc>(context).state;
    final list = state.listArtist;
    String? name = index != list.length ? list[index].name : '';
    String? profilePath = index != list.length ? list[index].profilePath : '';
    return SecondaryItemList(
      title: name,
      imageUrl: '${AppConstants.kImagePathPoster}$profilePath',
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

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 14.h);

  reloadList(BuildContext context) {
    final bloc = BlocProvider.of<ArtistBloc>(context);
    bloc.add(FetchData(language: 'en-US', page: 1));
    if (bloc.scrollController.hasClients) {
      bloc.scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }
  }
}
