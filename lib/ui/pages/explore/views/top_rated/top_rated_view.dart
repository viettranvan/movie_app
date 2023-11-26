import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/explore/views/top_rated/bloc/top_rated_bloc.dart';
import 'package:movie_app/utils/utils.dart';

class TopRatedView extends StatelessWidget {
  const TopRatedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopRatedBloc()
        ..add(FetcData(
          page: 1,
          language: 'en-US',
          region: '',
        )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryText(
            title: 'Top 10 rated movies',
            visibleIcon: true,
            onTapViewAll: () {},
            icon: SvgPicture.asset(
              ImagesPath.topRatedIcon.assetName,
            ),
          ),
          SizedBox(height: 15.h),
          BlocConsumer<TopRatedBloc, TopRatedState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is TopRatedInitial) {
                return SizedBox(
                  height: 392.h,
                  child: const CustomIndicator(),
                );
              }
              if (state is TopRatedError) {
                return SizedBox(
                  height: 213.h,
                  child: Center(
                    child: Text(state.runtimeType.toString()),
                  ),
                );
              }
              return SizedBox(
                height: 392.h,
                child: ListView.separated(
                  physics: const PageScrollPhysics(),
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  padding: EdgeInsets.fromLTRB(17.w, 5.h, 17.w, 5.h),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: itemBuilder,
                  separatorBuilder: separatorBuilder,
                  itemCount: (state.listTopRated.length / 2).round(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final state = BlocProvider.of<TopRatedBloc>(context).state;
    final list = state.listTopRated;
    String? title = list[index].title ?? '';
    String? posterPath = list[index].posterPath;
    double voteAverage = double.parse(list[index].voteAverage?.toStringAsFixed(1) ?? '');
    return SenaryItemList(
      title: title,
      rank: '${index + 1}',
      voteAverage: '$voteAverage',
      initialRating: voteAverage,
      imageUrl: '${AppConstants.kImagePathPoster}$posterPath',
      onTapBanner: () {},
      onTapItem: () {
        Navigator.of(context).push(
          CustomPageRoute(
            page: const DetailsPage(),
            begin: const Offset(1, 0),
          ),
        );
      },
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 14.w);
}
