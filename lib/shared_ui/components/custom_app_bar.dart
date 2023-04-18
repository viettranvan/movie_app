// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/index.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final BuildContext context;
  final Widget leading;
  final String? title;
  final int indexPage;
  final bool centerTitle;
  const CustomAppBar({
    Key? key,
    required this.context,
    required this.leading,
    this.title,
    required this.centerTitle,
    required this.indexPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: darkBlueColor,
      centerTitle: indexPage == 0 ? true : false,
      elevation: 0,
      titleSpacing: indexPage == 0 ? null : 16,
      leadingWidth: indexPage == 0 ? null : 0,
      leading: Visibility(
        visible: indexPage == 0 ? true : false,
        child: indexPage == 0 ? leading : const SizedBox(),
      ),
      title: indexPage == 0
          ? Image.asset(
              ImagesPath.primaryLongLogo.assetName,
              filterQuality: FilterQuality.high,
            )
          : Text(
              title ?? '',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
      actions: [
        (indexPage == 0 || indexPage == 3)
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Icon(
                  indexPage == 0 ? Icons.notifications_sharp : Icons.exit_to_app_sharp,
                  size: 30,
                ),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 12, 8),
                child: Image.asset(
                  ImagesPath.primaryShortLogo.assetName,
                  scale: 4,
                  filterQuality: FilterQuality.high,
                ),
              ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
