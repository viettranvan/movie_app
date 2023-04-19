import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class ItemTrending extends StatelessWidget {
  final int itemCount;
  final int index;
  final VoidCallback? onTapItem;
  final VoidCallback? onTapViewAll;
  final ImageProvider<Object> image;
  final String? title;
  const ItemTrending({
    super.key,
    required this.itemCount,
    required this.index,
    this.onTapItem,
    this.onTapViewAll,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: index == itemCount ? onTapViewAll : onTapItem,
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: lightGreyColor,
              blurRadius: 5,
            ),
          ],
        ),
        child: index == itemCount
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: darkBlueColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Positioned.fill(
                          right: 10,
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text('View all'),
                  ],
                ),
              )
            : Column(
                children: [
                  Container(
                    height: 171,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      color: Colors.green,
                      image: DecorationImage(
                        image: image,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7),
                    child: Text(
                      title ?? '',
                      maxLines: 1,
                      softWrap: false,
                      style: const TextStyle(
                        fontSize: 15,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}