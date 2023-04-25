import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/index.dart';
import 'package:movie_app/ui/home/views/artist/index.dart';
import 'package:movie_app/ui/home/views/best_drama/index.dart';
import 'package:movie_app/ui/home/views/genre/index.dart';
import 'package:movie_app/ui/home/views/now_playing/index.dart';
import 'package:movie_app/ui/home/views/popular/index.dart';
import 'package:movie_app/ui/home/views/trending/index.dart';
import 'package:movie_app/ui/home/views/tv_show/index.dart';
import 'package:movie_app/ui/home/views/upcoming/index.dart';
import 'package:movie_app/ui/home/widgets/index.dart';
import 'package:movie_app/ui/navigation/bloc/navigation_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          children: [
            const SizedBox(height: 15),
            const TitleWidget(
              paddingLeft: 17,
              textTitle: 'Popular Genres',
              sizeTitle: 15,
            ),
            const SizedBox(height: 7),
            const Genreview(),
            const SizedBox(height: 30),
            TitleWidget(
              visibleIcon: true,
              paddingLeft: 0,
              textTitle: 'Popular',
              sizeTitle: 20,
              icon: Icon(
                Icons.stars_outlined,
                color: greyColor,
              ),
            ),
            const SizedBox(height: 15),
            const PopularView(),
            const SizedBox(height: 30),
            TitleWidget(
              visibleIcon: true,
              paddingLeft: 0,
              textTitle: 'Trending',
              visibleViewAll: true,
              onTapViewAll: () {},
              sizeTitle: 20,
              icon: Image.asset(
                ImagesPath.trendingIcon.assetName,
                filterQuality: FilterQuality.high,
              ),
            ),
            const SizedBox(height: 15),
            const TrendingView(),
            const SizedBox(height: 30),
            TitleWidget(
              visibleIcon: true,
              paddingLeft: 0,
              textTitle: 'Now Playing',
              sizeTitle: 20,
              icon: Icon(
                Icons.smart_display_outlined,
                color: greyColor,
              ),
            ),
            const SizedBox(height: 15),
            const NowPlayingView(),
            const SizedBox(height: 30),
            TitleWidget(
              visibleIcon: true,
              paddingLeft: 0,
              textTitle: 'Best Drama',
              sizeTitle: 20,
              visibleViewAll: true,
              onTapViewAll: () {},
              icon: Image.asset(
                ImagesPath.bestDramaIcon.assetName,
                filterQuality: FilterQuality.high,
              ),
            ),
            const SizedBox(height: 15),
            const BestDramaView(),
            const SizedBox(height: 30),
            const TitleWidget(
              paddingLeft: 17,
              textTitle: 'Popular Artists',
              sizeTitle: 15,
            ),
            const SizedBox(height: 7),
            const ArtistView(),
            const SizedBox(height: 30),
            TitleWidget(
              visibleIcon: true,
              paddingLeft: 0,
              textTitle: 'Top TV Shows',
              sizeTitle: 20,
              visibleViewAll: true,
              onTapViewAll: () {},
              icon: Image.asset(
                ImagesPath.tvShowIcon.assetName,
                filterQuality: FilterQuality.high,
              ),
            ),
            const SizedBox(height: 15),
            const TvShowView(),
            const SizedBox(height: 30),
            TitleWidget(
              visibleIcon: true,
              paddingLeft: 0,
              textTitle: 'Upcoming',
              sizeTitle: 20,
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



