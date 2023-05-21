import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/index.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkWhiteColor,
      appBar: CustomAppBar(
        leadingWidth: 0,
        centerTitle: false,
        title: const CustomAppBarTitle(
          titleAppBar: 'Search',
        ),
        paddingActions: const EdgeInsets.fromLTRB(0, 8, 12, 8),
        actions: Image.asset(
          ImagesPath.primaryShortLogo.assetName,
          scale: 4,
          filterQuality: FilterQuality.high,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      cursorColor: darkBlueColor,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: whiteColor,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        hintText: 'Search for movies, tv shows, people...'.padLeft(14),
                        hintStyle: TextStyle(
                          color: greyColor,
                        ),
                        prefixIcon: SvgPicture.asset(
                          ImagesPath.searchIcon.assetName,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                            darkBlueColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: whiteColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: whiteColor,
                          ),
                        ),
                      ),
                      obscureText: false,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: darkBlueColor,
                    ),
                    child: SvgPicture.asset(
                      ImagesPath.filterIcon.assetName,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
