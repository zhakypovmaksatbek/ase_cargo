import 'package:ase/presentation/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AppBottomSheet {
  Future<T?> filterBottomSheet<T>({
    required BuildContext context,
    required List<T> values,
    required T? selectedValue,
    required String Function(T value) titleBuilder,
  }) {
    return showBarModalBottomSheet<T>(
      context: context,
      bounce: true,
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(14),
      ),
      barrierColor: ColorConstants.black.withValues(alpha: .4),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 20.0)),
            ...values.map(
              (value) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: RadioListTile<T>(
                  value: value,
                  contentPadding: EdgeInsets.zero,
                  groupValue: selectedValue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: value == selectedValue
                        ? BorderSide(color: ColorConstants.primary)
                        : BorderSide.none,
                  ),
                  title: Text(titleBuilder(value)),
                  onChanged: (newValue) {
                    Navigator.pop(context, newValue);
                  },
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(30.0)),
          ],
        );
      },
    );
  }
}
