import 'package:flutter/material.dart';
import 'package:movie_app/ui/home/widgets/title_widget.dart';
import 'package:movie_app/utils/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 44),
            const TitleWidget(textTitle: 'Stream Everywhere'),
            const SizedBox(height: 28),
            FittedBox(
              child: Image.network(
                '${AppConstants.kImagePath}/ovM06PdF3M8wvKb06i4sjW3xoww.jpg',
                width: 327,
                height: 170,
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 28),
            const TitleWidget(textTitle: 'Trending'),
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
