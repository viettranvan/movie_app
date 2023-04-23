import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/index.dart';
import 'package:movie_app/shared_ui/transitions/custom_page_route.dart';
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
              textTitle: 'Popular',
              sizeTitle: 20,
              icon: Icon(
                Icons.stars_outlined,
                color: greyColor,
              ),
            ),
            const SizedBox(height: 15),
            CarouselSlider.builder(
              carouselController: nowPlayingController,
              itemBuilder: itemBuilderPopular,
              itemCount: 5,
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                onPageChanged: (index, reason) {},
              ),
            ),
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
            SizedBox(
              height: 213,
              child: ListView.separated(
                primary: true,
                padding: const EdgeInsets.fromLTRB(17, 5, 17, 5),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: itemBuilderTrending,
                separatorBuilder: separatorBuilder,
                itemCount: 11,
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
            ItemNowPlaying(
              title: 'Peaky Blinders',
              season: 6, // lay latest season
              episode: 3, // lay latest episode
              overview:
                  'A gangster family epic set in 1919 Birmingham, England and centered on a gang who sew razor blades in the peaks...',
              image: Image.network(
                '${AppConstants.kImagePathPoster}/vUUqzWa2LnHIVqkaKVlVGkVcZIW.jpg',
              ).image,
              colors: [darkTealColor, tealColor],
              onTap: () => Navigator.of(context).push(
                CustomPageRoute(
                  page: const DetailsPage(),
                  begin: const Offset(1, 0),
                ),
              ),
            ),
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
            SizedBox(
              height: 213,
              child: ListView.separated(
                primary: true,
                padding: const EdgeInsets.fromLTRB(17, 5, 17, 5),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: itemBuilderDrama,
                separatorBuilder: separatorBuilder,
                itemCount: 11,
              ),
            ),
            const SizedBox(height: 30),
            const TitleWidget(
              paddingLeft: 17,
              textTitle: 'Popular Artists',
              sizeTitle: 15,
            ),
            const SizedBox(height: 7),
            SizedBox(
              height: 150,
              child: ListView.separated(
                primary: true,
                padding: const EdgeInsets.fromLTRB(17, 5, 17, 5),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: itemBuilderArtist,
                separatorBuilder: separatorBuilder,
                itemCount: 11,
              ),
            ),
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
            SizedBox(
              height: 213,
              child: ListView.separated(
                primary: true,
                padding: const EdgeInsets.fromLTRB(17, 5, 17, 5),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: itemBuilderTvShow,
                separatorBuilder: separatorBuilder,
                itemCount: 11,
              ),
            ),
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
            CarouselSlider.builder(
              carouselController: upcomingController,
              itemBuilder: itemBuilderUpcoming,
              itemCount: 5,
              options: CarouselOptions(
                height: 365,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {},
              ),
            ),
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

  Widget itemBuilderPopular(BuildContext context, int index, int realIndex) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ),
      ),
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
      text: 'Animation',
      onTap: () {},
    );
  }

  Widget itemBuilderTrending(BuildContext context, int index) {
    return ItemMovieTv(
      title: 'Thor: Love and Thunder',
      index: index,
      itemCount: 10,
      image: Image.network(
        '${AppConstants.kImagePathPoster}/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg',
      ).image,
      onTapViewAll: () {},
      onTapItem: () => Navigator.of(context).push(
        CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ),
      ),
    );
  }

  Widget itemBuilderArtist(BuildContext context, int index) {
    return ItemArtist(
      title: 'Scarlett Johansson',
      image: Image.network(
        '${AppConstants.kImagePathPoster}/9TC1fyJXX3UEcKJ2erFuyMERxdf.jpg',
      ).image,
      index: index,
      itemCount: 10,
      onTapItem: () => Navigator.of(context).push(
        CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ),
      ),
      onTapViewAll: () {},
    );
  }

  Widget itemBuilderDrama(BuildContext context, int index) {
    return ItemMovieTv(
      title: 'The Last Of Us',
      index: index,
      itemCount: 10,
      image: Image.network(
        '${AppConstants.kImagePathPoster}/uDgy6hyPd82kOHh6I95FLtLnj6p.jpg',
      ).image,
      onTapViewAll: () {},
      onTapItem: () => Navigator.of(context).push(
        CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ),
      ),
    );
  }

  Widget itemBuilderTvShow(BuildContext context, int index) {
    return ItemMovieTv(
      title: 'Spider-Man: No way home',
      index: index,
      itemCount: 10,
      image: Image.network(
        '${AppConstants.kImagePathPoster}/uJYYizSuA9Y3DCs0qS4qWvHfZg4.jpg',
      ).image,
      onTapViewAll: () {},
      onTapItem: () => Navigator.of(context).push(
        CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ),
      ),
    );
  }

  Widget itemBuilderUpcoming(BuildContext context, int index, int realIndex) {
    return ItemUpcoming(
      image: Image.network(
        '${AppConstants.kImagePathPoster}/uJYYizSuA9Y3DCs0qS4qWvHfZg4.jpg',
      ).image,
      onTap: () => Navigator.of(context).push(
        CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ),
      ),
    );
  }

  Widget separatorBuilderGengre(BuildContext context, int index) {
    return const SizedBox(width: 10);
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(width: 14);
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
