import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/index.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //   centerTitle: false,
      //   title: const Text('Your Favorite'),
      //   context: context,
      //   visibleAvatar: true,
      //   visibleNotificationIcon: true,
      //   visiblePrimaryLongLogo: true,
      //   visiblePrimaryShortLogo: false,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Favorite',
            ),
          ],
        ),
      ),
    );
  }
}
