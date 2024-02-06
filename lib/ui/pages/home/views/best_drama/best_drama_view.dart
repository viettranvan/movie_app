import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/home/views/best_drama/bloc/best_drama_bloc.dart';
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryText(
            title: 'Special dramas',
            visibleIcon: true,
            onTapViewAll: () {},
            icon: SvgPicture.asset(
              IconsPath.bestDramaIcon.assetName,
            ),
          ),
          BlocBuilder<BestDramaBloc, BestDramaState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<BestDramaBloc>(context);
              if (state is BestDramaInitial) {
                return SizedBox(
                  height: 228.h,
                  child: const CustomIndicator(),
                );
              }
              if (state is BestDramaError) {
                return SizedBox(
                  height: 228.h,
                  child: Center(
                    child: Text(state.runtimeType.toString()),
                  ),
                );
              }
              return Stack(
                children: [
                  const Positioned.fill(
                    child: PrimaryBackground(),
                  ),
                  SizedBox(
                    height: 228.h,
                    child: ListView.separated(
                      controller: bloc.scrollController,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(17.w, 20.h, 17.w, 5.h),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: itemBuilder,
                      separatorBuilder: separatorBuilder,
                      itemCount:
                          state.listBestDrama.isNotEmpty ? state.listBestDrama.length + 1 : 21,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final state = BlocProvider.of<BestDramaBloc>(context).state;
    final list = state.listBestDrama;
    final item = index < list.length ? list[index] : null;
    return TertiaryItem(
      title: item?.name,
      index: index,
      itemCount: list.length,
      imageUrl: '${AppConstants.kImagePathPoster}${item?.posterPath}',
      onTapViewAll: () {},
      onTapItem: () => Navigator.of(context).push(
        CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ),
      ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 14.w);
}
