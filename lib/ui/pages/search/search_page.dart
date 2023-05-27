import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/index.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkWhiteColor,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            hintText: 'Search for movies, tv shows, people...'.padLeft(14),
            onChanged: (value) {},
          ),
          Expanded(
            child: SmartRefresher(
              controller: RefreshController(),
              enablePullUp: true,
              enablePullDown: true,
              header: const Header(),
              footer: const Footer(
                height: 140,
              ),
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                shrinkWrap: true,
                primary: false,
                itemCount: 10,
                itemBuilder: itemBuilder,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 19,
                  crossAxisSpacing: 19,
                  childAspectRatio: 0.7,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return Container(
      // height: 300,
      color: Colors.red,
      child: Text(
        'Thanh Hương',
        style: TextStyle(color: whiteColor),
      ),
    );
  }
}
