import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/ui/pages/home/views/trending/bloc/trending_bloc.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';
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
          includeAdult: true,
        )),
      child: MultiBlocListener(
        listeners: [
          BlocListener<NavigationBloc, NavigationState>(
            listener: (context, state) {
              if (state is NavigationSuccess) {
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
        child: BlocBuilder<TrendingBloc, TrendingState>(
          builder: (context, state) {
            final bloc = BlocProvider.of<TrendingBloc>(context);
            if (state is TrendingInitial) {
              return SizedBox(
                height: 213.h,
              );
            }
            return Column(
              children: [
                PrimaryText(
                  visibleIcon: true,
                  title: 'Trending',
                  visibleViewAll: true,
                  onTapViewAll: () {},
                  icon: SvgPicture.asset(
                    ImagesPath.trendingIcon.assetName,
                  ),
                ),
                SizedBox(height: 15.h),
                Stack(
                  children: [
                    const Positioned.fill(
                      child: PrimaryBackground(),
                    ),
                    SizedBox(
                      height: 213.h,
                      child: ListView.separated(
                        controller: bloc.scrollController,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        padding: EdgeInsets.fromLTRB(17.w, 5.h, 17.w, 5.h),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: itemBuilder,
                        separatorBuilder: separatorBuilder,
                        itemCount:
                            state.listTrending.isNotEmpty ? state.listTrending.length + 1 : 21,
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
    var list = BlocProvider.of<TrendingBloc>(context).state.listTrending;
    if (list.isEmpty) {
      return SizedBox(
        height: 200.h,
        width: 120.w,
        child: const CustomIndicator(),
      );
    } else {
      String? title = index != list.length ? (list[index].title ?? list[index].name) : '';
      String? posterPath = index != list.length ? list[index].posterPath : '';
      return TertiaryItemList(
        title: title,
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

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 14.w);

  reloadList(BuildContext context) {
    final bloc = BlocProvider.of<TrendingBloc>(context);
    bloc.add(FetchData(
      mediaType: 'movie',
      timeWindow: 'day',
      page: 1,
      language: 'en-US',
      includeAdult: true,
    ));
    if (bloc.scrollController.hasClients) {
      bloc.scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }
  }
}
