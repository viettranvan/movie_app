import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/ui/pages/home/views/top_tv/bloc/top_tv_bloc.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';
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
      child: MultiBlocListener(
        listeners: [
          BlocListener<NavigationBloc, NavigationState>(
            listener: (context, state) {
              if (state is NavigationInitial) {
                BlocProvider.of<TopTvBloc>(context).scrollController.jumpTo(0);
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
        child: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {},
          child: BlocBuilder<TopTvBloc, TopTvState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<TopTvBloc>(context);
              if (state is TopTvInitial) {
                return const SizedBox(height: 213);
              }
              return Column(
                children: [
                  PrimaryTitle(
                    visibleIcon: true,
                    title: 'Top TV Shows',
                    visibleViewAll: true,
                    onTapViewAll: () {},
                    icon: SvgPicture.asset(
                      ImagesPath.tvShowIcon.assetName,
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
                          itemCount: state.listTopTv.isNotEmpty ? state.listTopTv.length + 1 : 21,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var list = BlocProvider.of<TopTvBloc>(context).state.listTopTv;
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

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(width: 14);

  reloadState(BuildContext context) {
    final bloc = BlocProvider.of<TopTvBloc>(context);
    bloc.add(FetchData(
      language: 'en-US',
      page: 1,
    ));
    bloc.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }
}
