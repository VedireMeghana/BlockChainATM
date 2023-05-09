import 'package:my_app/utils/constants.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart';

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi/cp_abi.json');
  String contractAddress = currentPriceAddress;
  final contract = DeployedContract(
      ContractAbi.fromJson(abi, 'PriceConsumerV3'),
      EthereumAddress.fromHex(contractAddress));
  return contract;
}

Future<List<dynamic>> getbtcprice(Web3Client ethClient) async {
  List<dynamic> result = await ask('getbtcLatestPrice', [], ethClient);
  return result;
}

Future<List<dynamic>> getethprice(Web3Client ethClient) async {
  List<dynamic> result = await ask('getethLatestPrice', [], ethClient);
  return result;
}

Future<List<dynamic>> ask(
    String funcName, List<dynamic> args, Web3Client ethClient) async {
  final contract = await loadContract();
  final ethFunction = contract.function(funcName);
  final result =
      ethClient.call(contract: contract, function: ethFunction, params: []);
  return result;
}
