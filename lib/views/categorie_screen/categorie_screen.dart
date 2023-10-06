import 'package:commerce/consts/consts.dart';
import 'package:commerce/consts/list.dart';
import 'package:commerce/views/categorie_screen/categorie_details.dart';
import 'package:commerce/widget-common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorieScreen extends StatelessWidget {
  const CategorieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: categories.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 200),
              itemBuilder: ((context, index) {
                return Column(
                  children: [
                    Image.asset(
                      categorieImage[index],
                      height: 120,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    10.heightBox,
                    categorieList[index]
                        .text
                        .align(TextAlign.center)
                        .color(darkFontGrey)
                        .make(),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .clip(Clip.antiAlias)
                    .outerShadowSm
                    .make()
                    .onTap(() {
                  Get.to(() => CategorieDetails(title: categorieList[index]));
                });
              })),
        ),
      ),
    );
  }
}
