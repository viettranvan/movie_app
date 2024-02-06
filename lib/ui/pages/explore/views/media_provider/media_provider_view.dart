import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/explore/views/media_provider/bloc/media_provider_bloc.dart';
import 'package:movie_app/utils/utils.dart';

class MovieProviderView extends StatelessWidget {
  const MovieProviderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MediaProviderBloc()
        ..add(FetchData(
          language: 'en-US',
          watchRegion: 'US',
        )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryText(
            title: 'Top-tier foundations',
            onTapViewAll: () {},
            visibleIcon: true,
            icon: SvgPicture.asset(
              IconsPath.bornTodayIcon.assetName,
              fit: BoxFit.cover,
            ),
            enableRightWidget: true,
            rightWidget: BlocBuilder<MediaProviderBloc, MediaProviderState>(
              builder: (context, state) {
                if (state is MediaProviderError) {
                  return SizedBox(height: 22.h);
                }
                return CustomSwitchButton(
                  title: state.status ? 'Tv Shows' : 'Movies',
                  onTapItem: () => state.status ? changeMovie(context) : changeTv(context),
                );
              },
            ),
          ),
          BlocBuilder<MediaProviderBloc, MediaProviderState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<MediaProviderBloc>(context);
              if (state is MediaProviderInitial) {
                return SizedBox(
                  height: 210.h,
                  child: const CustomIndicator(),
                );
              }
              if (state is MediaProviderError) {
                return SizedBox(
                  height: 210.h,
                  child: Center(
                    child: Text(state.runtimeType.toString()),
                  ),
                );
              }
              return SingleChildScrollView(
                child: AnimatedCrossFade(
                  duration: const Duration(milliseconds: 400),
                  crossFadeState:
                      state.status ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  firstChild: SizedBox(
                    height: 306.h,
                    child: GridView.custom(
                      controller: bloc.movieController,
                      gridDelegate: SliverQuiltedGridDelegate(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.h,
                        mainAxisSpacing: 16.w,
                        pattern: [
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 2),
                        ],
                      ),
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(17.w, 20.h, 17.w, 5.h),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      childrenDelegate: SliverChildBuilderDelegate(
                        childCount: 21,
                        itemBuilderMovie,
                      ),
                    ),
                  ),
                  secondChild: SizedBox(
                    height: 306.h,
                    child: GridView.custom(
                      controller: bloc.tvController,
                      gridDelegate: SliverQuiltedGridDelegate(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.h,
                        mainAxisSpacing: 16.w,
                        pattern: [
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 2),
                        ],
                      ),
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(17.w, 20.h, 17.w, 5.h),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      childrenDelegate: SliverChildBuilderDelegate(
                        childCount: 21,
                        itemBuilderTv,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget itemBuilderMovie(BuildContext context, int index) {
    final state = BlocProvider.of<MediaProviderBloc>(context).state;
    final item = state.listMovieProviders.isNotEmpty ? state.listMovieProviders[index] : null;
    return OctonaryItem(
      index: index,
      itemCount: 20,
      title: item?.providerName,
      imageUrl: '${AppConstants.kImagePathPoster}${item?.logoPath}',
      onTapItem: () {},
      onTapViewAll: () {},
    );
  }

  Widget itemBuilderTv(BuildContext context, int index) {
    final state = BlocProvider.of<MediaProviderBloc>(context).state;
    final item = state.listTvProviders.isNotEmpty ? state.listTvProviders[index] : null;
    return OctonaryItem(
      index: index,
      itemCount: 20,
      title: item?.providerName,
      imageUrl: '${AppConstants.kImagePathPoster}${item?.logoPath}',
      onTapItem: () {},
      onTapViewAll: () {},
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 10.w);

  changeMovie(BuildContext context) {
    final bloc = BlocProvider.of<MediaProviderBloc>(context);
    bloc.add(ChangeList(status: false));
  }

  changeTv(BuildContext context) {
    final bloc = BlocProvider.of<MediaProviderBloc>(context);
    bloc.add(ChangeList(status: true));
  }
}
