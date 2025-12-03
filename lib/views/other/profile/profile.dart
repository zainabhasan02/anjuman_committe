import 'package:anjuman_committee/core/theme/static_assets/assets_img.dart';
import 'package:anjuman_committee/widget/custom_styling/m_rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../view_models/controller/profile/profile_controller.dart';
import '../../../core/theme/colours/app_colors.dart';
import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_styling/text_field_decoration.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  final profileController = Get.put(ProfileController());
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  /*@override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<Offset>(
      //begin: Offset(1.0, 0.0),
      begin: Offset.zero,
      end: Offset(1, 0),
      //end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }*/

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.limeStoned, AppColors.softRed],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                width: size.width * 0.7,
                height: size.height * 0.20,
                child: Image.asset(AssetsImg.logo),
              ),
              Container(
                width: double.infinity,
                height: size.height * 0.70,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: profileController.formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          // ---------------- PROFILE IMAGE ----------------
                          Obx(
                            () => Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      profileController.profileImage.value !=
                                              null
                                          ? FileImage(
                                            profileController
                                                .profileImage
                                                .value!,
                                          )
                                          : AssetImage(AssetsImg.userDefaultImg)
                                              as ImageProvider,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 4,
                                  child: InkWell(
                                    onTap: () {
                                      Get.bottomSheet(
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                          child: Wrap(
                                            children: [
                                              ListTile(
                                                leading: const Icon(
                                                  Icons.camera_alt,
                                                ),
                                                title: const Text('Camera'),
                                                onTap: () {
                                                  Get.back();
                                                  profileController.pickImage(
                                                    fromCamera: true,
                                                  );
                                                },
                                              ),
                                              ListTile(
                                                leading: const Icon(
                                                  Icons.photo_library,
                                                ),
                                                title: const Text('Gallery'),
                                                onTap: () {
                                                  Get.back();
                                                  profileController.pickImage(
                                                    fromCamera: false,
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        backgroundColor: Colors.white,
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: AppColors.oliveGreen,
                                      child: const Icon(
                                        Icons.edit_outlined,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),

                          // User Full Name
                          TextFormField(
                            controller: profileController.nameController,
                            textCapitalization: TextCapitalization.words,
                            validator:
                                (value) =>
                                    value!.isEmpty
                                        ? 'Please enter your name'
                                        : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: buildInputDecoration(
                              'Full Name',
                              Icons.person_outline,
                            ),
                          ),
                          SizedBox(height: 15),

                          // User Email
                          TextFormField(
                            controller: profileController.emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              final emailPattern = RegExp(
                                r'^[a-zA-Z0-9._]+@(gmail|yahoo|hotmail|outlook|proftcode)\.(com|in|org|edu|co|co\.in)$',
                                caseSensitive: false,
                              );
                              if (!emailPattern.hasMatch(value.trim())) {
                                return 'Enter valid Email (e.g. test@gmail.com)';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: buildInputDecoration(
                              'Email',
                              Icons.email_outlined,
                            ),
                          ),
                          SizedBox(height: 15),

                          // User Contact
                          TextFormField(
                            controller: profileController.phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your contact number';
                              }
                              if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                return "Please enter a valid 10-digit phone number";
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: buildInputDecoration(
                              'Contact Number',
                              CupertinoIcons.phone,
                            ),
                          ),
                          SizedBox(height: 15),

                          // User Bio
                          TextFormField(
                            controller: profileController.bioController,
                            textCapitalization: TextCapitalization.words,
                            validator:
                                (value) =>
                                    value!.isEmpty
                                        ? 'Please enter about yourself'
                                        : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: buildInputDecoration(
                              'Bio',
                              Icons.face_outlined,
                            ),
                          ),
                          SizedBox(height: 25),

                          // User Role
                          TextFormField(
                            controller: profileController.userRoleController,
                            textCapitalization: TextCapitalization.words,
                            validator:
                                (value) =>
                                    value!.isEmpty
                                        ? 'Please enter user role'
                                        : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: buildInputDecoration(
                              'User Role',
                              FontAwesomeIcons.criticalRole,
                            ),
                          ),
                          SizedBox(height: 25),

                          // Update Button
                          MRoundedButton(
                            btnName: 'Update Profile',
                            width: 200,
                            onPressed: () async {
                              Get.toNamed(RoutesName.myAnimationScreen);

                              /*if (profileController.formKey.currentState!
                                  .validate()) {
                                Utils.snackBarBottom(
                                  'Profile',
                                  'Your Profile Updated Successfully',
                                );
                                Get.toNamed(RoutesName.myAnimationScreen);
                              }
                              return;*/
                            },
                            /*icon: Icon(
                            Icons.update_outlined,
                            color: AppColors.white,
                          ),*/
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
