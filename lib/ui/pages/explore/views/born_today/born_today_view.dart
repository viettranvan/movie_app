import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/explore/views/born_today/bloc/born_today_bloc.dart';
import 'package:movie_app/utils/utils.dart';

class BornToday extends StatelessWidget {
  const BornToday({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BornTodayBloc()
        ..add(FetchData(
          page: 1,
          language: 'en-US',
        )),
      child: BlocBuilder<BornTodayBloc, BornTodayState>(
        builder: (context, state) {
          if (state is BornTodaySuccess && state.listArtist.isEmpty) {
            return const SizedBox();
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                title: 'Born today',
                visibleIcon: true,
                onTapViewAll: () {},
                icon: SvgPicture.asset(
                  ImagesPath.bornTodayIcon.assetName,
                  fit: BoxFit.cover,
                ),
                enableRightWidget:
                    state.listArtist.isNotEmpty && state.listArtist.length < 20 ? true : false,
                rightWidget: const SizedBox(),
              ),
              SizedBox(height: 15.h),
              BlocBuilder<BornTodayBloc, BornTodayState>(
                builder: (context, state) {
                  final bloc = BlocProvider.of<BornTodayBloc>(context);
                  if (state is BornTodayInitial) {
                    return SizedBox(
                      height: 250.h,
                      child: const CustomIndicator(),
                    );
                  }
                  if (state is BornTodayError) {
                    return SizedBox(
                      height: 250.h,
                      child: Center(
                        child: Text(state.runtimeType.toString()),
                      ),
                    );
                  }

                  return SizedBox(
                    height: 250.h,
                    child: ListView.separated(
                      controller: bloc.scrollController,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(17.w, 5.h, 17.w, 5.h),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: itemBuilder,
                      separatorBuilder: separatorBuilder,
                      itemCount: state.listArtist.isNotEmpty
                          ? state.listArtist.length < 20
                              ? state.listArtist.length
                              : state.listArtist.length + 1
                          : 0,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final state = BlocProvider.of<BornTodayBloc>(context).state;
    final list = state.listArtist;
    final item = index < list.length ? list[index] : null;
    final age = item?.birthday == null
        ? 'Unknown'
        : DateTime.now().year - DateTime.parse(item?.birthday ?? '').year;
    return SeptenaryItem(
      title: item?.name,
      age: '$age',
      imageUrl: '${AppConstants.kImagePathPoster}${item?.profilePath}',
      onTapItem: () {},
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 14.w);
}