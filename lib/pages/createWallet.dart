// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({Key? key}) : super(key: key);

  @override 
  State<CreateWallet> createState() => _CreateWallet();
}

class _CreateWallet extends State<CreateWallet> {

  @override 
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet Information"),
        actions: [
        IconButton(
          icon: const Icon(Icons.backspace),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],),
      body: Container(

        child: const Text("data"),
      ),
    );
  }
}