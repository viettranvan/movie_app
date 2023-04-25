enum ImagesPath {
  homeIcon('lib/shared_ui/assets/images/home_icon.png'),
  favoriteIcon('lib/shared_ui/assets/images/favorite_icon.png'),
  searchIcon('lib/shared_ui/assets/images/search_icon.png'),
  profileIcon('lib/shared_ui/assets/images/profile_icon.png'),
  primaryLongLogo('lib/shared_ui/assets/images/primary_long_logo.png'),
  primaryShortLogo('lib/shared_ui/assets/images/primary_short_logo.png'),
  trendingIcon('lib/shared_ui/assets/images/trending_icon.png'),
  bestDramaIcon('lib/shared_ui/assets/images/best_drama_icon.png'),
  upcomingIcon('lib/shared_ui/assets/images/upcoming_icon.png'),

  tvShowIcon('lib/shared_ui/assets/images/tv_show_icon.png'),

  noImage(
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPFX24dOkZavnvV7R9supHkmmSEXlCTbKRQamQkrhN&s');

  const ImagesPath(this.assetName);
  final String assetName;
}
