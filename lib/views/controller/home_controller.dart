import 'package:event_eaze/views/consts/consts.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  var currNavIndex = 0.obs;
  RxBool eventRegisterButton = false.obs;

  var searchQuery = ''.obs;

  Stream<QuerySnapshot> get eventsStream {
    if (searchQuery.value.isEmpty) {
      return firestore.collection(eventsCollection).snapshots();
    } else {
      return firestore.collection(eventsCollection)
          .where('eventName', isGreaterThanOrEqualTo: searchQuery.value)
          .where('eventName', isLessThanOrEqualTo: searchQuery.value + '\uf8ff')
          .snapshots();
    }
  }
}
