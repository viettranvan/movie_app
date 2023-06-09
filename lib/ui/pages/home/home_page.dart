import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          if (state is NavigationInitial) {
            BlocProvider.of<HomeBloc>(context).scrollController.jumpTo(0);
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
                controller: bloc.refreshController,
                scrollController: bloc.scrollController,
                header: const Header(),
                onRefresh: () => bloc.add(RefreshData()),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20),
                    Genreview(),
                    SizedBox(height: 30),
                    PopularView(),
                    SizedBox(height: 30),
                    TrendingView(),
                    SizedBox(height: 30),
                    NowPlayingView(),
                    SizedBox(height: 30),
                    BestDramaView(),
                    SizedBox(height: 30),
                    ArtistView(),
                    SizedBox(height: 30),
                    TopTvView(),
                    SizedBox(height: 30),
                    UpcomingView(),
                    SizedBox(height: 110),
                  ],
                ),
              ),
            );
          },
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
