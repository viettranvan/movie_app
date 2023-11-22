import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/explore/bloc/explore_bloc.dart';
import 'package:movie_app/ui/pages/explore/views/top_rated/index.dart';
import 'package:movie_app/ui/pages/explore/views/trailer/index.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreBloc(),
      child: BlocListener<NavigationBloc, NavigationState>(
        listener: (context, state) => state is NavigationScrollSuccess ? reloadPage(context) : null,
        child: BlocBuilder<ExploreBloc, ExploreState>(
          builder: (context, state) {
            final bloc = BlocProvider.of<ExploreBloc>(context);
            return Scaffold(
              appBar: CustomAppBar(
                leadingWidth: 0,
                centerTitle: false,
                title: const CustomAppBarTitle(
                  titleAppBar: 'Explore',
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 8.h, 12.w, 8.h),
                    child: Image.asset(
                      ImagesPath.primaryShortLogo.assetName,
                      scale: 4,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ],
              ),
              body: NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  if (bloc.scrollController.position.userScrollDirection ==
                      ScrollDirection.forward) {
                    showNavigationBar(context);
                    return false;
                  }
                  if (bloc.scrollController.position.userScrollDirection ==
                      ScrollDirection.reverse) {
                    hideNavigationBar(context);
                    return false;
                  }
                  bloc.add(PlayPauseVideo());
                  return false;
                },
                child: SingleChildScrollView(
                  controller: bloc.scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20.h),
                      const TrailerView(),
                      SizedBox(height: 20.h),
                      const TopRatedView(),
                      SizedBox(height: 1000.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  reloadPage(BuildContext context) {
    final bloc = BlocProvider.of<ExploreBloc>(context);
    if (bloc.scrollController.hasClients) {
      bloc.scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate,
      );
    }
  }

  showNavigationBar(BuildContext context) =>
      BlocProvider.of<NavigationBloc>(context).add(ShowHide(visible: true));

  hideNavigationBar(BuildContext context) =>
      BlocProvider.of<NavigationBloc>(context).add(ShowHide(visible: false));
}
