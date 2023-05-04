import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/index.dart';
import 'package:movie_app/ui/home/bloc/home_bloc.dart';
import 'package:movie_app/ui/home/views/artist/index.dart';
import 'package:movie_app/ui/home/views/best_drama/index.dart';
import 'package:movie_app/ui/home/views/genre/index.dart';
import 'package:movie_app/ui/home/views/now_playing/index.dart';
import 'package:movie_app/ui/home/views/popular/index.dart';
import 'package:movie_app/ui/home/views/top_tv/index.dart';
import 'package:movie_app/ui/home/views/trending/index.dart';
import 'package:movie_app/ui/home/views/upcoming/index.dart';
import 'package:movie_app/ui/home/widgets/index.dart';
import 'package:movie_app/ui/navigation/bloc/navigation_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(SwitchType(isActive: false)),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          var bloc = BlocProvider.of<HomeBloc>(context);
          return Scaffold(
            backgroundColor: whiteColor,
            appBar: CustomAppBar(
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: CircleAvatar(
                  backgroundImage: Image.network(
                    ImagesPath.noImage.assetName,
                    filterQuality: FilterQuality.high,
                  ).image,
                ),
              ),
              title: Image.asset(
                ImagesPath.primaryLongLogo.assetName,
                filterQuality: FilterQuality.high,
              ),
              actions: const Icon(
                Icons.notifications_sharp,
                size: 30,
              ),
              onTapLeading: () => BlocProvider.of<NavigationBloc>(context).add(
                NavigateScreen(indexPage: 3),
              ),
            ),
            body: SingleChildScrollView(
              primary: true,
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
                      // filterQuality: FilterQuality.high,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const TrendingView(),
                  const SizedBox(height: 30),
                  PrimaryTitle(
                    visibleIcon: true,
                    title: 'Now Playing',
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
                      // filterQuality: FilterQuality.high,
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
                      // filterQuality: FilterQuality.high,
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
                  const SizedBox(height: 30),
                  Container(
                    height: 80,
                    color: darkWhiteColor,
                  ),
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



