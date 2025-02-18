enum AssetConstants {
  logo,
  splash,
  icon,
  profileImage,
  noImage,
  notification,
  date,
  ratingStar,
  home,
  search,
  support,
  profile,
  add,
  request,
  history,
  myReview,
  language,
  userInfo,
  location,
  waiting,
  canceled,
  cash,
  error
}

extension AssetConstantsExtension on AssetConstants {
  String get png => 'assets/png/$name.png';
  String get svg => 'assets/svg/$name.svg';
}
