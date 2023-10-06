import 'package:commerce/Controllers/auth_controller.dart';
import 'package:commerce/consts/consts.dart';
import 'package:commerce/consts/list.dart';
import 'package:commerce/views/auth_screen/signup_screen.dart';
import 'package:commerce/views/home_screen/home.dart';
import 'package:commerce/widget-common/appLogo_wigdet.dart';
import 'package:commerce/widget-common/bg_widget.dart';
import 'package:commerce/widget-common/custum_textfield.dart';
import 'package:commerce/widget-common/our_bouton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                appLogoWidget(),
                10.heightBox,
                "Log in to $appname"
                    .text
                    .fontFamily(bold)
                    .white
                    .size(13)
                    .make(),
                10.heightBox,
                Obx(
                  () => Column(
                    children: [
                      custumTextField(
                          title: email,
                          hint: emailHint,
                          isPass: false,
                          controller: controller.emailController),
                      custumTextField(
                          title: password,
                          hint: passwordHint,
                          isPass: true,
                          controller: controller.passwordController),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {}, child: forgetPass.text.make())),
                      5.heightBox,
                      controller.islaoding.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : ourButton(
                              color: redColor,
                              title: login,
                              textColor: whiteColor,
                              onPress: () async {
                                controller.islaoding(true);
                                await controller
                                    .loginMethod(context: context)
                                    .then((value) {
                                  if (value != null) {
                                    VxToast.show(context, msg: loggedin);
                                    Get.offAll(() => const Home());
                                  } else {
                                    controller.islaoding(false);
                                  }
                                });
                              }).box.width(context.screenWidth - 50).make(),
                      5.heightBox,
                      createNewAccount.text.color(fontGrey).make(),
                      5.heightBox,
                      ourButton(
                          color: lightGolden,
                          title: signup,
                          textColor: redColor,
                          onPress: () {
                            Get.to(() => const SignupScreen());
                          }).box.width(context.screenWidth - 50).make(),
                      5.heightBox,
                      logInWhith.text.color(fontGrey).make(),
                      5.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CircleAvatar(
                                    backgroundColor: lightGrey,
                                    radius: 25,
                                    child: Image.asset(
                                      socialIconList[index],
                                      width: 30,
                                    ),
                                  ),
                                )),
                      )
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
