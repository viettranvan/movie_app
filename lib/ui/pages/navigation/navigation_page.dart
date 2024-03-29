import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/explore/index.dart';
import 'package:movie_app/ui/pages/home/index.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';
import 'package:movie_app/ui/pages/profile/index.dart';
import 'package:movie_app/ui/pages/search/index.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc()
        ..add(NavigatePage(
          indexPage: 0,
        )),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<NavigationBloc>(context);
          return Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: false,
            body: IndexedStack(
              index: state.indexPage,
              children: const [
                HomePage(),
                ExplorePage(),
                SearchPage(),
                ProfilePage(),
              ],
            ),
            bottomNavigationBar: CustomNavigationBar(
              visible: state.visible,
              opacity: state.visible ? 1.0 : 0.0,
              background: BlurBackground(
                sigmaX: 3,
                sigmaY: 3,
                heightBackground: 60.h,
                paddingHorizontal: 25.w,
                radiusCorner: 30.r,
              ),
              margin: EdgeInsets.fromLTRB(25.w, 0.h, 25.w, 23.h),
              padding: EdgeInsets.fromLTRB(23.w, 7.h, 23.w, 7.h),
              indexPage: state.indexPage,
              items: [
                CustomNavigationBarItem(
                  imagePath: ImagesPath.homeIcon.assetName,
                  onTap: () => state.indexPage != 0
                      ? bloc.add(NavigatePage(indexPage: 0))
                      : bloc.add(ScrollTop()),
                ),
                CustomNavigationBarItem(
                  imagePath: ImagesPath.favoriteIcon.assetName,
                  onTap: () => state.indexPage != 1
                      ? bloc.add(NavigatePage(indexPage: 1))
                      : bloc.add(ScrollTop()),
                ),
                CustomNavigationBarItem(
                  imagePath: ImagesPath.searchIcon.assetName,
                  onTap: () => state.indexPage != 2 ? bloc.add(NavigatePage(indexPage: 2)) : null,
                ),
                CustomNavigationBarItem(
                  imagePath: ImagesPath.profileIcon.assetName,
                  onTap: () => state.indexPage != 3 ? bloc.add(NavigatePage(indexPage: 3)) : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
