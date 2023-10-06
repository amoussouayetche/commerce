import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/Controllers/auth_controller.dart';
import 'package:commerce/Controllers/profil__controller.dart';
import 'package:commerce/consts/consts.dart';
import 'package:commerce/consts/list.dart';
import 'package:commerce/services/firestore_services.dart';
import 'package:commerce/views/auth_screen/login_screen.dart';
import 'package:commerce/views/profile_screen/component/detail_card.dart';
import 'package:commerce/views/profile_screen/edit_profil_scree.dart';
import 'package:commerce/widget-common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controler = Get.put(ProfilController());
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              //var data = snapshot.data!.docs[0];
              return SafeArea(
                  child: Column(
                children: [
                  //edit profile button
                  const Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.edit,
                        color: whiteColor,
                      )).onTap(() {
                    //controler.nameController.text = data['name'];
                    //controler.passwordController.text = data['password'];

                    Get.to(const EditProfilScreen(
                        //data: data,
                        ));
                  }),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          imgProfile2,
                          width: 80,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
                        5.widthBox,
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "name".text.fontFamily(semibold).white.make(),
                            5.heightBox,
                            "email".text.white.make(),
                          ],
                        )),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                              color: whiteColor,
                            )),
                            onPressed: () async {
                              await Get.put(AuthController())
                                  .signoutMethod(context);
                              Get.offAll(() => const LoginScreen());
                            },
                            child:
                                "logout".text.fontFamily(semibold).white.make())
                      ],
                    ),
                  ),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      detailsCard(
                          width: context.screenWidth / 3.4,
                          count: 'cart_count',
                          title: "in your cart"),
                      detailsCard(
                          width: context.screenWidth / 3.4,
                          count: 'whishlist_count',
                          title: "in your wishlist"),
                      detailsCard(
                          width: context.screenWidth / 3.4,
                          count: 'order_count',
                          title: "your orders"),
                    ],
                  ),

                  ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: lightGrey,
                            );
                          },
                          itemCount: profilButonList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Image.asset(
                                profilButonIcon[index],
                                width: 22,
                              ),
                              title: profilButonList[index]
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                            );
                          })
                      .box
                      .white
                      .shadowSm
                      .rounded
                      .margin(const EdgeInsets.all(12))
                      .padding(const EdgeInsets.symmetric(horizontal: 16))
                      .make()
                      .box
                      .color(redColor)
                      .make(),
                ],
              ));
            }
          },
        ),
      ),
    );
  }
}
