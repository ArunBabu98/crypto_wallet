// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:app/utilities/wallet_creation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({Key? key}) : super(key: key);

  @override
  State<CreateWallet> createState() => _CreateWallet();
}

class _CreateWallet extends State<CreateWallet> {
  int selected = 0;
  

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
              ? IconButton(
                  onPressed: () async {
                    setState(() {
                      selected = 1;
                    });
                    WalletAddress service = WalletAddress();
                    final mnemonic = service.generateMnemonic();
                    print(mnemonic);
                    final privateKey = await service.getPrivateKey(mnemonic);
                    print(privateKey);
                    final publicKey = await service.getPublicKey(privateKey);
                    print(publicKey);
                  },
                  icon: const Icon(Icons.add))
              : const Text("Selected"),
        ],
      ),
    );
  }
}
