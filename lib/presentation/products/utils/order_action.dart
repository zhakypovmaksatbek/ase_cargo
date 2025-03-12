import 'dart:ui';

import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:easy_localization/easy_localization.dart';

enum OrderAction {
  add("add"),
  remove("remove"),
  setDone("set_done"),
  setCancelled("set_cancelled");

  final String value;
  const OrderAction(this.value);

  String get icon {
    switch (this) {
      case OrderAction.add:
        return AssetConstants.add.svg;
      case OrderAction.remove:
        return AssetConstants.canceled.svg;
      case OrderAction.setDone:
        return AssetConstants.done.svg;
      case OrderAction.setCancelled:
        return AssetConstants.cancel.svg;
    }
  }

  Color get color {
    switch (this) {
      case OrderAction.add:
        return ColorConstants.darkBlue;
      case OrderAction.remove:
      case OrderAction.setCancelled:
        return ColorConstants.red;
      case OrderAction.setDone:
        return ColorConstants.green;
    }
  }

  String get translatedName {
    switch (this) {
      case OrderAction.add:
        return LocaleKeys.status_add.tr();
      case OrderAction.remove:
        return LocaleKeys.status_remove.tr();
      case OrderAction.setDone:
        return LocaleKeys.status_set_done.tr();
      case OrderAction.setCancelled:
        return LocaleKeys.status_set_cancelled.tr();
    }
  }

  static OrderAction fromString(String value) {
    return OrderAction.values
        .firstWhere((e) => e.value == value, orElse: () => OrderAction.add);
  }
}
