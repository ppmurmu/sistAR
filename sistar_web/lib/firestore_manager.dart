import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreManager{

  CollectionReference userReference= FirebaseFirestore.instance.collection('user');
  CollectionReference taskReference= FirebaseFirestore.instance.collection('task');


}