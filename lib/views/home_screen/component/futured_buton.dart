import 'package:commerce/consts/consts.dart';
import 'package:flutter/material.dart';

Widget futuredButon({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.size(12).fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(200)
      .white
      .padding(const EdgeInsets.all(8))
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .roundedSM
      .outerShadowSm
      .make();
}
