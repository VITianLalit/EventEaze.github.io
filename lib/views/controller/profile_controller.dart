import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:event_eaze/views/consts/consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class ProfileController extends GetxController{

  var profileImgPath = ''.obs;
  var profileImageLink = '';
  var isLoading = false.obs;

  final TextEditingController nameController =  TextEditingController();
  final TextEditingController registerNumController = TextEditingController();
  final TextEditingController emailIdController = TextEditingController();
  final TextEditingController mobileNumController = TextEditingController();

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  changeImage(context) async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
      if(img == null) return;
      profileImgPath.value = img.path;
    } on PlatformException catch(e){
      Get.snackbar(
        'Error: ',
        e.toString(),
        margin: EdgeInsets.all(15),
        borderRadius: 30,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.black,
      );
    }
  }

  uploadProfileImage() async{
    var filename = basename(profileImgPath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  updateProfile({name, registerNumber, mobileNumber, imgUrl}) async{
    var store = firestore.collection(usersCollection).doc(currentUser?.uid);
    await store.set({
      'name': name, 'mobileNumber': mobileNumber, 'imageUrl':imgUrl, 'registerNumber': registerNumber,
    }, SetOptions(merge: true));
    isLoading(false);
  }

  changeAuthPassword({newPassword, email, oldPassword, context}) async {
    AuthCredential cred = EmailAuthProvider.credential(email: email, password: oldPassword);
    try{
      await currentUser!.reauthenticateWithCredential(cred);
      await currentUser!.updatePassword(newPassword);
      await firestore.collection(usersCollection).doc(currentUser?.uid).set({'password': newPassword}, SetOptions(merge: true));
      Get.snackbar("Note: ", "Password Updated Successfully", backgroundColor: Colors.greenAccent, snackPosition: SnackPosition.BOTTOM);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error: ", e.toString(), backgroundColor: Colors.redAccent);
    } catch (e) {
      Get.snackbar("Error: ", "An unknown error occurred.", backgroundColor: Colors.redAccent);
    }
  }
}