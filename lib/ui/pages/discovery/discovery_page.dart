import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/index.dart';
import 'package:movie_app/ui/components/components.dart';

class DiscoveryPage extends StatelessWidget {
  const DiscoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 0,
        centerTitle: false,
        title: const CustomAppBarTitle(
          titleAppBar: 'Profile',
        ),
        paddingActions: const EdgeInsets.fromLTRB(0, 8, 12, 8),
        actions: Image.asset(
          ImagesPath.primaryShortLogo.assetName,
          scale: 4,
          filterQuality: FilterQuality.high,
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Discovery',
            ),
          ],
        ),
      ),
    );
  }
}
