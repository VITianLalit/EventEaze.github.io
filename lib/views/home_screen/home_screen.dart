import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_eaze/views/consts/consts.dart';
import 'package:event_eaze/views/controller/home_controller.dart';
import 'package:event_eaze/views/home_screen/makeItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: currentUser != null ? FutureBuilder<DocumentSnapshot>(
                  future: firestore.collection(usersCollection).doc(currentUser!.uid).get(),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
                        ),
                      );
                    } else {
                      var userData = snapshot.data!.data() as Map<String, dynamic>;
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: userData['imageUrl'] == ''
                            ? Image.asset(
                          'assets/images/about.jpg',
                          fit: BoxFit.cover,
                        )
                            : Image.network(
                          userData['imageUrl'],
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                  }) : Icon(Icons.person),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 25),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: TextField(
                  onChanged: (value) {
                    homeController.searchQuery.value = value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.green,
                    ),
                    hintText: "Search Event",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Obx(() {
                      return StreamBuilder<QuerySnapshot>(
                        stream: homeController.eventsStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
                              ),
                            );
                          }

                          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return Center(child: Text('No events found'));
                          }

                          return ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data!.size,
                            itemBuilder: (context, index) {
                              var doc = snapshot.data!.docs[index];
                              var eventData = doc.data() as Map<String, dynamic>;

                              String eventName = eventData['eventName'] ?? 'No name';
                              String time = eventData['time'] ?? 'No time';
                              String dateMonth = eventData['dateMonth'] ?? 'No month';
                              String dateNumber = eventData['dateNumber'] ?? 'No date';
                              var imgPath = eventData['imgUrl'] ?? 'No Image';
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: makeItem(
                                  image: 'assets/images/img.png',
                                  eventName: eventName,
                                  time: time,
                                  dateMonth: dateMonth,
                                  dateNumber: dateNumber,
                                  imgPath: imgPath,
                                  doc: doc,
                                ),
                              );
                            },
                          );
                        },
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
