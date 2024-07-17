import 'package:event_eaze/views/auth_screen/welcome_screen.dart';
import 'package:event_eaze/views/consts/consts.dart';
import 'package:get/get.dart';

import '../home_screen/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    if(currentUser != null){
      Future.delayed(Duration(seconds: 3), () {
        Get.to(() => Home(), transition: Transition.downToUp, duration: Duration(milliseconds: 500));
      });
    }else{
      Future.delayed(Duration(seconds: 3), () {
        Get.to(() => WelcomeScreen(), transition: Transition.upToDown, duration: Duration(milliseconds: 500));
      });
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2EA79),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeAnimation(
              time: Duration(seconds: 2),
              wid: Center(
                child: Container(
                  height: 300,
                    width: 300,
                    child: Image.asset(splashScreenImage)),
              ))
        ],
      ),
    );
  }
}
