import 'package:my_app/utils/constants.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart';

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi/getbalanceabi.json');
  String contractAddress = getbalancecontractAddress;
  final contract = DeployedContract(ContractAbi.fromJson(abi, 'TokenBalance'),
      EthereumAddress.fromHex(contractAddress));
  return contract;
}

Future<List<dynamic>> ask(
    String funcName, List<dynamic> args, Web3Client ethClient) async {
  final contract = await loadContract();
  final ethFunction = contract.function(funcName);
  final result = ethClient.call(
      contract: contract, function: ethFunction, params: [args[0], args[1]]);
  return result;
}
Future<List<dynamic>> getbalance(
    String a1, String a2, Web3Client ethClient) async {
  List<dynamic> result = await ask('getTokenBalance',
      [EthereumAddress.fromHex(a1), EthereumAddress.fromHex(a2)], ethClient);
  return result;
}
