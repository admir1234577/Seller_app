import 'package:seller_app/const/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:seller_app/views/widgets/text_style.dart';

Widget orderPlaceDetails({title1, title2, d1, d2}) {

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            boldText(text: "$title1", color: purpleColor),
            boldText(text: "$d1", color: red),
            // "$title1".text.fontFamily(semibold).make(),
           // "$d1".text.color(redColor).fontFamily(semibold).make()
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText(text: "$title2", color: purpleColor),
              boldText(text: "$d2", color: fontGrey),
            ],

          ),
        )
      ],
    ),
  );
}