import 'package:event_eaze/views/consts/consts.dart';
import 'package:get/get.dart';
import 'login.dart';
import 'signup.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeAnimation(
                    time: Duration(milliseconds: 100),
                    wid: Text(welcome, style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),),
                  ),
                  SizedBox(height: 20,),
                  FadeAnimation(
                    time: Duration(milliseconds: 200),
                    wid: Text(welcomeScreenText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
              FadeAnimation(
                time: Duration(milliseconds: 400),
                wid: Container(
                  height: MediaQuery.of(context).size.height/3,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(welcomeScreenImage)),
                  ),
                ),
              ),
              Column(
                children: [
                  FadeAnimation(
                    time: Duration(milliseconds: 500),
                    wid: MaterialButton(
                      color: Colors.white,
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: (){
                        //Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: LoginPage()));
                        Get.to(() => LoginPage(), transition: Transition.leftToRight, duration: Duration(milliseconds: 500));
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(login, style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),),
                    ),
                  ),
                  SizedBox(height: 20,),
                  FadeAnimation(
                    time: Duration(milliseconds: 600),
                    wid: Container(
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
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: (){
                          //Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: SignUpPage()));
                          Get.to(() => SignUpPage(), transition: Transition.leftToRight, duration: Duration(milliseconds: 500));
                        },
                        color: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(signup, style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
