import 'package:ase/generated/locale_keys.g.dart';

enum ShipmentOption {
  sender(title: LocaleKeys.general_by_sender),
  recipient(title: LocaleKeys.general_by_recipient);

  const ShipmentOption({required this.title});
  final String title;

  static ShipmentOption fromString(String value) {
    return ShipmentOption.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ShipmentOption.sender,
    );
  }
}

enum DeliveryType {
  parcel(LocaleKeys.form_package),
  docs(LocaleKeys.general_document);

  const DeliveryType(this.title);
  final String title;
}

enum FormSteps { first, second, third, fourth, fifth, finish }

enum Payer {
  sender(LocaleKeys.form_sender_pay),
  recipient(LocaleKeys.form_recipient_pay);

  const Payer(this.title);
  final String title;
}

enum PersonType {
  physical(title: LocaleKeys.form_physical, key: "individual"),
  legal(title: LocaleKeys.form_legal, key: "legal_entity");

  final String title;
  final String key;

  const PersonType({required this.title, required this.key});
}
