import 'package:my_app/utils/constants.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart';
  Future<DeployedContract> loadContract1() async {
    String abi = await rootBundle.loadString('assets/abi/st_abi.json');
    String contractAddress = swapTokenAddress;
    final contract = DeployedContract(ContractAbi.fromJson(abi, 'TokenSwap'),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<String> callFunctionfromst(String funcName, List<dynamic> args,
      Web3Client ethClient, String privateKey) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
    DeployedContract contract = await loadContract1();
    final ethFunction = contract.function(funcName);
    final result = await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract, function: ethFunction, parameters: args),
        chainId: null,
        fetchChainIdFromNetworkId: true);

    return result;
  }
