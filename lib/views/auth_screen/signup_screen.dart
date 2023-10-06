import 'package:commerce/Controllers/auth_controller.dart';
import 'package:commerce/consts/consts.dart';
import 'package:commerce/views/home_screen/home.dart';
import 'package:commerce/widget-common/appLogo_wigdet.dart';
import 'package:commerce/widget-common/bg_widget.dart';
import 'package:commerce/widget-common/custum_textfield.dart';
import 'package:commerce/widget-common/our_bouton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  //Authentification
  var controller = Get.put(AuthController());
  //text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                appLogoWidget(),
                10.heightBox,
                "Join the $appname".text.fontFamily(bold).white.size(13).make(),
                10.heightBox,
                Obx(
                  () => Column(
                    children: [
                      custumTextField(
                          title: name,
                          hint: nameHint,
                          controller: nameController,
                          isPass: false),
                      custumTextField(
                          title: email,
                          hint: emailHint,
                          controller: emailController,
                          isPass: false),
                      custumTextField(
                          title: password,
                          hint: passwordHint,
                          controller: passwordController,
                          isPass: true),
                      custumTextField(
                          title: retypePassword,
                          hint: passwordHint,
                          controller: passwordRetypeController,
                          isPass: true),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {}, child: forgetPass.text.make())),
                      Row(
                        children: [
                          Checkbox(
                            checkColor: redColor,
                            value: isCheck,
                            onChanged: (newValue) {
                              setState(() {
                                isCheck = newValue;
                              });
                            },
                          ),
                          10.widthBox,
                          Expanded(
                            child: RichText(
                                text: const TextSpan(
                              children: [
                                TextSpan(
                                    text: "J'accepte les",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: fontGrey,
                                    )),
                                TextSpan(
                                    text: termsAndCondition,
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: redColor,
                                    )),
                                TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: fontGrey,
                                    )),
                                TextSpan(
                                    text: privacyPolicy,
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: redColor,
                                    )),
                              ],
                            )),
                          )
                        ],
                      ),
                      5.heightBox,
                      controller.islaoding.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : ourButton(
                              color: isCheck == true ? redColor : lightGrey,
                              title: signup,
                              textColor: whiteColor,
                              onPress: () async {
                                if (isCheck != false) {
                                  await controller
                                      .signupMethod(
                                          context: context,
                                          email: emailController.text,
                                          password: passwordController.text)
                                      .then((value) {
                                    return controller.storeUserData(
                                        context: context,
                                        name: nameController.text,
                                        password: passwordController.text,
                                        email: emailController.text);
                                  });
                                } else {}
                                controller.islaoding(true);
                              },
                            ).box.width(context.screenWidth - 50).make(),
                      5.heightBox,
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: aleradyHaveAccount,
                              style:
                                  TextStyle(fontFamily: bold, color: fontGrey),
                            ),
                            TextSpan(
                              text: login,
                              style:
                                  TextStyle(fontFamily: bold, color: redColor),
                            ),
                          ],
                        ),
                      ).onTap(() {
                        Get.back();
                      }),
                      5.heightBox,
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .shadowSm
                      .make(),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
