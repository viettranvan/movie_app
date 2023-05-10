import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/index.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';

import 'widgets/index.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc()
        ..add(NavigateScreen(
          indexPage: 0,
        )),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          var bloc = BlocProvider.of<NavigationBloc>(context);
          return Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: false,
            body: IndexedStack(
              index: state.indexPage,
              children: state.pages,
            ),
            bottomNavigationBar: CustomNavigationBar(
              background: const BlurBackground(
                sigmaX: 3,
                sigmaY: 3,
                heightBackground: 60,
                paddingHorizontal: 25,
                radiusCorner: 30,
              ),
              margin: const EdgeInsets.fromLTRB(25, 0, 25, 23),
              padding: const EdgeInsets.fromLTRB(23, 7, 23, 7),
              lengthPages: state.pages.length,
              indexPage: state.indexPage,
              items: [
                CustomNavigationBarItem(
                  imagePath: ImagesPath.homeIcon.assetName,
                  onTap: () => bloc.add(NavigateScreen(indexPage: 0)),
                ),
                CustomNavigationBarItem(
                  imagePath: ImagesPath.favoriteIcon.assetName,
                  onTap: () => bloc.add(NavigateScreen(indexPage: 1)),
                ),
                CustomNavigationBarItem(
                  imagePath: ImagesPath.searchIcon.assetName,
                  onTap: () => bloc.add(NavigateScreen(indexPage: 2)),
                ),
                CustomNavigationBarItem(
                  imagePath: ImagesPath.profileIcon.assetName,
                  onTap: () => bloc.add(NavigateScreen(indexPage: 3)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
// Icon(Icons.arrow_back_ios),