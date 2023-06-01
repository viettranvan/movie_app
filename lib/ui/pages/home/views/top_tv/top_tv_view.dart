import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/ui/pages/home/views/top_tv/bloc/top_tv_bloc.dart';
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
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeSuccess) {
            BlocProvider.of<TopTvBloc>(context).add(FetchData(
              language: 'en-US',
              page: 1,
            ));
          }
        },
        child: BlocBuilder<TopTvBloc, TopTvState>(
          builder: (context, state) {
            if (state is TopTvInitial) {
              return const SizedBox(height: 213);
            }
            return Stack(
              children: [
                const Positioned.fill(
                  child: PrimaryBackground(),
                ),
                SizedBox(
                  height: 213,
                  child: ListView.separated(
                    primary: true,
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
            );
          },
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

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(width: 14);
  }
}
