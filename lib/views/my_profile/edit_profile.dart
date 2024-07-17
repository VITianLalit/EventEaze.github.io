import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_eaze/views/consts/consts.dart';
import 'package:event_eaze/views/controller/profile_controller.dart';
import 'package:event_eaze/views/my_profile/my_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _dataLoaded = false;
  var controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: (MediaQuery.of(context).size.height) / 2,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90),
                  bottomRight: Radius.circular(90),
                )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 680,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade500,
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: Offset(0, 0)),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: FutureBuilder<DocumentSnapshot>(
                            future: firestore
                                .collection(usersCollection)
                                .doc(currentUser!.uid)
                                .get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              var userData = snapshot.data!.data()
                              as Map<String, dynamic>;
                              return Container(
                                padding: EdgeInsets.all(
                                    3), // Padding around the container (optional)
                                height: 125,
                                width: 125,
                                decoration: BoxDecoration(
                                  color: Colors.white, // Set background color
                                  borderRadius: BorderRadius.circular(
                                      100), // Make the container circular
                                ),
                                child: Obx(
                                    () => ClipRRect(
                                    // Clip the child to match the container's border radius
                                    borderRadius: BorderRadius.circular(
                                        100), // Not needed here (explained below)
                                    child: userData['imageUrl'] == '' && controller.profileImgPath.isEmpty
                                        ? Image.asset(
                                      'assets/images/about.jpg',
                                      fit: BoxFit.cover,
                                    )
                                        : userData['imageUrl'] != '' && controller.profileImgPath.isEmpty ? Image.network(
                                      userData['imageUrl'],
                                      fit: BoxFit.cover,
                                    ): Image.file(File(controller.profileImgPath.value), fit: BoxFit.cover,), // Use Image.asset for assets
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.greenAccent,
                                  width: 2,
                                ),
                                padding: EdgeInsets.zero),
                            onPressed: () {
                              controller.changeImage(context);
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "CHANGE IMAGE",
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: FutureBuilder<DocumentSnapshot>(
                          future: firestore
                              .collection(usersCollection)
                              .doc(currentUser!.uid)
                              .get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      Colors.greenAccent),
                                ),
                              );
                            } else {
                              if (!_dataLoaded) {
                                var userData = snapshot.data!.data()
                                    as Map<String, dynamic>;
                                // Accessing individual fields
                                controller.nameController.text =
                                    userData['name'] ?? 'No name available';
                                controller.registerNumController.text =
                                    userData['registerNumber'] ??
                                        'No register number available';
                                controller.emailIdController.text =
                                    userData['email'] ?? 'No email available';
                                controller.mobileNumController.text =
                                    userData['mobileNumber'] ??
                                        'No mobile number available';
                                _dataLoaded = true;
                              }

                              return Column(
                                children: [
                                  Container(
                                    height: 60,
                                    child: TextField(
                                      controller: controller.nameController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green),
                                        ),
                                        labelText: 'Full Name',
                                        hintText: 'Lalit Sahu',
                                        prefixIcon: Icon(Icons.person),
                                      ),
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    height: 60,
                                    child: TextField(
                                      controller:
                                          controller.registerNumController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green),
                                        ),
                                        labelText: 'Registration No.',
                                        hintText: '21MEI10052',
                                        prefixIcon: Icon(Icons.person),
                                      ),
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    height: 60,
                                    child: TextField(
                                      controller: controller.emailIdController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green),
                                        ),
                                        labelText: 'E-mail',
                                        hintText:
                                            'lalit.sahu2021@vitbhopal.ac.in',
                                        prefixIcon: Icon(Icons.person),
                                      ),
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.black),
                                      enabled: false,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    height: 60,
                                    child: TextField(
                                      controller:
                                          controller.mobileNumController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green),
                                        ),
                                        labelText: 'Mobile No.',
                                        hintText: '+91 9301471365',
                                        prefixIcon: Icon(Icons.person),
                                      ),
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    width: double.infinity,
                                    child: Obx(
                                      () => controller.isLoading.value
                                          ? CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Colors.greenAccent),
                                            )
                                          : MaterialButton(
                                              color: Colors.deepOrange,
                                              height: 40,
                                              onPressed: () async {
                                                controller.isLoading(true);

                                                if (controller.profileImgPath
                                                    .value.isNotEmpty) {
                                                  await controller
                                                      .uploadProfileImage();
                                                }

                                                if (controller.nameController
                                                        .text.isNotEmpty &&
                                                    controller
                                                        .registerNumController
                                                        .text
                                                        .isNotEmpty &&
                                                    controller
                                                        .mobileNumController
                                                        .text
                                                        .isNotEmpty) {
                                                  await controller
                                                      .updateProfile(
                                                    name: controller
                                                        .nameController.text,
                                                    registerNumber: controller
                                                        .registerNumController
                                                        .text,
                                                    mobileNumber: controller
                                                        .mobileNumController
                                                        .text,
                                                    imgUrl: controller
                                                        .profileImageLink,
                                                  );
                                                  Get.snackbar(
                                                      "Note:", "Updated",
                                                      backgroundColor:
                                                          Colors.greenAccent);
                                                  Get.to(MyProfile(),
                                                      transition:
                                                          Transition.upToDown);
                                                } else {
                                                  Get.snackbar("Error:",
                                                      "Please Fill All the Fields");
                                                  controller.isLoading(false);
                                                }
                                              },
                                              child: Text(
                                                'UPDATE',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                    fontSize: 18),
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
