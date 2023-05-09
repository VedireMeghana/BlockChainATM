import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:http/http.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:web3dart/web3dart.dart';
import 'package:my_app/utils/constants.dart';
import 'package:my_app/services/getbalance_function.dart';
import 'package:my_app/services/tokenswap_function.dart';

class Tokenswap extends StatefulWidget {
  const Tokenswap({super.key});

  @override
  State<Tokenswap> createState() => _TokenswapState();
}

class _TokenswapState extends State<Tokenswap> {
  Client? httpClient;
  Web3Client? ethClient;
  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infura_sepolia_Url, httpClient!);
    super.initState();
  }

  late String acc1;
  late String acc2;
  late String tok1;
  late String tok2;
  late BigInt amount1;
  late BigInt amount2;
  String gldbal1 = "";
  String slvbal1 = "";
  String gldbal2 = "";
  String slvbal2 = "";
  bool _isLoading1 = false;
  bool _isLoading2 = false;

  void showSuccessMessage() {
    Fluttertoast.showToast(
        msg: "Swapped Tokens successfully!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void incompleteDetails() {
    Fluttertoast.showToast(
        msg: "Please enter valid addresses!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Swap Tokens"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(5, 5, 15, 5)),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/metamask_small.png',
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('Open Metamask'),
                        ],
                      ),
                      onPressed: () async => {
                        await LaunchApp.openApp(
                          androidPackageName: 'io.metamask',
                        )
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      height: 40,
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        color: Colors.white,
                        disabledColor: Color.fromARGB(255, 71, 58, 51),
                        onPressed: null,
                        // ignore: prefer_const_constructors
                        child: Text(
                          "Owner 1",
                          style: TextStyle(
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: TextField(
                        controller: controller1,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(11),
                          border: OutlineInputBorder(),
                          labelText: 'Enter Account 1 Address',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      height: 40,
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        color: Colors.white,
                        disabledColor: Color.fromARGB(255, 71, 58, 51),
                        onPressed: null,
                        child: Text(
                          "Token 1",
                          style: TextStyle(
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: TextField(
                        controller: controller2,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(11),
                          border: OutlineInputBorder(),
                          labelText: 'Enter Token 1 Address',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      height: 40,
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        color: Colors.white,
                        disabledColor: Color.fromARGB(255, 71, 58, 51),
                        onPressed: null,
                        child: Text(
                          "Owner 2",
                          style: TextStyle(
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: TextField(
                        controller: controller3,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(11),
                          border: OutlineInputBorder(),
                          labelText: 'Enter Account 2 Address',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      height: 40,
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        color: Colors.white,
                        disabledColor: Color.fromARGB(255, 71, 58, 51),
                        onPressed: null,
                        child: Text(
                          "Token 2",
                          style: TextStyle(
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: TextField(
                        controller: controller4,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(11),
                          border: OutlineInputBorder(),
                          labelText: 'Enter Token 2 Address',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      height: 40,
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        color: Colors.white,
                        disabledColor: Color.fromARGB(255, 71, 58, 51),
                        onPressed: null,
                        child: Text(
                          "GOLD",
                          style: TextStyle(
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: TextField(
                        controller: controller5,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(11),
                          border: OutlineInputBorder(),
                          labelText: 'Enter no of GOLD tokens',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      height: 40,
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        color: Colors.white,
                        disabledColor: Color.fromARGB(255, 71, 58, 51),
                        onPressed: null,
                        child: Text(
                          "SILVER",
                          style: TextStyle(
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: TextField(
                        controller: controller6,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(11),
                          border: OutlineInputBorder(),
                          labelText: 'Enter no of SILVER tokens',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                  //style: Color,
                  child: const Text('Swap Tokens'),
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 17),
                    elevation: 3,
                    minimumSize: const Size(100, 40), //////// HERE
                  ),
                  onPressed: () async {
                    acc1 = controller1.text;
                    tok1 = controller2.text;
                    acc2 = controller3.text;
                    tok2 = controller4.text;
                    if (acc1.isEmpty ||
                        acc2.isEmpty ||
                        tok1.isEmpty ||
                        tok2.isEmpty) {
                      incompleteDetails();
                    } 
                      amount1 = BigInt.parse(controller5.text) *
                          BigInt.from(pow(10, 18));
                      amount2 = BigInt.parse(controller6.text) *
                          BigInt.from(pow(10, 18));
                      print(acc1);
                      print(acc2);
                      print(amount1);
                      print(amount2);

                      callFunctionfromst(
                          'swap',
                          [
                            EthereumAddress.fromHex(tok1),
                            EthereumAddress.fromHex(acc1),
                            EthereumAddress.fromHex(tok2),
                            EthereumAddress.fromHex(acc2),
                            amount1,
                            amount2
                          ],
                          ethClient!,
                          owner_private_key);
                      showSuccessMessage();
                    }
                  
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(padding: EdgeInsets.all(0)),
                        SizedBox(
                          width: 160,
                          child: CupertinoButton(
                            minSize: 0,
                            pressedOpacity: 1.0,
                            padding: EdgeInsets.all(10),
                            color: Color.fromARGB(255, 115, 84, 188),
                            onPressed: () async {
                              setState(() {
                                _isLoading1 = true;
                              });
                              await Future.delayed(const Duration(seconds: 1));
                              acc1 = controller1.text;
                              tok1 = controller2.text;
                              tok2 = controller4.text;
                              if (acc1.isEmpty ||
                                  tok1.isEmpty ||
                                  tok2.isEmpty) {
                                setState(() {
                                  _isLoading1 = false;
                                });
                                incompleteDetails();
                              } 
                                var res1 =
                                    await getbalance(tok1, acc1, ethClient!);
                                BigInt bigint1 = BigInt.from(
                                    res1[0] / BigInt.from(pow(10, 18)));
                                var res2 =
                                    await getbalance(tok2, acc1, ethClient!);
                                BigInt bigint2 = BigInt.from(
                                    res2[0] / BigInt.from(pow(10, 18)));
                                setState(() {
                                  gldbal1 = '$bigint1';
                                  slvbal2 = '$bigint2';
                                  _isLoading1 = false;
                                });
                                print(gldbal1);
                                print(slvbal2);
                              
                            },
                            child: const Text(
                              "Account 1 balance",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: !_isLoading1
                              ? Column(
                                  children: [
                                    Text(
                                      'GOLD : $gldbal1',
                                      style: const TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'SILVER : $slvbal2',
                                      style: const TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              : const CircularProgressIndicator(),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Padding(padding: EdgeInsets.all(0)),
                        SizedBox(
                          width: 160,
                          child: CupertinoButton(
                            minSize: 0,
                            pressedOpacity: 1.0,
                            padding: EdgeInsets.all(10),
                            color: Color.fromARGB(255, 115, 84, 188),
                            onPressed: () async {
                              setState(() {
                                _isLoading2 = true;
                              });
                              await Future.delayed(const Duration(seconds: 2));
                              acc2 = controller3.text;
                              tok1 = controller2.text;
                              tok2 = controller4.text;
                              if (acc2.isEmpty ||
                                  tok1.isEmpty ||
                                  tok2.isEmpty) {
                                setState(() {
                                  _isLoading2 = false;
                                });
                                incompleteDetails();
                              }
                                var res1 =
                                    await getbalance(tok2, acc2, ethClient!);
                                BigInt bigint1 = BigInt.from(
                                    res1[0] / BigInt.from(pow(10, 18)));
                                var res2 =
                                    await getbalance(tok1, acc2, ethClient!);
                                BigInt bigint2 = BigInt.from(
                                    res2[0] / BigInt.from(pow(10, 18)));
                                setState(() {
                                  slvbal1 = '$bigint1';
                                  gldbal2 = '$bigint2';
                                  _isLoading2 = false;
                                });
                              
                            },
                            child: const Text(
                              "Account 2 balance",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: !_isLoading2
                              ? Column(
                                  children: [
                                    Text(
                                      'SILVER : $slvbal1',
                                      style: const TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'GOLD : $gldbal2',
                                      style: const TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              : const CircularProgressIndicator(),
                        ),
                      ],
                    )
                  ],
                ),
                //     ElevatedButton(

                //   child: Text('Login'),
                //   onPressed: (){
                //     print(account1);
                //     print(account2);
                //     print(amount1);
                //     print(amount2);
                //   },
                // )
              ],
            )),
      ),
    );
  }
}
