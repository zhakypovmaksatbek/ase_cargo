import 'package:ase/generated/locale_keys.g.dart';

enum OrderStatus {
  inProcess('in_process', LocaleKeys.status_in_process),
  // inTransit('in_transit',),
  awaitingPickup('awaiting_pickup', LocaleKeys.status_awaiting_pickup),
  rejected('rejected', LocaleKeys.status_rejected),
  enRoute('en_route', LocaleKeys.status_en_route),
  pendingDelivery('pending_delivery', LocaleKeys.status_en_route),
  done('done', LocaleKeys.status_done);

  final String value;
  final String name;
  const OrderStatus(this.value, this.name);

  static OrderStatus fromString(String status) {
    return OrderStatus.values.firstWhere(
      (e) => e.value == status,
      orElse: () => OrderStatus.inProcess,
    );
  }
}
