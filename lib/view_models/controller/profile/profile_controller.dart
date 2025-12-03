import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();
  final userRoleController = TextEditingController();

  // Reactive image
  final Rx<File?> profileImage = Rx<File?>(null);
  //UserPreference userPreference = UserPreference();

  /// Pick image from gallery or camera
  Future<void> pickImage({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? picked = await picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 80,
    );

    if (picked != null) {
      profileImage.value = File(picked.path);
      //Utils.snackBarBottom('Profile Image', 'Image selected successfully');
    }
  }

  /*Future<void> userDetails() async {
    final user = await userPreference.getUser(UserModel);
    nameController.text = user.name!;
    emailController.text = user.email!;
    phoneController.text = user.contact!;
    userRoleController.text = user.userRole!;
    print('User Role on Profile: ${user.userRole}');
  }*/

}