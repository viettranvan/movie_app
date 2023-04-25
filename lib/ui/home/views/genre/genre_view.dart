import 'package:flutter/material.dart';
import 'package:movie_app/ui/home/views/genre/widgets/index.dart';

class Genreview extends StatelessWidget {
  const Genreview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        primary: true,
        padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: itemBuilder,
        separatorBuilder: separatorBuilder,
        itemCount: 5,
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return ItemGenre(
      text: 'Animation',
      onTap: () {},
    );
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox(width: 10);
  }
}
