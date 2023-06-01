import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      create: (context) => HomeBloc()..add(SwitchType(isActive: false)),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
           if (state is HomeSuccess) {
            BlocProvider.of<HomeBloc>(context).add(SwitchType(isActive: false));
          }
        },
        builder: (context, state) {
          var bloc = BlocProvider.of<HomeBloc>(context);
          return Scaffold(
            backgroundColor: whiteColor,
            appBar: CustomAppBar(
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
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
              actions: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Icon(
                    Icons.notifications_sharp,
                    size: 30,
                  ),
                ),
              ],
              onTapLeading: () => BlocProvider.of<NavigationBloc>(context).add(
                NavigatePage(indexPage: 3),
              ),
            ),
            body: SmartRefresher(
              controller:bloc.refreshController,
              primary: true,
              header: const Header(),
              onRefresh: () => bloc.add(RefreshData()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  SecondaryTitle(
                    title: 'Popular Genres',
                    leftWidget: CustomSwitch(
                      isActive: state.isActive,
                      onSwitchMovie: () => bloc.add(SwitchType(isActive: false)),
                      onSwitchTV: () => bloc.add(SwitchType(isActive: true)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Genreview(isActive: state.isActive),
                  const SizedBox(height: 30),
                  PrimaryTitle(
                    visibleIcon: true,
                    title: 'Popular',
                    visibleViewAll: true,
                    onTapViewAll: () {},
                    icon: Icon(
                      Icons.stars_outlined,
                      color: greyColor,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const PopularView(),
                  const SizedBox(height: 30),
                  PrimaryTitle(
                    visibleIcon: true,
                    title: 'Trending',
                    visibleViewAll: true,
                    onTapViewAll: () {},
                    icon: SvgPicture.asset(
                      ImagesPath.trendingIcon.assetName,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const TrendingView(),
                  const SizedBox(height: 30),
                  PrimaryTitle(
                    visibleIcon: true,
                    title: 'Now Playing',
                    visibleViewAll: true,
                    onTapViewAll: () {},
                    icon: Icon(
                      Icons.smart_display_outlined,
                      color: greyColor,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const NowPlayingView(),
                  const SizedBox(height: 30),
                  PrimaryTitle(
                    visibleIcon: true,
                    title: 'Best Drama',
                    visibleViewAll: true,
                    onTapViewAll: () {},
                    icon: SvgPicture.asset(
                      ImagesPath.bestDramaIcon.assetName,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const BestDramaView(),
                  const SizedBox(height: 30),
                  const SecondaryTitle(
                    title: 'Popular Artists',
                  ),
                  const SizedBox(height: 12),
                  const ArtistView(),
                  const SizedBox(height: 30),
                  PrimaryTitle(
                    visibleIcon: true,
                    title: 'Top TV Shows',
                    visibleViewAll: true,
                    onTapViewAll: () {},
                    icon: SvgPicture.asset(
                      ImagesPath.tvShowIcon.assetName,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const TopTvView(),
                  const SizedBox(height: 30),
                  PrimaryTitle(
                    visibleIcon: true,
                    title: 'Upcoming',
                    visibleViewAll: true,
                    onTapViewAll: () {},
                    icon: Image.asset(
                      ImagesPath.upcomingIcon.assetName,
                      filterQuality: FilterQuality.high,
                      color: greyColor,
                      scale: 2,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const UpcomingView(),
                  const SizedBox(height: 110),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
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
