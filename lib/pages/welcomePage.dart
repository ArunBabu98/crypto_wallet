// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/pages/createWallet.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:app/utilities/firestore.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Client httpClient;
  late Web3Client ethClient;
  String privAddress="";
  EthereumAddress targetAddress = EthereumAddress.fromHex("0xfed0d2b05602d8b3b0fe5b7eb80f124ee98013cd");
  bool? created;
  var balance;
  var credentials;
  int myAmount = 5;
  var pro_pic;
  var u_name;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    httpClient = Client();
    ethClient = Web3Client("https://rinkeby.infura.io/v3/4c98357a2edc4fce82379fe98baa9f97",httpClient);
    details();
  }

  details() async {
    dynamic data = await getUserDetails();
    data != null ?
    setState(() {
      privAddress = data['privateKey'];
      var publicAdress = data['publicKey'];
      var temp = EthPrivateKey.fromHex(privAddress);
      credentials = temp.address;
      // EthPrivateKey fromHex = EthPrivateKey.fromHex(privAddress);
      // final password = FirebaseAuth.instance.currentUser!.uid;
      // Random random=Random.secure();
      // Wallet wallet = Wallet.createNew(fromHex, password,random);
      // print(wallet.toJson());
      created = data['wallet_created'];
      balance = getBalance(credentials);
    }):
    print("Data is NULL!");
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/abi/abi.json");
    String contractAddress = "0x4a151003126f41c5cb23e31f5f29da05676e9cae";
    final contract = DeployedContract(ContractAbi.fromJson(abi, "Gold"), EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(contract: contract, function: ethFunction, params: args);
    return result;
  }

  Future<void> getBalance(EthereumAddress credentialAddress) async {
    List<dynamic> result = await query("balanceOf",[credentialAddress]);
    var data = result[0];
    setState(() {
      balance = data;
    });
  }

  Future<String> sendCoin() async {
    var bigAmount = BigInt.from(myAmount);
    var response = await submit("transfer",[targetAddress,bigAmount]);
    return response;
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(functionName);
    EthPrivateKey key = EthPrivateKey.fromHex(privAddress);
    Transaction transaction = await Transaction.callContract(contract: contract, function: ethFunction, parameters: args, maxGas: 100000);
    final result = await ethClient.sendTransaction(key,transaction ,chainId:4);
    return result;
  }


 
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if(user?.photoURL == null) {pro_pic = "assets/images/logo.png";} else {pro_pic = user!.photoURL;}
    if(user?.displayName == null) {u_name = "User Name";} else {u_name = user!.displayName;}
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
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
            child: Text(
              "${balance}\GLD",
              style: const TextStyle(
                fontSize: 50,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold
              ),
              ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child:  ElevatedButton(
              onPressed: () async{
                var response = await sendCoin();
                print(response);
              }, 
              child: const Text("Send Money"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
              ),
              )
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child:  ElevatedButton(
              onPressed: () {
                credentials != null?
                getBalance(credentials):
                print("credentials null");
              }, 
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
