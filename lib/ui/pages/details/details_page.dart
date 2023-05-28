import 'package:flutter/material.dart';
import 'package:movie_app/ui/components/components.dart';

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
        actions: const [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: Icon(
              Icons.star_outline_rounded,
              size: 32,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 10, 8),
            child: Icon(
              Icons.bookmark_outline_rounded,
              size: 32,
            ),
          ),
        ],
        onTapLeading: () => Navigator.of(context).pop(),
      ),
    );
  }
}
