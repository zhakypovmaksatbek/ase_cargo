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
  add
}

extension AssetConstantsExtension on AssetConstants {
  String get png => 'assets/png/$name.png';
  String get svg => 'assets/svg/$name.svg';
}
