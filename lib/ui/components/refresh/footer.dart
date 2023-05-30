import 'package:flutter/cupertino.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Footer extends StatelessWidget {
  final double? height;
  final String? noMoreStatus;
  final String? failedStatus;
  const Footer({
    super.key,
    this.height,
    this.noMoreStatus,
    this.failedStatus,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      height: height ?? 0,
      builder: builder,
    );
  }

  Widget builder(BuildContext context, LoadStatus? mode) {
    Widget body;
    switch (mode) {
      case LoadStatus.idle:
        body = const SizedBox();
        break;
      case LoadStatus.canLoading:
        body = const CustomIndicator();
        break;
      case LoadStatus.loading:
        body = const CustomIndicator();
        break;
      case LoadStatus.failed:
        body = Text(
          failedStatus ?? 'Failed to load data!',
          style: const TextStyle(
            fontSize: 15,
          ),
        );
        break;
      case LoadStatus.noMore:
        body = Text(
          noMoreStatus ?? 'No more data!',
          style: const TextStyle(
            fontSize: 15,
          ),
        );
        break;
      default:
        body = const SizedBox();
    }
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: body,
    ));
  }
}
