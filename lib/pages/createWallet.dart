// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:app/utilities/wallet_creation.dart';
import 'package:app/utilities/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web3dart/web3dart.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({Key? key}) : super(key: key);

  @override
  State<CreateWallet> createState() => _CreateWallet();
}

class _CreateWallet extends State<CreateWallet> {
  int selected = 0;
  String? pubAddress;
  String? privAddress;

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
        ],
      ),
      body: Column(
        children: [
          selected == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: const Text("Add a Wallet"),
                    ),
                    Container(
                        margin: const EdgeInsets.all(20),
                        child: ElevatedButton(
                          child: const Icon(Icons.add),
                          onPressed: () async {
                            setState(() {
                              selected = 1;
                            });
                            WalletAddress service = WalletAddress();
                            final mnemonic = service.generateMnemonic();
                            final privateKey =
                                await service.getPrivateKey(mnemonic);
                            final publicKey =
                                await service.getPublicKey(privateKey);
                            privAddress = privateKey;
                            pubAddress = publicKey.toString();
                            addUserDetails(privateKey, publicKey);
                          },
                        ))
                  ],
                )
              : Column(
                  children: [
                    Center(
                        child: Container(
                      margin: const EdgeInsets.all(20),
                      alignment: Alignment.center,
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.blueAccent,
                      child: const Text(
                        "Successfully initiated wallet!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )),
                    const Center(
                      child: Text(
                        "Wallet Private Address :",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "${privAddress}",
                        style: const  TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        "Do not reveal your private address to anyone!",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Divider(),
                     const Center(
                      child: Text(
                        "Wallet Public Address : ",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                     Center(
                      child: Text(
                        "${pubAddress}",
                        style: const  TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const Divider(),
                     const Center(
                      child: Text(
                        "Go back to main page!",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
