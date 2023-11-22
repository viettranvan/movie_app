import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/utils/utils.dart';

class TopRatedView extends StatelessWidget {
  const TopRatedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PrimaryText(
          title: 'Top rated',
          visibleIcon: true,
          onTapViewAll: () {},
          icon: SvgPicture.asset(
            ImagesPath.topRatedIcon.assetName,
          ),
        ),
        SizedBox(height: 15.h),
        SizedBox(
          height: 300.h,
          child: ListView.separated(
            // controller: bloc.scrollController,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            padding: EdgeInsets.fromLTRB(17.w, 5.h, 17.w, 5.h),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: itemBuilder,
            separatorBuilder: separatorBuilder,
            itemCount: 11,
          ),
        ),
      ],
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    // final state = BlocProvider.of<TrendingBloc>(context).state;
    // final list = state.listTrending;
    // String? title = index != list.length ? (list[index].title ?? list[index].name) : '';
    // String? posterPath = index != list.length ? list[index].posterPath : '';
    return SenaryItemList(
      title: (index + 1).toString(),
      index: index,
      itemCount: 10,
      imageUrl: '${AppConstants.kImagePathPoster}/egg7KFi18TSQc1s24RMmR9i2zO6.jpg',
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
