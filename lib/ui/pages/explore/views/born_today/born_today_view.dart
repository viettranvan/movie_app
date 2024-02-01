import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';

class BornToday extends StatelessWidget {
  const BornToday({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PrimaryText(
          title: 'Born today',
          visibleIcon: true,
          onTapViewAll: () {},
          icon: SvgPicture.asset(
            ImagesPath.trendingIcon.assetName,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 15.h),
        SizedBox(
          height: 250.h,
          child: ListView.separated(
            // controller: bloc.scrollController,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(17.w, 5.h, 17.w, 5.h),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: itemBuilder,
            separatorBuilder: separatorBuilder,
            itemCount: 11,
            // itemCount: state.listTrending.isNotEmpty ? state.listTrending.length + 1 : 21,
          ),
        ),
      ],
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return SeptenaryItem(
      title: 'Ana de Armas',
      age: '20',
      // title: item?.title ?? item?.name,
      index: index,
      itemCount: 10,
      // itemCount: list.length,
      imageUrl: 'https://image.tmdb.org/t/p/w500/3vxvsmYLTf4jnr163SUlBIw51ee.jpg',
      // imageUrl: '''AppConstants.kImagePathPoster}item?.posterPath}''',
      onTapViewAll: () {},
      onTapItem: () {},
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 14.w);
}
