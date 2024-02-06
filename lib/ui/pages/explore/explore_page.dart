import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/explore/bloc/explore_bloc.dart';
import 'package:movie_app/ui/pages/explore/views/born_today/index.dart';
import 'package:movie_app/ui/pages/explore/views/movie_provider/index.dart';
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
            return ScaffoldMessenger(
              child: Scaffold(
                appBar: CustomAppBar(
                  leadingWidth: 0,
                  centerTitle: false,
                  title: const CustomAppBarTitle(
                    titleAppBar: 'Explore features',
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 15.w, 0),
                      child: Icon(
                        Icons.notifications_sharp,
                        size: 30.sp,
                      ),
                    ),
                  ],
                ),
                body: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    final scrollDirection = bloc.scrollController.position.userScrollDirection;
                    if (scrollDirection == ScrollDirection.forward) {
                      showNavigationBar(context);
                      return false;
                    } else if (scrollDirection == ScrollDirection.idle) {
                      return false;
                    } else {
                      hideNavigationBar(context);
                      return false;
                    }
                  },
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        controller: bloc.scrollController,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 20.h),
                            const TrailerView(),
                            SizedBox(height: 30.h),
                            const TopRatedView(),
                            const BornToday(),
                            SizedBox(height: 30.h),
                            const MovieProviderView(),
                            SizedBox(height: 1000.h),
                          ],
                        ),
                      ),
                      CustomToast(
                        statusMessage: state.statusMessage,
                        opacity: state.opacity,
                        visible: state.visible,
                        onEndAnimation: () => state.opacity == 0.0
                            ? bloc.add(DisplayToast(
                                visibility: false,
                                statusMessage: state.statusMessage,
                              ))
                            : null,
                      ),
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
