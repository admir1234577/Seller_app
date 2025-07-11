import 'package:flutter/material.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/views/widgets/text_style.dart';

Widget customTextField({label, hint, controller, isDesc = false}) {
  return TextFormField(
    style: const TextStyle(
      color: white
    ),
    controller: controller,
    maxLines: isDesc ? 4 : 1,
    decoration: InputDecoration(
      isDense: true,
      label: normalText(text: label),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: white
        )
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: white
        )
      ),
      hintText: hint,
        hintStyle: const TextStyle(
        color: lightGrey
    )

    ),
  );
}