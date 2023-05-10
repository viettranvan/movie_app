import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/index.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    required this.title,
    this.onBackPress,
    this.titleIconPath,
  });

  final String title;
  final VoidCallback? onBackPress;
  final String? titleIconPath;

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          onBackPress?.call();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset(
            ImagesPath.backIcon.assetName,
            height: 24,
            width: 24,
          ),
        ),
      ),
      leadingWidth: 40,
      centerTitle: titleIconPath != null ? true : false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.0,
      title: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: titleIconPath != null
            ? Row(
                children: [
                  const Spacer(),
                  Image.asset(
                    titleIconPath!,
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: AppStyles.body02,
                  ),
                  const Spacer(),
                ],
              )
            : Text(
                title,
                style: AppStyles.body02,
              ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
