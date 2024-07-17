import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:event_eaze/views/consts/consts.dart';
import 'package:event_eaze/views/controller/home_controller.dart';
import 'package:event_eaze/views/home_screen/home_screen.dart';
import 'package:event_eaze/views/my_events/my_events.dart';
import 'package:event_eaze/views/my_profile/my_profile.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(HomeController());
  final List<Widget> navBody = [
    const HomeScreen(),
    const MyEvents(),
    const MyProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: animation.drive(Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.fastOutSlowIn))),
              child: child,
            );
          },
          child: navBody[controller.currNavIndex.value],
        );
      }),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: lightGrey,
        color: Colors.greenAccent,
        items: [
          Icon(Icons.home, size: 40,),
          Icon(Icons.app_registration, size: 40,),
          Icon(Icons.person, size: 40,)
        ],
        onTap: (index) {
          controller.currNavIndex.value = index;
        },
      ),
    );
  }
}
