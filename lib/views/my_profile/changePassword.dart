import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_eaze/views/consts/consts.dart';
import 'package:event_eaze/views/controller/profile_controller.dart';
import 'package:event_eaze/views/my_profile/forgot_password.dart';
import 'package:event_eaze/views/my_profile/my_profile.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var controller = Get.put(ProfileController());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.oldPasswordController.dispose();
    controller.newPasswordController.dispose();
    controller.confirmPasswordController.dispose();
  }
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
                  height: 625,
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
                              width: 175,
                              height: 175,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Image.asset('assets/images/resetPassword.png')
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              child: TextField(
                                controller: controller.oldPasswordController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  ),
                                  labelText: 'Old Password',
                                  hintText: 'Enter Old Password',
                                  prefixIcon: Icon(Icons.person),
                                ),
                                style: TextStyle(fontSize: 18.0, color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.circular(50)
                                    ),
                                    child: TextButton(onPressed: (){
                                      Get.to(ForgotPassword(), transition: Transition.upToDown);
                                    }, child: Text("Forgot Password", style: TextStyle(color: Colors.black),)))
                              ],
                            ),
                            SizedBox(height: 20,),
                            Container(
                              height: 60,
                              child: TextField(
                                controller: controller.newPasswordController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  ),
                                  labelText: 'New Password',
                                  hintText: 'Enter New Password',
                                  prefixIcon: Icon(Icons.person),
                                ),
                                style: TextStyle(fontSize: 18.0, color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              height: 60,
                              child: TextField(
                                controller: controller.confirmPasswordController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  ),
                                  labelText: 'Confirm Password',
                                  hintText: 'Enter Confirm Password',
                                  prefixIcon: Icon(Icons.person),
                                ),
                                style: TextStyle(fontSize: 18.0, color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 25,),
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
                                  if (controller.oldPasswordController.text != userData['password']) {
                                    Get.snackbar("Error: ", "Old Password is Wrong", backgroundColor: Colors.redAccent);
                                  } else if (controller.newPasswordController.text != controller.confirmPasswordController.text) {
                                    Get.snackbar("Error: ", "Confirm Password is Wrong");
                                  } else {
                                    await controller.changeAuthPassword(newPassword: controller.newPasswordController.text, email: userData['email'], oldPassword: controller.oldPasswordController.text,context: context);
                                    Get.to(() => MyProfile(), transition: Transition.upToDown);
                                  }
                                },

                                child: Text('CHANGE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 18),),
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
