enum ImagesPath {
  homeUnselectedIcon('lib/shared_ui/assets/images/home_unselected_icon.png'),
  discoveryUnselectedIcon('lib/shared_ui/assets/images/discovery_unselected_icon.png'),
  profileUnselectedIcon('lib/shared_ui/assets/images/profile_unselected_icon.png'),
  homeSelectedIcon('lib/shared_ui/assets/images/home_selected_icon.png'),
  discoverySelectedIcon('lib/shared_ui/assets/images/discovery_selected_icon.png'),
  profileSelectedIcon('lib/shared_ui/assets/images/profile_selected_icon.png'),
  ;

  const ImagesPath(this.assetName);
  final String assetName;
}
