enum ImagesPath {
  homeIcon('lib/shared_ui/assets/images/home_icon.svg'),
  favoriteIcon('lib/shared_ui/assets/images/favorite_icon.svg'),
  searchIcon('lib/shared_ui/assets/images/search_icon.svg'),
  profileIcon('lib/shared_ui/assets/images/profile_icon.svg'),
  primaryLongLogo('lib/shared_ui/assets/images/primary_long_logo.png'),
  primaryShortLogo('lib/shared_ui/assets/images/primary_short_logo.png'),
  trendingIcon('lib/shared_ui/assets/images/trending_icon.svg'),
  bestDramaIcon('lib/shared_ui/assets/images/best_drama_icon.svg'),
  upcomingIcon('lib/shared_ui/assets/images/upcoming_icon.png'),
  tvShowIcon('lib/shared_ui/assets/images/tv_show_icon.svg'),
  noImage(
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPFX24dOkZavnvV7R9supHkmmSEXlCTbKRQamQkrhN&s'),
  login('lib/shared_ui/assets/images/login.png'),
  illustration('lib/shared_ui/assets/images/illustration.png'),
  loginBackground1('lib/shared_ui/assets/images/login-background1.png'),
  loginBackground2('lib/shared_ui/assets/images/login-background2.png'),
  forgotPassword1('lib/shared_ui/assets/images/forgot-password-1.png'),
  forgotPassword2('lib/shared_ui/assets/images/forgot-password-2.png'),
  arrowDownIcon('lib/shared_ui/assets/icons/arrow-down-icon.png'),
  backIcon('lib/shared_ui/assets/icons/back-icon.png'),
  tickIcon('lib/shared_ui/assets/icons/tick-icon.png'),
  eyeCloseIcon('lib/shared_ui/assets/icons/eye-close-icon.png'),
  eyeOpenIcon('lib/shared_ui/assets/icons/eye-open-icon.png');

  const ImagesPath(this.assetName);
  final String assetName;
}
