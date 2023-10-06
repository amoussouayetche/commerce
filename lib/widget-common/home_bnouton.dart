import 'package:commerce/consts/consts.dart';
import 'package:flutter/material.dart';

Widget homeButon({width, height, icon, String? title, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      10.heightBox,
      title!.text
          .fontFamily(semibold)
          .align(TextAlign.center)
          .color(darkFontGrey)
          .make()
    ],
  ).box.rounded.white.size(width, height).shadowSm.make();
}
