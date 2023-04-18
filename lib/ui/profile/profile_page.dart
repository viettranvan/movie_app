import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/index.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        leadingWidth: 0,
        centerTitle: false,
        title: CustomAppBarTitle(
          titleAppBar: 'Profile',
        ),
        paddingActions: EdgeInsets.fromLTRB(0, 8, 12, 8),
        actions: Icon(
          Icons.exit_to_app_sharp,
          size: 30,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
