import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/ui/pages/home/views/artist/index.dart';
import 'package:movie_app/ui/pages/home/views/best_drama/index.dart';
import 'package:movie_app/ui/pages/home/views/genre/index.dart';
import 'package:movie_app/ui/pages/home/views/now_playing/index.dart';
import 'package:movie_app/ui/pages/home/views/popular/index.dart';
import 'package:movie_app/ui/pages/home/views/top_tv/index.dart';
import 'package:movie_app/ui/pages/home/views/trending/index.dart';
import 'package:movie_app/ui/pages/home/views/upcoming/index.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocListener<NavigationBloc, NavigationState>(
        listener: (context, state) {
          if (state is NavigationSuccess) {
            scrollToTop(context);
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            var bloc = BlocProvider.of<HomeBloc>(context);
            return Scaffold(
              backgroundColor: whiteColor,
              appBar: CustomAppBar(
                centerTitle: true,
                leading: Padding(
                  padding: EdgeInsets.fromLTRB(15.w, 0, 0, 0),
                  child: CircleAvatar(
                    backgroundImage: Image.asset(
                      ImagesPath.primaryShortLogo.assetName,
                    ).image,
                  ),
                ),
                title: Image.asset(
                  ImagesPath.primaryLongLogo.assetName,
                  filterQuality: FilterQuality.high,
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 15.w, 0),
                    child: Icon(
                      Icons.notifications_sharp,
                      size: 30.sp,
                    ),
                  ),
                ],
                onTapLeading: () => navigateProfilePage(context),
              ),
              body: NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  if (bloc.scrollController.position.userScrollDirection ==
                      ScrollDirection.forward) {
                    showNavigationBar(context);
                    return false;
                  }
                  if (bloc.scrollController.position.userScrollDirection ==
                      ScrollDirection.reverse) {
                    hideNavigationBar(context);
                    return false;
                  }
                  return true;
                },
                child: SmartRefresher(
                  controller: bloc.refreshController,
                  scrollController: bloc.scrollController,
                  header: const Header(),
                  onRefresh: () => bloc.add(RefreshData()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20.h),
                      const Genreview(),
                      SizedBox(height: 30.h),
                      const PopularView(),
                      SizedBox(height: 30.h),
                      const TrendingView(),
                      SizedBox(height: 30.h),
                      const NowPlayingView(),
                      SizedBox(height: 30.h),
                      const BestDramaView(),
                      SizedBox(height: 30.h),
                      const ArtistView(),
                      SizedBox(height: 30.h),
                      const TopTvView(),
                      SizedBox(height: 30.h),
                      const UpcomingView(),
                      SizedBox(height: 110.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  scrollToTop(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    if (bloc.scrollController.hasClients) {
      bloc.scrollController.jumpTo(0);
    }
  }

  navigateProfilePage(BuildContext context) =>
      BlocProvider.of<NavigationBloc>(context).add(NavigatePage(indexPage: 3));

  showNavigationBar(BuildContext context) =>
      BlocProvider.of<NavigationBloc>(context).add(ShowHide(visible: true));

  hideNavigationBar(BuildContext context) =>
      BlocProvider.of<NavigationBloc>(context).add(ShowHide(visible: false));
}

// void _incrementCounter() async {
//     try {
//       var list = await PopularService(apiClient: RestApiClient()).getPopularMovie();
//       // print('log: ${list.length} ');
//     } catch (e) {
//       Logger.debug(e.runtimeType.toString());
//     }
//   }

// SizedBox(
//   height: 18,
//   child: Center(
//     child: ListView.separated(
//       shrinkWrap: true,
//       scrollDirection: Axis.horizontal,
//       itemBuilder: (context, index) {
//         return Indicator(
//           isActive:
//               state.selectedIndex % images.length == index ? true : false,
//         );
//       },
//       separatorBuilder: (context, index) => const SizedBox(width: 2),
//       itemCount: images.length,
//     ),
//   ),
// ),

// SizedBox(
//   height: 200,
//   child: PageView.builder(
//     controller: pageController,
//     itemBuilder: itemBuilderPopular2,
//     onPageChanged: (value) {
//       bloc.add(SlidePageView(selectedIndex: value));
//     },
//   ),
// ),

// @override
// void initState() {
//   super.initState();
//   timer = Timer.periodic(const Duration(seconds: 5), (time) async {
//     final nexPage = (pageController.page?.toInt() ?? 0);
//     await pageController.animateToPage(
//       nexPage + 1,
//       duration: const Duration(milliseconds: 350),
//       curve: Curves.ease,
//     );
//   });
// }

// @override
// void dispose() {
//   timer!.cancel();
//   pageController.dispose();
//   super.dispose();
// }
