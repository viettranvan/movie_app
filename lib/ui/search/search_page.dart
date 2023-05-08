import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/index.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 0,
        centerTitle: false,
        title: const CustomAppBarTitle(
          titleAppBar: 'Search',
        ),
        paddingActions: const EdgeInsets.fromLTRB(0, 8, 12, 8),
        actions: Image.asset(
          ImagesPath.primaryShortLogo.assetName,
          scale: 4,
          filterQuality: FilterQuality.high,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Search',
            ),
          ],
        ),
      ),
    );
  }
}
