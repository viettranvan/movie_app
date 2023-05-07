import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/ui/favorite/widgets/custom_load_more.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TvView extends StatelessWidget {
  const TvView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RefreshController();
    return SmartRefresher(
      controller: controller,
      onRefresh: () {},
      onLoading: () {},
      enablePullDown: true,
      enablePullUp: true,
      footer: const CustomLoadMore(
        height: 140,
      ),
      child: Container(
        color: Colors.red,
        child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
          itemBuilder: itemBuilder,
          separatorBuilder: separatorBuilder,
          itemCount: 10,
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 140,
        color: blackColor,
      ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(height: 18);
}
