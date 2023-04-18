import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/index.dart';
import 'package:movie_app/ui/details/details_page.dart';
import 'package:movie_app/ui/home/widgets/title_widget.dart';
import 'package:movie_app/ui/navigation/bloc/navigation_bloc.dart';
import 'package:movie_app/utils/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    CarouselController trendingController = CarouselController();
    CarouselController nowPlayingController = CarouselController();
    return Scaffold(
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
              textTitle: 'Popular Genres',
              sizeTitle: 15,
            ),
            const SizedBox(height: 15),
            const TitleWidget(
              textTitle: 'Now Playing',
              sizeTitle: 21,
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
            const TitleWidget(
              textTitle: 'Trending',
              sizeTitle: 21,
            ),
            const SizedBox(height: 28),
            CarouselSlider.builder(
              carouselController: trendingController,
              itemBuilder: itemBuilderTrending,
              itemCount: 5,
              options: CarouselOptions(
                height: 336,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {},
              ),
            ),
            const SizedBox(height: 28),
            const TitleWidget(
              textTitle: 'Popular',
              sizeTitle: 21,
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

  Widget itemBuilderTrending(BuildContext context, int index, int realIndex) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.fromLTRB(2.5, 0, 2.5, 0),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          image: DecorationImage(
            image: Image.network(
              '${AppConstants.kImagePathPoster}/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg',
            ).image,
            filterQuality: FilterQuality.high,
            fit: BoxFit.fill,
          ),
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
