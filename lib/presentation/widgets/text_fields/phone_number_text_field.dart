import 'package:ase/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberTextField extends StatelessWidget {
  const PhoneNumberTextField({
    super.key,
    required this.focusNode,
    this.errorText,
    this.onChanged,
  });

  final FocusNode focusNode;
  final String? errorText;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      focusNode: focusNode,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      showDropdownIcon: false,
      dropdownTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      invalidNumberMessage: LocaleKeys.exception_invalid_phone_number.tr(),
      pickerDialogStyle: PickerDialogStyle(
        searchFieldInputDecoration: InputDecoration(
          hintText: LocaleKeys.button_search.tr(),
        ),
      ),
      decoration: InputDecoration(
        hintText: '(xxx) xxx-xxx',
        errorText: errorText,
      ),
      showCountryFlag: false,
      languageCode: "ky",
      initialCountryCode: "KG",
      textInputAction: TextInputAction.next,
      onChanged: (phone) {
        onChanged?.call(phone.completeNumber);
        debugPrint(phone.completeNumber);
      },
      onCountryChanged: (country) {
        debugPrint('Country changed to: ${country.name}');
      },
    );
  }
}
