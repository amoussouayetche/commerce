import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/consts/consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfilController extends GetxController {
  var profileImagePath = ''.obs;
  var profileImageLink = '';
  var islaoding = false.obs;

  //text
  var nameController = TextEditingController();
  var passwordController = TextEditingController();

  changeProfile(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImagePath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var filname = basename(profileImagePath.value);
    var destination = 'images/${currentUser!.uid}/$filname';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imageUrl}) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      'name': name,
      'password': password,
      'imageUrl': imageUrl,
    }, SetOptions(merge: true));
    islaoding(false);
  }
}
