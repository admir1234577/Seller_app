import 'package:flutter/cupertino.dart';
import 'package:seller_app/const/colors.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/views/widgets/text_style.dart';

Widget productImages({required label, onPress}) {
  return "$label".text.bold.color(fontGrey).size(16.0).makeCentered()
      .box.color(lightGrey).size(100, 100).roundedSM.make();
}