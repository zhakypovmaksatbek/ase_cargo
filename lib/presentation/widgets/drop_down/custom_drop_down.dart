// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomDropDown<T extends Object> extends StatefulWidget {
  const CustomDropDown({
    super.key,
    required this.items,
    required this.validatorTitle,
    required this.itemBuilder,
    this.hint,
    this.onChanged,
    this.errorMessage,
  });

  final List<T> items;
  final String validatorTitle;
  final String Function(T) itemBuilder;
  final String? hint;
  final ValueChanged<T?>? onChanged;
  final String? errorMessage;

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T extends Object> extends State<CustomDropDown<T>> {
  T? _selectedValue;
  String? _errorText;
  @override
  Widget build(BuildContext context) {
    _errorText = widget.errorMessage;
    return FormField<T>(
      validator: (value) =>
          _selectedValue == null ? widget.validatorTitle : null,
      builder: (FormFieldState<T> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2<T>(
                isExpanded: true,
                hint: Text(widget.hint ?? LocaleKeys.button_search.tr()),
                value: _selectedValue,
                items: widget.items
                    .map((item) => DropdownMenuItem<T>(
                          value: item,
                          child: Text(widget.itemBuilder(item)),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                    _errorText = null;
                    state.didChange(value);
                  });
                  widget.onChanged?.call(value);
                },
                buttonStyleData: ButtonStyleData(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstants.dividerColor,
                    border: _errorText != null
                        ? Border.all(color: Theme.of(context).colorScheme.error)
                        : null,
                  ),
                  height: 50,
                ),
                selectedItemBuilder: (BuildContext context) {
                  return widget.items
                      .map((item) => Align(
                            alignment: Alignment.centerLeft,
                            child: Text(widget.itemBuilder(item)),
                          ))
                      .toList();
                },
              ),
            ),
            if (_errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _errorText!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
