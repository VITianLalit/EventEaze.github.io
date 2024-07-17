import 'package:event_eaze/views/auth_screen/login.dart';
import 'package:event_eaze/views/consts/consts.dart';
import 'package:event_eaze/views/controller/auth_controller.dart';
import 'package:get/get.dart';

import '../home_screen/home.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    //text Controllers
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var registerNumberController = TextEditingController();
    var mobileNumberController = TextEditingController();
    var confirmPasswordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: lightGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(signup, style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 20,),
                        Text(signUpPageText, style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700]
                        ),)
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          makeInput(label: "Full Name", controller: nameController),
                          makeInput(label: "Register No.", controller: registerNumberController),
                          makeInput(label: "Mobile No.", controller: mobileNumberController),
                          makeInput(label: email, controller: emailController),
                          makeInput(label: password, obsecureText: true, controller: passwordController),
                          makeInput(label: confirmPassword, obsecureText: true, controller: confirmPasswordController),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Obx(
                          () => Container(
                          padding: EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border(
                                  bottom: BorderSide(color: Colors.black),
                                  top: BorderSide(color: Colors.black),
                                  left: BorderSide(color: Colors.black),
                                  right: BorderSide(color: Colors.black)
                              )
                          ),
                          child: controller.isLoading.value? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.greenAccent),) : MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () async{
                              if(passwordController.text != confirmPasswordController.text){
                                Get.snackbar("Note: ", "Confirm Password is not Matching to your original Password", backgroundColor: Colors.redAccent);
                              }
                              else{
                                controller.isLoading(true);
                                try{
                                  await controller.signupMethod(context: context, email: emailController.text, password: passwordController.text).then((value){
                                    return controller.storeUserData(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        registerNumber: registerNumberController.text,
                                        mobileNumber: mobileNumberController.text
                                    );
                                  }).then((value){
                                    Get.snackbar("Note: ", "Signed Up Successfully", backgroundColor: Colors.greenAccent);
                                    Get.offAll(() => Home(), transition: Transition.downToUp, duration: Duration(milliseconds: 500));
                                  });
                                }catch(e){
                                  auth.signOut();
                                  Get.snackbar("Error: ", e.toString(), backgroundColor: Colors.redAccent);
                                  controller.isLoading(false);
                                }
                              }
                            },
                            color: Colors.greenAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(signup, style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(alreadyHaveAnAccount),
                        TextButton(
                            onPressed: () {
                              //Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: LoginPage()));
                              Get.off(() => LoginPage(), transition: Transition.leftToRight, duration: Duration(milliseconds: 500));

                            },
                            child: Text(
                              login,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: 5,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, obsecureText = false, controller}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),),
        SizedBox(height: 5,),
        TextField(
          controller: controller,
          obscureText: obsecureText,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54)
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400)
              )
          ),
        ),
        SizedBox(height: 15,),
      ],
    );
  }
}