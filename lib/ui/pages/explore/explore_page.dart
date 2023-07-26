import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    RefreshController refreshController = RefreshController();
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 0,
        centerTitle: false,
        title: const CustomAppBarTitle(
          titleAppBar: 'Explore',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 12, 8),
            child: Image.asset(
              ImagesPath.primaryShortLogo.assetName,
              scale: 4,
              filterQuality: FilterQuality.high,
            ),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: refreshController,
        header: const Header(),
        onRefresh: () {
          refreshController.refreshCompleted();
        },
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            PrimaryText(title: 'Official Trailer'),
          ],
        ),
      ),
    );
  }
}
