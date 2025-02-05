enum AssetConstants {
  logo,
  splash,
  icon,
  profileImage,
  noImage,
}
extension AssetConstantsExtension on AssetConstants {
  String get png => 'assets/png/$name.png';
  String get svg => 'assets/svg/$name.svg';
}
