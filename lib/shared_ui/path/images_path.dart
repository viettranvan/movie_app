enum ImagesPath {
  homeIcon('lib/shared_ui/assets/images/home_icon.png'),
  favoriteIcon('lib/shared_ui/assets/images/favorite_icon.png'),
  searchIcon('lib/shared_ui/assets/images/search_icon.png'),
  profileIcon('lib/shared_ui/assets/images/profile_icon.png'),
  appBarLogo('lib/shared_ui/assets/images/app_bar_logo.png');

  const ImagesPath(this.assetName);
  final String assetName;
}
