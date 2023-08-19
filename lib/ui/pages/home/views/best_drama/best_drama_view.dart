import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/ui/pages/home/views/best_drama/bloc/best_drama_bloc.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';
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
      child: MultiBlocListener(
        listeners: [
          BlocListener<NavigationBloc, NavigationState>(
            listener: (context, state) {
              if (state is NavigationInitial) {
                reloadList(context);
              }
            },
          ),
          BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is HomeSuccess) {
                reloadList(context);
              }
            },
          ),
        ],
        child: BlocBuilder<BestDramaBloc, BestDramaState>(
          builder: (context, state) {
            final bloc = BlocProvider.of<BestDramaBloc>(context);
            if (state is BestDramaInitial) {
              return const SizedBox(height: 213);
            }
            return Column(
              children: [
                PrimaryText(
                  visibleIcon: true,
                  title: 'Best Drama',
                  visibleViewAll: true,
                  onTapViewAll: () {},
                  icon: SvgPicture.asset(
                    ImagesPath.bestDramaIcon.assetName,
                  ),
                ),
                const SizedBox(height: 15),
                Stack(
                  children: [
                    const Positioned.fill(
                      child: PrimaryBackground(),
                    ),
                    SizedBox(
                      height: 213,
                      child: ListView.separated(
                        controller: bloc.scrollController,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        padding: const EdgeInsets.fromLTRB(17, 5, 17, 5),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: itemBuilder,
                        separatorBuilder: separatorBuilder,
                        itemCount:
                            state.listBestDrama.isNotEmpty ? state.listBestDrama.length + 1 : 21,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var list = BlocProvider.of<BestDramaBloc>(context).state.listBestDrama;
    if (list.isEmpty) {
      return const SizedBox(
        height: 200,
        width: 120,
        child: CustomIndicator(),
      );
    } else {
      String? name = index != list.length ? list[index].name : '';
      String? posterPath = index != list.length ? list[index].posterPath : '';
      return TertiaryItemList(
        title: name,
        index: index,
        itemCount: list.length,
        imageUrl: posterPath != null
            ? '${AppConstants.kImagePathPoster}$posterPath'
            : 'https://nileshsupermarket.com/wp-content/uploads/2022/07/no-image.jpg',
        onTapViewAll: () {},
        onTapItem: () => Navigator.of(context).push(
          CustomPageRoute(
            page: const DetailsPage(),
            begin: const Offset(1, 0),
          ),
        ),
      );
    }
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(width: 14);
  }

  reloadList(BuildContext context) {
    final bloc = BlocProvider.of<BestDramaBloc>(context);
    BlocProvider.of<BestDramaBloc>(context).add(FetchData(
      language: 'en-US',
      page: 1,
      withGenres: [18],
    ));
    bloc.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }
}
