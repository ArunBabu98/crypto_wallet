// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/pages/createWallet.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  var pro_pic;
  var u_name;
 
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if(user?.photoURL == null) {pro_pic = "assets/images/logo.png";} else {pro_pic = user!.photoURL;}
    if(user?.displayName == null) {u_name = "User Name";} else {u_name = user!.displayName;}
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.amberAccent,
            height: 150,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(pro_pic),
                  scale: 0.1
                  ))
              ),
            ),
          Container(
            margin: const EdgeInsets.all(20),
            child:Text(
              u_name,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold
              ),
              ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            alignment: Alignment.center,
            height: 100,
            width: MediaQuery.of(context).size.width,
            // color: Colors.black,
            child: const Text(
              "Balance",
              style: TextStyle(
                fontSize: 70,
                color: Colors.grey,
                fontWeight: FontWeight.bold
              ),
              ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            alignment: Alignment.center,
            height: 50,
            width: MediaQuery.of(context).size.width,
            // color: Colors.black,
            child: const Text(
              "300\$",
              style: TextStyle(
                fontSize: 50,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold
              ),
              ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child:  ElevatedButton(
              onPressed: () {}, 
              child: const Text("Send Money"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
              ),
              )
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child:  ElevatedButton(
              onPressed: () {}, 
              child: const Text("Refresh Page"),

              )
          ),
          Container(
            margin: const EdgeInsets.only(top: 30, right: 30),
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateWallet()));
              },
              child: const Icon(Icons.add),
              ),
          ),
        ],
      )
    );
  }
}
