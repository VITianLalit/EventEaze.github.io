import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_eaze/views/auth_screen/welcome_screen.dart';
import 'package:event_eaze/views/consts/consts.dart';
import 'package:event_eaze/views/controller/auth_controller.dart';
import 'package:event_eaze/views/controller/profile_controller.dart';
import 'package:event_eaze/views/my_profile/animatedCounterContainer.dart';
import 'package:event_eaze/views/my_profile/changePassword.dart';
import 'package:event_eaze/views/my_profile/edit_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  var controller = Get.put(ProfileController());
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: lightGrey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.greenAccent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: Text(
                "MY PROFILE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  wordSpacing: 2,
                ),
              )),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          actions: [
            IconButton(
              onPressed: () {
                // Add your change password logic here
                Get.to(() => ChangePassword(), transition: Transition.downToUp, duration: Duration(milliseconds: 500));
              },
              icon: Icon(Icons.lock_reset_sharp, size: 45, color: Colors.black, weight: 20,), // You can also use FontAwesomeIcons.key
              tooltip: 'Change Password',),
            SizedBox(width: 10,)
          ],
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.greenAccent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                        padding: EdgeInsets.all(
                            3), // Padding around the container (optional)
                        height: 125,
                        width: 125,
                        decoration: BoxDecoration(
                          color: Colors.white, // Set background color
                          borderRadius: BorderRadius.circular(
                              100), // Make the container circular
                        ),
                        child: FutureBuilder<DocumentSnapshot>(
                            future: firestore.collection(usersCollection).doc(currentUser!.uid).get(),
                            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                              if(!snapshot.hasData){
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
                                  ),
                                );
                              }else{
                                var userData = snapshot.data!.data() as Map<String, dynamic>;
                                return ClipRRect(
                                  // Clip the child to match the container's border radius
                                  borderRadius: BorderRadius.circular(
                                      100), // Not needed here (explained below)
                                  child:userData['imageUrl'] == '' ? Image.asset(
                                    'assets/images/about.jpg', fit: BoxFit.cover,) : Image.network(userData['imageUrl'], fit: BoxFit.cover,), // Use Image.asset for assets
                                );
                              }
                            }
                        ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                            color: Colors.white,
                            width: 2,
                          )),
                          onPressed: () {
                            Get.to(() => EditProfile(), transition: Transition.downToUp, duration: Duration(milliseconds: 500));
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              child: Text(
                                "EDIT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 2),
                              ))),
                      SizedBox(
                        width: 20,
                      ),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                            color: Colors.white,
                            width: 2,
                          )),
                          onPressed: () async{
                            await Get.put(AuthController()).signoutMethod(context);
                            Get.to(() => WelcomeScreen(), transition: Transition.leftToRight, duration: Duration(milliseconds: 500));
                          },
                          child: Text("LOG OUT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 1))),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [Color(0xFFA1DD70), Color(0xFF6B8A7A)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: 'TOTAL\n',
                                  style: TextStyle(
                                    fontSize: 23,
                                    letterSpacing: 1,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(2, 2),
                                        blurRadius: 3,
                                        color: Colors.black45,
                                      ),
                                    ],
                                  ),
                                ),
                                TextSpan(
                                  text: 'EVENTS\n',
                                  style: TextStyle(
                                    fontSize: 19,
                                    letterSpacing: 1,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(2, 2),
                                        blurRadius: 3,
                                        color: Colors.black45,
                                      ),
                                    ],
                                  ),
                                ),
                                TextSpan(
                                  text: 'ATTENDED',
                                  style: TextStyle(
                                    fontSize: 16,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(2, 2),
                                        blurRadius: 3,
                                        color: Colors.black45,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      StreamBuilder<DocumentSnapshot>(
                          stream: firestore.collection(usersCollection).doc(currentUser!.uid).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                            if(!snapshot.hasData){
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
                                ),
                              );
                            }else{
                              var userData = snapshot.data!.data() as Map<String, dynamic>;
                              int count = userData['registeredEvents'];
                              return AnimatedCounterContainer(endValue: count);
                            }
                          }
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    margin: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),

                    child: StreamBuilder<DocumentSnapshot>(
                      stream: firestore.collection(usersCollection).doc(currentUser!.uid).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
                            ),
                          );
                        } else {
                          var userData = snapshot.data!.data() as Map<String, dynamic>;
                          // Accessing individual fields
                          String name = userData['name'] ?? 'No name available';
                          String registerNumber = userData['registerNumber'] ?? 'No register number available';
                          String email = userData['email'] ?? 'No email available';
                          String mobileNumber = userData['mobileNumber'] ?? 'No mobile number available';
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Name',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Registeration no.',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      registerNumber,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'E-mail ID',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      email,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Mobile No.',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      mobileNumber,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
