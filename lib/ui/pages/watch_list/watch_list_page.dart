import 'package:flutter/material.dart';
import 'package:movie_app/ui/components/components.dart';

class WatchListPage extends StatelessWidget {
  const WatchListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          child: Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
        ),
        title: const CustomAppBarTitle(titleAppBar: 'Watchlist'),
        onTapLeading: () => Navigator.of(context).pop(),
      ),
    );
  }
}
