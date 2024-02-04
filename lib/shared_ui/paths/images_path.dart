enum ImagesPath {
  homeIcon('lib/shared_ui/assets/icons/home_icon.svg'),
  favoriteIcon('lib/shared_ui/assets/icons/favorite_icon.svg'),
  searchIcon('lib/shared_ui/assets/icons/search_icon.svg'),
  profileIcon('lib/shared_ui/assets/icons/profile_icon.svg'),
  trendingIcon('lib/shared_ui/assets/icons/trending_icon.svg'),
  bestDramaIcon('lib/shared_ui/assets/icons/best_drama_icon.svg'),
  upcomingIcon('lib/shared_ui/assets/icons/upcoming_icon.png'),
  tvShowIcon('lib/shared_ui/assets/icons/tv_show_icon.svg'),
  filterIcon('lib/shared_ui/assets/icons/filter_icon.svg'),
  popularIcon('lib/shared_ui/assets/icons/popular_icon.svg'),
  nowPlayingIcon('lib/shared_ui/assets/icons/now_playing_icon.svg'),
  topRatedIcon('lib/shared_ui/assets/icons/top_rated_icon.svg'),
  bornTodayIcon('lib/shared_ui/assets/icons/born_today_icon.svg'),
  trailerIcon('lib/shared_ui/assets/icons/trailer_icon.svg'),
  watchListIcon('lib/shared_ui/assets/icons/watch_list_icon.svg'),
  artistIcon('lib/shared_ui/assets/icons/artist_icon.svg'),

  eyeOpenIcon('lib/shared_ui/assets/icons/eye_open_icon.png'),
  eyeCloseIcon('lib/shared_ui/assets/icons/eye_close_icon.png'),
  primaryLongLogo('lib/shared_ui/assets/images/primary_long_logo.png'),
  primaryShortLogo('lib/shared_ui/assets/images/primary_short_logo.png'),
  background('lib/shared_ui/assets/images/background.png'),
  noImage('lib/shared_ui/assets/images/no_image.png'),
  noImageMan('lib/shared_ui/assets/images/no_image_man.png'),
  noImageWoman('lib/shared_ui/assets/images/no_image_woman.png'),
  noImageOtherGender('lib/shared_ui/assets/images/no_image_other_gender.png');

  // noAvatar(
  //     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPFX24dOkZavnvV7R9supHkmmSEXlCTbKRQamQkrhN&s');

  const ImagesPath(this.assetName);
  final String assetName;
}
