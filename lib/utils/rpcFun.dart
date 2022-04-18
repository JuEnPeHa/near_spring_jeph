import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

final Map<String, String> HEADERS = {
  'Content-type': 'application/json; charset=utf-8'
};
final String ACCOUNT_HELPER_URL_TESTNET = 'https://helper.testnet.near.org';
final String RPC_URL_TESTNET = 'https://rpc.testnet.near.org';

var rng = Random();

Future<dynamic> rpcFunction({
  String contractId = "spring.jeph.testnet",
  required String nameForHelloWorld,
  required String methodName,
}) async {
  final url = Uri.parse(RPC_URL_TESTNET);
  var args = {"name": nameForHelloWorld};
  var argsBase64 = base64.encode(utf8.encode(json.encode(args)));
  print("argsBase64: $argsBase64");
  var requestBody = getHttpBody(
      methodName: methodName, contractId: contractId, argsBase64: argsBase64);
  var response =
      await http.post(url, body: json.encode(requestBody), headers: HEADERS);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load post');
  }
}

Map<String, Object> getHttpBody(
    {required String methodName,
    required String contractId,
    required String argsBase64,
    String finality = "final"}) {
  return {
    'jsonrpc': "2.0",
    'method': "query",
    "id": rng.nextInt(10000),
    'params': {
      "request_type": "call_function",
      "account_id": contractId,
      "method_name": methodName,
      "args_base64": argsBase64,
      "finality": finality
    },
  };
}

String resolveData(dynamic data) {
  List<int> newLi = [];
  if (data is List<dynamic>) {
    for (var item in data) {
      newLi.add(item);
    }
    String result = utf8.decode(newLi);
    return result;
  } else if (data is String) {
    return data.codeUnits.toString();
  } else {
    return data.toString();
    //throw Exception('Unknown type');
  }
}
