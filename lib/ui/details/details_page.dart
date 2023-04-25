import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/index.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

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
        title: const CustomAppBarTitle(titleAppBar: 'Details'),
        actions: const Icon(
          Icons.menu,
          size: 30,
        ),
        onTapLeading: () => Navigator.of(context).pop(),
      ),
    );
  }
}
