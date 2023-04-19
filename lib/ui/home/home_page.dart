import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/index.dart';
import 'package:movie_app/ui/details/details_page.dart';
import 'package:movie_app/ui/home/widgets/index.dart';
import 'package:movie_app/ui/navigation/bloc/navigation_bloc.dart';
import 'package:movie_app/utils/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    CarouselController upcomingController = CarouselController();
    CarouselController nowPlayingController = CarouselController();
    return Scaffold(
      backgroundColor: darkWhiteColor,
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
            const SizedBox(height: 18),
            const TitleWidget(
              paddingLeft: 20,
              textTitle: 'Popular Genres',
              sizeTitle: 15,
              
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 30,
              child: ListView.separated(
                primary: true,
                padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: itemBuilderGenre,
                separatorBuilder: separatorBuilderGengre,
                itemCount: 5,
              ),
            ),
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
            CarouselSlider.builder(
              carouselController: nowPlayingController,
              itemBuilder: itemBuilderNowPlaying,
              itemCount: 5,
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                onPageChanged: (index, reason) {},
              ),
            ),
            const SizedBox(height: 28),
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
            SizedBox(
              height: 213,
              child: ListView.separated(
                primary: true,
                padding: const EdgeInsets.fromLTRB(17, 5, 17, 5),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: itemBuilderTrending,
                separatorBuilder: separatorBuilderGengre,
                itemCount: 11,
              ),
            ),
            const SizedBox(height: 28),
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
            const SizedBox(height: 28),
            TitleWidget(
              visibleIcon: true,
              paddingLeft: 0,
              textTitle: 'Upcoming',
              sizeTitle: 20,
              icon: Icon(
                Icons.update_sharp,
                color: greyColor,
              ),
            ),
            const SizedBox(height: 28),
            CarouselSlider.builder(
              carouselController: upcomingController,
              itemBuilder: itemBuilderUpcoming,
              itemCount: 5,
              options: CarouselOptions(
                height: 360,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {},
              ),
            ),
            const SizedBox(height: 28),
            Container(
              height: 150,
              color: Colors.red,
            ),
            Container(
              height: 150,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBuilderNowPlaying(BuildContext context, int index, int realIndex) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const DetailsPage(),
      )),
      child: SizedBox(
        child: Image.network(
          '${AppConstants.kImagePathBackdrop}/ovM06PdF3M8wvKb06i4sjW3xoww.jpg',
          width: double.infinity,
          filterQuality: FilterQuality.high,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget itemBuilderGenre(BuildContext context, int index) {
    return ItemGenre(
      text: 'Genre aaaaaa',
      onTap: () {},
    );
  }

  Widget itemBuilderUpcoming(BuildContext context, int index, int realIndex) {
    return ItemUpcoming(
      image: Image.network(
        '${AppConstants.kImagePathPoster}/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg',
      ).image,
      onTap: () {},
    );
  }

  Widget itemBuilderTrending(BuildContext context, int index) {
    return ItemTrending(
      title: 'Spider-Man: No way home',
      index: index,
      itemCount: 10,
      image: Image.network(
        '${AppConstants.kImagePathPoster}/uJYYizSuA9Y3DCs0qS4qWvHfZg4.jpg',
      ).image,
      onTapViewAll: () {},
      onTapItem: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const DetailsPage(),
        ),
      ),
    );
  }

  Widget separatorBuilderGengre(BuildContext context, int index) {
    return const SizedBox(width: 10);
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
