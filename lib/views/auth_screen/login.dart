import 'package:event_eaze/views/auth_screen/signup.dart';
import 'package:event_eaze/views/consts/consts.dart';
import 'package:event_eaze/views/controller/auth_controller.dart';
import 'package:event_eaze/views/home_screen/home.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: lightGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: lightGrey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      FadeAnimation(
                        time: Duration(milliseconds: 100),
                        wid: Text(
                          login,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                        time: Duration(milliseconds: 200),
                        wid: Text(
                          logintext,
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        FadeAnimation(
                            time: Duration(milliseconds: 300),
                            wid: makeInput(
                                label: email,
                                controller: controller.emailController)),
                        makeInput(
                            label: password,
                            obsecureText: true,
                            controller: controller.passwordController),
                      ],
                    ),
                  ),
                  Obx(
                      () => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: FadeAnimation(
                        time: Duration(milliseconds: 400),
                        wid: Container(
                          padding: EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border(
                                  bottom: BorderSide(color: Colors.black),
                                  top: BorderSide(color: Colors.black),
                                  left: BorderSide(color: Colors.black),
                                  right: BorderSide(color: Colors.black))),
                          child: controller.isLoading.value
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.greenAccent),
                                )
                              : MaterialButton(
                                  minWidth: double.infinity,
                                  height: 60,
                                  onPressed: () async{
                                    controller.isLoading(true);
                                    await controller.loginMothod(context: context).then((value){
                                      if(value != null){
                                        Get.snackbar("Note: ", "Logged In Successfully", backgroundColor: Colors.greenAccent);
                                        Get.offAll(() => Home(), transition: Transition.downToUp, duration: Duration(milliseconds: 500));
                                      }else{
                                        controller.isLoading(false);
                                      }
                                    });
                                  },
                                  color: Colors.greenAccent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    login,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  FadeAnimation(
                    time: Duration(milliseconds: 500),
                    wid: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(doNotHaveAccount),
                        TextButton(
                            onPressed: () {
                              Get.off(() => SignUpPage(),
                                  transition: Transition.leftToRight,
                                  duration: Duration(milliseconds: 500));
                            },
                            child: Text(
                              signup,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            FadeAnimation(
              time: Duration(milliseconds: 700),
              wid: Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(loginPageImage),
                  fit: BoxFit.cover,
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget makeInput({label, obsecureText = false, controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: controller,
          obscureText: obsecureText,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54)),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400))),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
