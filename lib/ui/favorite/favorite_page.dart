import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/index.dart';
import 'package:movie_app/ui/favorite/bloc/favorite_bloc.dart';
import 'package:movie_app/ui/favorite/widgets/index.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc()..add(ChangeTab(index: 0)),
      child: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          var bloc = BlocProvider.of<FavoriteBloc>(context);
          return Scaffold(
            appBar: CustomAppBar(
              leadingWidth: 0,
              centerTitle: false,
              title: const CustomAppBarTitle(
                titleAppBar: 'Your Favorite',
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTabBar(
                    widthTabBar: double.infinity,
                    index: state.index,
                    onTapMovie: () => bloc.add(ChangeTab(index: 0)),
                    onTapTv: () => bloc.add(ChangeTab(index: 1)),
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: state.index,
                      children: state.views,
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
