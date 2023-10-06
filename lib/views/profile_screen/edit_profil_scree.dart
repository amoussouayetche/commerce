import 'dart:io';

import 'package:commerce/Controllers/profil__controller.dart';
import 'package:commerce/consts/consts.dart';
import 'package:commerce/widget-common/bg_widget.dart';
import 'package:commerce/widget-common/custum_textfield.dart';
import 'package:commerce/widget-common/our_bouton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfilScreen extends StatelessWidget {
  final dynamic data;

  const EditProfilScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfilController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //si urlimages et controllerpath nest vide
              data['imageUrl'] == '' && controller.profileImagePath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 80,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  //si imageurl n'est pas vide mais controller path si
                  : data['imageUrl'] != '' &&
                          controller.profileImagePath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImagePath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourButton(
                color: redColor,
                onPress: () {
                  controller.changeProfile(context);
                },
                textColor: whiteColor,
                title: "change",
              ),
              const Divider(),
              20.heightBox,
              custumTextField(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false,
              ),
              custumTextField(
                controller: controller.passwordController,
                hint: password,
                title: password,
                isPass: true,
              ),
              20.heightBox,
              controller.islaoding.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenHeight - 60,
                      child: ourButton(
                        color: redColor,
                        onPress: () async {
                          controller.islaoding(true);
                          await controller.uploadProfileImage();
                          await controller.updateProfile(
                              imageUrl: controller.profileImageLink,
                              name: controller.nameController.text,
                              password: controller.passwordController.text);
                          VxToast.show(context, msg: "Succes");
                        },
                        textColor: whiteColor,
                        title: "Save",
                      ),
                    ),
            ],
          )
              .box
              .white
              .shadowSm
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .rounded
              .make(),
        ),
      ),
    ));
  }
}
