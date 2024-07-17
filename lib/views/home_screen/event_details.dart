import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_eaze/views/consts/consts.dart';
import 'package:event_eaze/views/controller/home_controller.dart';
import 'package:event_eaze/views/home_screen/roundsTimeLine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class EventDetails extends StatefulWidget {
  final QueryDocumentSnapshot docId;
  const EventDetails({super.key, required this.docId});
  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context){
    var eventData = widget.docId.data() as Map<String, dynamic>;
    final controller = Get.put(HomeController());
    List<String> sections = List<String>.from(eventData['registeredEvents'] ?? []);
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 450,
                  backgroundColor: Colors.black,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(eventData['imgUrl']),
                              fit: BoxFit.cover)),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                colors: [
                              Colors.black,
                              Colors.black.withOpacity(.3),
                            ])),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                eventData['eventName'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 8),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      eventData['clubName'],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 8),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      eventData['mode'],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 8),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      eventData['venue'],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: lightGrey,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 3,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  'Rounds & Timeline',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 3,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: StreamBuilder<QuerySnapshot>(
                                stream: widget.docId.reference.collection("Rounds&Timeline").snapshots(),
                                builder: (context, snapshot){
                                  if (snapshot.hasError) {
                                    return Center(child: Text('Error: ${snapshot.error}'));
                                  }

                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.greenAccent),));
                                  }

                                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                    return Center(child: Text('No Rounds found'));
                                  }
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data!.size,
                                    itemBuilder: (context, index) {
                                      var doc = snapshot.data!.docs[index];
                                      var roundTimelineData = doc.data() as Map<String, dynamic>;
                                      return RoundsTimeLine(
                                          roundName: roundTimelineData['roundName'] ?? "Unknown",
                                          description:
                                         roundTimelineData['description'] ?? "No Description",
                                          startDate: roundTimelineData['startDate'] ?? "Not Mentioned",
                                          endDate: roundTimelineData['endDate']?? "Not Mentioned"
                                      );
                                    },
                                  );
                                }
                            )
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 3,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  'Details & Eligibility Criteria',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 3,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                         StreamBuilder<QuerySnapshot>(
                             stream: widget.docId.reference.collection("Details&EligibilityCriteria").snapshots(),
                             builder: (context, snapshot){
                               if (snapshot.hasError) {
                                 return Center(child: Text('Error: ${snapshot.error}'));
                               }

                               if (snapshot.connectionState == ConnectionState.waiting) {
                                 return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.greenAccent),));
                               }

                               if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                 return Center(child: Text('No Rounds found'));
                               }
                               return ListView.builder(
                                 shrinkWrap: true,
                                 physics: NeverScrollableScrollPhysics(),
                                 itemCount: snapshot.data!.size,
                                 itemBuilder: (context, index){
                                   var doc = snapshot.data!.docs[index];
                                   var detailsAndEligibitlityCriteriaData = doc.data() as Map<String, dynamic>;
                                   return Container(
                                     padding: EdgeInsets.all(16),
                                     decoration: BoxDecoration(
                                       color: Colors.white,
                                       borderRadius: BorderRadius.circular(8),
                                       boxShadow: [
                                         BoxShadow(
                                           color: Colors.grey.withOpacity(0.3),
                                           spreadRadius: 2,
                                           blurRadius: 5,
                                           offset: Offset(0, 3),
                                         ),
                                       ],
                                     ),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(
                                           detailsAndEligibitlityCriteriaData['title']?? "No title",
                                           style: TextStyle(
                                             fontSize: 18,
                                             fontWeight: FontWeight.bold,
                                           ),
                                         ),
                                         SizedBox(height: 8),
                                         Text(
                                           detailsAndEligibitlityCriteriaData['description'] ?? "No Description",
                                           style: TextStyle(
                                             fontSize: 14,
                                             color: Colors.grey[600],
                                           ),
                                         ),
                                         SizedBox(
                                           height: 10,
                                         ),
                                         Divider(
                                           color: Colors.grey.shade400,
                                         ),
                                         SizedBox(height: 10),
                                         Text(
                                           'Eligibility Criteria & Team Formulation:',
                                           style: TextStyle(
                                             fontSize: 16,
                                             fontWeight: FontWeight.bold,
                                           ),
                                         ),
                                         SizedBox(height: 5,),
                                         Container(
                                           child:StreamBuilder<QuerySnapshot>(
                                              stream: doc.reference.collection("EligibilityCriterial").snapshots(),
                                             builder: (context, snapshot){
                                               if (snapshot.hasError) {
                                                 return Center(child: Text('Error: ${snapshot.error}'));
                                               }

                                               if (snapshot.connectionState == ConnectionState.waiting) {
                                                 return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.greenAccent),));
                                               }

                                               if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                                 return Center(child: Text('No Rounds found'));
                                               }
                                               return  ListView.builder(
                                                 shrinkWrap: true,
                                                 physics: NeverScrollableScrollPhysics(),
                                                 itemCount: snapshot.data!.size,
                                                 itemBuilder: (context, index) {
                                                   var doc = snapshot.data!.docs[index];
                                                   var eligibitlityCriteriaData = doc.data() as Map<String, dynamic>;
                                                   return Container(
                                                     margin: EdgeInsets.symmetric(vertical: 3),
                                                     child: RichText(
                                                       text: TextSpan(
                                                         style: TextStyle(
                                                           fontSize: 14,
                                                           color: Colors.grey[600],
                                                         ),
                                                         children: [
                                                           TextSpan(
                                                             text: '• ',
                                                             style: TextStyle(
                                                                 fontWeight: FontWeight.bold),
                                                           ),
                                                           TextSpan(
                                                             text:
                                                             eligibitlityCriteriaData['point'], style: TextStyle()
                                                           ),
                                                         ],
                                                       ),
                                                     ),
                                                   );
                                                 },
                                               );
                                             },
                                           )
                                         ),
                                       ],
                                     ),
                                   );
                                 },
                               );
                             }
                         ),
                          SizedBox(
                            height: 22,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 3,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  'Deadline',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 3,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          StreamBuilder<QuerySnapshot>(
                            stream: widget.docId.reference.collection("RegisterationDeadline").snapshots(),
                            builder: (context, snapshot){
                              if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.greenAccent),));
                              }

                              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                return Center(child: Text('No Rounds found'));
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.size,
                                itemBuilder: (context, index){
                                  var doc = snapshot.data!.docs[index];
                                  var deadlineDate = doc.data() as Map<String, dynamic>;
                                  return Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          size: 48,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Registration Deadline',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              deadlineDate['date'],
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 3,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  'Prize',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 3,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          StreamBuilder<QuerySnapshot>(
                              stream: widget.docId.reference.collection("Prize").snapshots(),
                              builder: (context, snapshot){
                                if (snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                }

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.greenAccent),));
                                }

                                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                  return Center(child: Text('No Rounds found'));
                                }
                                return Center(
                                  child: Container(
                                    height: 220, // Initial height of the card
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.size,
                                      itemBuilder: (context, index) {
                                        var doc = snapshot.data!.docs[index];
                                        var prizeData = doc.data() as Map<String, dynamic>;
                                        return Container(
                                          margin: EdgeInsets.only(right: 15),
                                          width: 180,
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.3),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.trophy,
                                                size: 48,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(height: 10),
                                              Flexible(
                                                child: Text(
                                                  'Prize '+prizeData['prizeNumber'].toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                  maxLines: 2, // Limit to 2 lines
                                                  overflow: TextOverflow.ellipsis, // Display ellipsis for overflow
                                                  softWrap: true, // Allow text to wrap onto multiple lines
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  prizeData['prize'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Colors.redAccent,
                                                  ),
                                                  maxLines: 2, // Limit to 2 lines
                                                  overflow: TextOverflow.ellipsis, // Display ellipsis for overflow
                                                  softWrap: true, // Allow text to wrap onto multiple lines
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }
                          ),
                          SizedBox(height: 18,),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 3,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  'Additional Information',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 3,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 18,),
                          StreamBuilder(
                              stream: widget.docId.reference.collection("AdditionalInformation").snapshots(),
                              builder: (context, snapshot){
                                if (snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                }

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.greenAccent),));
                                }

                                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                  return Center(child: Text('No Rounds found'));
                                }
                                return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.size,
                                        itemBuilder: (context, index) {
                                          var doc = snapshot.data!.docs[index];
                                          var additionalData = doc.data() as Map<String, dynamic>;
                                          return Container(
                                            padding: EdgeInsets.symmetric(vertical: 3),
                                            child: Row(
                                              children: [
                                                Icon(FontAwesomeIcons.circle, size: 12),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                  additionalData['des'],
                                                    style: TextStyle(fontSize: 16), // Add some styling to the text
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }
                          ),
                          SizedBox(height: 90,),
                        ],
                      ),
                    ),
                  )
                ]))
              ],
            ),
            Positioned.fill(
                bottom: 30,
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () async{
                        if(sections.contains(currentUser!.uid.toString())){
                          try {
                            await widget.docId.reference.update({
                              'registeredEvents': FieldValue.arrayRemove([currentUser!.uid.toString()])
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Event Unregistered')));
                            controller.eventRegisterButton.value = !(controller.eventRegisterButton.value);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                          }
                        }
                        else{
                          try {
                            await widget.docId.reference.update({
                              'registeredEvents': FieldValue.arrayUnion([currentUser!.uid.toString()])
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Event Successfully Registered')));
                            controller.eventRegisterButton.value = !(controller.eventRegisterButton.value);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                          }
                        }
                      },
                      child: Obx(() => AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        height: 50,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: controller.eventRegisterButton.value ? Colors.greenAccent : Colors.red,
                        ),
                        child: Align(
                          child: Text(
                            controller.eventRegisterButton.value ? 'REGISTER' : 'UNREGISTER',
                            style: TextStyle(color: controller.eventRegisterButton.value ? Colors.black: Colors.white, fontWeight: FontWeight.bold, fontSize: 22, letterSpacing: 2),
                          ),
                        ),
                      )),
                    ),
                  ),
                )),
          ],
        ));
  }
}
