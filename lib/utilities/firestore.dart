import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void addUserDetails(privateKey,publicKey,ethereumAddress) async {
  var userInstance = FirebaseAuth.instance.currentUser;
  await FirebaseFirestore.instance.collection("users").doc(userInstance!.uid).set({
    'user_name': userInstance,
    'privateKey': privateKey,
    'publicKey': publicKey,
    'ethereumAddress': ethereumAddress 
  }).whenComplete(() => {print("EXXECCUTTEDDD!")}).catchError((error) {print(error.toString());});

}