import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_eaze/views/consts/consts.dart';
import 'package:event_eaze/views/my_profile/my_profile.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
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
                  height: 500,
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
                        height: 30,
                      ),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height/5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: SvgPicture.asset(
                              'assets/images/undraw_forgot_password_re_hxwm.svg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  ),
                                  labelText: 'Email ID',
                                  hintText: 'Enter Your Email',
                                  prefixIcon: Icon(Icons.person),
                                ),
                                style: TextStyle(fontSize: 18.0, color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 30,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              width: double.infinity,
                              child: MaterialButton(
                                color: Colors.deepOrange,
                                height: 40,
                                onPressed: () async {
                                  // Fetch user data from Firestore
                                  DocumentSnapshot snapshot = await firestore.collection(usersCollection).doc(currentUser?.uid).get();
                                  if (!snapshot.exists) {
                                    Get.snackbar("Error: ", "User data not found", backgroundColor: Colors.redAccent);
                                    return;
                                  }
                                  var userData = snapshot.data() as Map<String, dynamic>;
                                  if(emailController.text != userData['email']){
                                    Get.snackbar("Error: ", "Email ID is wrong", backgroundColor: Colors.redAccent);
                                  }else{
                                    auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
                                      Get.snackbar("Note: ", "We have sent you mail to recover Password", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.greenAccent);
                                      Get.to(MyProfile(), transition: Transition.upToDown);
                                    }).onError((error, stackTrace){
                                      Get.snackbar("Error: ", error.toString(), backgroundColor: Colors.red);
                                    });
                                  }
                                },
                                child: Text('SEND EMAIL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 18),),
                              ),
                            )
                          ],
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
