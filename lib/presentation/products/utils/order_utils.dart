import 'dart:ui';

import 'package:ase/data/models/request_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:easy_localization/easy_localization.dart';

final class OrderUtils {
  static String preOrderStatus(String status) {
    switch (status) {
      case "awaiting_process":
        return LocaleKeys.status_awaiting_process.tr();
      case "wait_payment":
        return LocaleKeys.status_wait_payment.tr();
      case "accepted":
        return LocaleKeys.status_accepted.tr();
      case "canceled":
        return LocaleKeys.status_canceled.tr();
      case "denied":
        return LocaleKeys.status_denied.tr();
      default:
        return status;
    }
  }

  static String courierOrderStatus(String status) {
    switch (status) {
      case "awaiting_process":
        return LocaleKeys.status_awaiting_process.tr();
      case "wait_payment":
        return LocaleKeys.status_wait_payment.tr();
      case "accepted":
        return LocaleKeys.status_accepted.tr();
      case "canceled":
        return LocaleKeys.status_canceled.tr();
      case "denied":
        return LocaleKeys.status_denied.tr();
      default:
        return status;
    }
  }

  static String preOrderStatusIcon(String status) {
    switch (status) {
      case "awaiting_process":
        return AssetConstants.waiting.svg;
      case "wait_payment":
        return AssetConstants.cash.svg;
      case "accepted":
        return AssetConstants.done.svg;
      case "canceled":
        return AssetConstants.cancel.svg;
      case "denied":
        return AssetConstants.cancel.svg;
      default:
        return AssetConstants.process.svg;
    }
  }

  static Color preOrderStatusColor(String status) {
    switch (status) {
      case "awaiting_process":
        return ColorConstants.orange;
      case "wait_payment":
        return ColorConstants.blue;
      case "accepted":
        return ColorConstants.green;
      case "canceled":
        return ColorConstants.red;
      case "denied":
        return ColorConstants.red;
      default:
        return ColorConstants.darkBlue;
    }
  }

  static Color orderStatusColor(String status) {
    switch (status) {
      case "in_process":
        return ColorConstants.orange;
      case "awaiting_pickup":
        return ColorConstants.orange;
      case "in_transit":
        return ColorConstants.blue;
      case "done":
        return ColorConstants.green;
      case "rejected":
        return ColorConstants.red;
      case "denied":
        return ColorConstants.red;
      default:
        return ColorConstants.darkBlue;
    }
  }

  static String orderStatusIcon(String status) {
    switch (status) {
      case "in_process":
        return AssetConstants.process.svg;
      case "awaiting_pickup":
        return AssetConstants.waiting.svg;
      case "done":
        return AssetConstants.done.svg;
      case "rejected":
        return AssetConstants.cancel.svg;
      case "denied":
        return AssetConstants.cancel.svg;
      default:
        return AssetConstants.process.svg;
    }
  }

  static String orderStatus(String status) {
    switch (status) {
      case "draft":
        return LocaleKeys.status_draft.tr();
      case "in_process":
        return LocaleKeys.status_in_process.tr();
      case "in_transit":
        return LocaleKeys.status_in_transit.tr();
      case "awaiting_pickup":
        return LocaleKeys.status_awaiting_pickup.tr();
      case "rejected":
        return LocaleKeys.status_rejected.tr();

      case "done":
        return LocaleKeys.status_done.tr();
      default:
        return status;
    }
  }

  static String formatAddress(Address address) {
    List<String> parts = [];

    if (address.addressLine?.isNotEmpty == true) {
      parts.add(address.addressLine!);
    }
    if (address.region?.isNotEmpty == true) {
      parts.add(address.region!);
    }
    if (address.city?.isNotEmpty == true) {
      parts.add(address.city!);
    }
    if (address.zipcode?.isNotEmpty == true) {
      parts.add(address.zipcode!);
    }
    if (address.country?.isNotEmpty == true) {
      parts.add(address.country!);
    }

    return parts.isNotEmpty
        ? parts.join(", ")
        : LocaleKeys.notification_not_found_address.tr();
  }
}
