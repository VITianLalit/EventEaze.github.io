import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_eaze/views/consts/consts.dart';
import 'package:event_eaze/views/controller/home_controller.dart';
import 'package:event_eaze/views/home_screen/event_details.dart';
import 'package:get/get.dart';

Widget makeItem({image, eventName, dateNumber, dateMonth, time, imgPath,required QueryDocumentSnapshot doc}){
  return Row(
    children: [
      Container(
        width: 50,
        height: 200,
        margin: EdgeInsets.only(right: 20),
        child: Column(
          children: [
            Text(dateNumber.toString(), style: TextStyle(color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold, ),),
            Text(dateMonth.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, ),)
          ],
        ),
      ),
      Expanded(
        child: InkWell(
          onTap: (){
            Get.to(() => EventDetails(docId: doc), transition: Transition.circularReveal, duration: Duration(milliseconds: 1000));
          },
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(imgPath),
                fit: BoxFit.cover,
              )
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(.4),
                    Colors.black.withOpacity(.1),
                  ]
                )
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(eventName.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.white,),
                        SizedBox(width: 10,),
                        Text(time.toString(), style: TextStyle(color: Colors.white),),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    ],
  );
}