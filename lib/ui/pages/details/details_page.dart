import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/color.dart';
import 'package:movie_app/ui/components/components.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
        ),
        title: const CustomAppBarTitle(titleAppBar: 'Details'),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 10, 8),
            child: Icon(
              Icons.star_outline_rounded,
              color: yellowColor,
              size: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 10, 8),
            child: Icon(
              Icons.favorite_border_outlined,
              color: pinkColor,
              size: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 10, 8),
            child: Icon(
              Icons.bookmark_outline_rounded,
              color: cyanColor,
              size: 25,
            ),
          ),
        ],
        onTapLeading: () => Navigator.of(context).pop(),
      ),
    );
  }
}
