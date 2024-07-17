import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_eaze/views/consts/consts.dart';

import '../home_screen/makeItem.dart';

class MyEvents extends StatefulWidget {
  const MyEvents({super.key});

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        backgroundColor: lightGrey,
        automaticallyImplyLeading: false,
        title: Text(
          "My Events",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                // border: Border.all(color: Colors.black, width: 1)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: StreamBuilder<QuerySnapshot>(
                  stream: firestore.collection(eventsCollection).snapshots(),
                  builder: (context, snapshot){
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.greenAccent),));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No events found'));
                    }

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index){
                        var doc = snapshot.data!.docs[index];
                        var eventData = doc.data() as Map<String, dynamic>;
                        List<String> sections = List<String>.from(eventData['registeredEvents'] ?? []);

                        String eventName = eventData['eventName'] ?? 'No name';
                        String time = eventData['time'] ?? 'No time';
                        String dateMonth = eventData['dateMonth'] ?? 'No month';
                        String dateNumber = eventData['dateNumber'] ?? 'No date';
                        var imgPath = eventData['imgUrl'] ?? 'No Image';
                        return sections.contains(currentUser!.uid.toString()) ? Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: makeItem(image: 'assets/images/img.png', eventName: eventName, time: time, dateMonth: dateMonth,dateNumber: dateNumber,imgPath: imgPath, doc: doc),
                        ):Container();
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 22,)
        ],
      ),
    );
  }
}
