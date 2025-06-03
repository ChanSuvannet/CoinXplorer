import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;

  const CustomDropdownButton({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(AppStyles.borderRadius),
      ),
      child: DropdownButton<T>(
        value: value,
        underline: const SizedBox(),
        isExpanded: true,
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(
              item.toString(),
              style: const TextStyle(fontSize: AppStyles.fontSizeLabel),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
