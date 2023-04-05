import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/path/images_path.dart';

import 'bloc/navigation_bloc.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc()..add(NavigateScreen(indexPage: 0)),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          var bloc = BlocProvider.of<NavigationBloc>(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: state.pages[bloc.indexPage],
            bottomSheet: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 21,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => bloc.add(NavigateScreen(indexPage: 0)),
                      child: Image.asset(
                        bloc.indexPage == 0
                            ? ImagesPath.homeSelectedIcon.assetName
                            : ImagesPath.homeUnselectedIcon.assetName,
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => bloc.add(NavigateScreen(indexPage: 1)),
                      child: Image.asset(
                        bloc.indexPage == 1
                            ? ImagesPath.discoverySelectedIcon.assetName
                            : ImagesPath.discoveryUnselectedIcon.assetName,
                        height: 26,
                        width: 26,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => bloc.add(NavigateScreen(indexPage: 2)),
                      child: Image.asset(
                        bloc.indexPage == 2
                            ? ImagesPath.profileSelectedIcon.assetName
                            : ImagesPath.profileUnselectedIcon.assetName,
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
