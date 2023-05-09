import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:my_app/services/getprice_functions.dart';
import 'package:web3dart/web3dart.dart';
import 'package:my_app/utils/constants.dart';

class Getpricepage extends StatefulWidget {
  const Getpricepage({super.key});

  @override
  State<Getpricepage> createState() => _GetpricepageState();
}

class _GetpricepageState extends State<Getpricepage> {
  Client? httpClient;
  Web3Client? ethClient;
  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infuraurl, httpClient!);
    super.initState();
  }

  String btc = "";
  String eth = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Current Prices'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(50)),
            Container(
              child: Image.asset('assets/images/bitcoin.png',
                  fit: BoxFit.fitWidth),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(22, 11, 22, 11)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 20))),
                onPressed: () async {
                  var res1 = await getbtcprice(ethClient!);
                  double bigint = res1[0] / BigInt.from(pow(10, 8));
                  String temp = bigint.toStringAsFixed(2);
                  setState(() {
                    btc = '\$' + '$temp';
                  });
                },
                child: const Text(
                  "Bitcoin Price",
                )),
            const SizedBox(height: 20),
            Text(
              "Current Price : $btc",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
               style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(22, 11, 22, 11)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 20))),
                onPressed: () async {
                  var res1 = await getethprice(ethClient!);
                  double bigint = res1[0] / BigInt.from(pow(10, 8));
                  String temp = bigint.toStringAsFixed(2);
                  setState(() {
                    eth = '\$'+'$temp';
                  });
                },
                child: const Text(
                  "Ethereum Price",
                )),
            const SizedBox(height: 20),
            Text("Current Price : $eth",
             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(
              height: 20,
            ),
            Container(
              child: Image.asset('assets/images/ethereum.png',
                  fit: BoxFit.fitWidth),
            ),
          ],
        ),
      ),
    );
  }
}
