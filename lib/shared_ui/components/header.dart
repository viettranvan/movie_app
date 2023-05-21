import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialClassicHeader(color: darkBlueColor);
  }
}
