enum ImagesPath {
  homeIcon('lib/shared_ui/assets/images/home_icon.png'),
  favoriteIcon('lib/shared_ui/assets/images/favorite_icon.png'),
  searchIcon('lib/shared_ui/assets/images/search_icon.png'),
  profileIcon('lib/shared_ui/assets/images/profile_icon.png'),
  primaryLongLogo('lib/shared_ui/assets/images/primary_long_logo.png'),
  primaryShortLogo('lib/shared_ui/assets/images/primary_short_logo.png'),
  trendingIcon('lib/shared_ui/assets/images/trending_icon.png'),
  bestDramaIcon('lib/shared_ui/assets/images/best_drama_icon.png'),
  tvShowIcon('lib/shared_ui/assets/images/tv_show_icon.png'),

  noImage(
      'https://scontent.fsgn8-4.fna.fbcdn.net/v/t39.30808-1/330798293_576320571084139_6497451970399755023_n.jpg?stp=dst-jpg_s320x320&_nc_cat=108&ccb=1-7&_nc_sid=7206a8&_nc_ohc=aoAgIRMLY7kAX_8u56b&_nc_ht=scontent.fsgn8-4.fna&oh=00_AfCv2uL6UExFQujezcoPPA2UZNY1mhWrTB3TwIVSY12AQg&oe=64417C04');

  const ImagesPath(this.assetName);
  final String assetName;
}
