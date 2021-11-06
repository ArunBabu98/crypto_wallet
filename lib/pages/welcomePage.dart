// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  @override
  Widget build(BuildContext context) {
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
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(image: AssetImage('assets/images/logo.png')))
              ),
            ),
          Container(
            margin: const EdgeInsets.all(20),
            child: const Text(
              "User Name",
              style: TextStyle(
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
        ],
      )
    );
  }
}
