import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/ui.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 0,
        centerTitle: false,
        title: const CustomAppBarTitle(
          titleAppBar: 'Profile',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                CustomPageRoute(
                  page: const FavoritePage(),
                  begin: const Offset(1, 0),
                ),
              ),
              child: const Text(
                'My Favorites',
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                CustomPageRoute(
                  page: const WatchlistPage(),
                  begin: const Offset(1, 0),
                ),
              ),
              child: const Text(
                'My Watchlist',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
