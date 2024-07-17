import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_eaze/views/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  var isLoading = false.obs;

  // text Controllers for loginScreen
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //signup method
  Future<UserCredential?> signupMethod({email, password, context}) async{
    UserCredential? userCredential;
    try{
      userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
      Get.snackbar("Error: ", e.toString(), backgroundColor: Colors.redAccent);
    }
    return userCredential;
  }

  //login method
  Future<UserCredential?> loginMothod({context}) async{
    UserCredential? userCredential;
    try{
      userCredential = await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch(e){
      Get.snackbar("Error: ", e.toString(), backgroundColor: Colors.redAccent);
    }
    return userCredential;
  }

  storeUserData({name, password, email, registerNumber, mobileNumber}) async{
    DocumentReference store = await firestore.collection(usersCollection).doc(currentUser?.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'mobileNumber': mobileNumber,
      'imageUrl': '',
      'registerNumber': registerNumber
    });
  }

  signoutMethod(context) async{
    try{
      await auth.signOut();
    } catch(e){
      Get.snackbar("Error: ", e.toString(), backgroundColor: Colors.redAccent);
    }
  }
}