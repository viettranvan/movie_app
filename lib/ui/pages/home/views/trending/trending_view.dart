import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/ui/pages/home/views/trending/bloc/trending_bloc.dart';
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
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeSuccess) {
            BlocProvider.of<TrendingBloc>(context).add(FetchData(
              mediaType: 'movie',
              timeWindow: 'day',
              page: 1,
              language: 'en-US',
              includeAdult: true,
            ));
          }
        },
        child: BlocBuilder<TrendingBloc, TrendingState>(
          builder: (context, state) {
            if (state is TrendingInitial) {
              return const SizedBox(
                height: 213,
              );
            }
            return Stack(
              children: [
                const Positioned.fill(
                  child: PrimaryBackground(),
                ),
                SizedBox(
                  height: 215,
                  child: ListView.separated(
                    primary: true,
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    padding: const EdgeInsets.fromLTRB(17, 5, 17, 5),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: itemBuilder,
                    separatorBuilder: separatorBuilder,
                    itemCount: state.listTrending.isNotEmpty ? state.listTrending.length + 1 : 21,
                  ),
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
      return const SizedBox(
        height: 200,
        width: 120,
        child: CustomIndicator(),
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

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(width: 14);
  }
}
