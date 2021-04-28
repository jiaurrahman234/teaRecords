import 'dart:convert';

import 'package:intl/intl.dart';

import 'GreenLeaf.dart';
import 'package:http/http.dart' as http;

class GreenLeafService {
  static const _serviceUrl = 'http://mockbin.org/echo';
  static final _headers = {'Content-Type': 'application/json'};

  Future<GreenLeaf> saveLeaf(GreenLeaf greenLeaf) async {
    try {
      String json = _toJson(greenLeaf);
      final response =
      await http.post(_serviceUrl, headers: _headers, body: json);
      var c = _fromJson(response.body);
      return c;
    } catch (e) {
      print('Server Exception!!!');
      print(e);
      return null;
    }
  }

  GreenLeaf _fromJson(String greenLeaf) {
    Map<String, dynamic> map = json.decode(greenLeaf);
    var greenLeafData = new GreenLeaf();
    greenLeafData.quantity = map['quantity'];
    greenLeafData.fineLeaf = map['fineLeaf'];
    greenLeafData.rate = map['rate'];
    greenLeafData.amount = map['amount'];
    return greenLeafData;
  }

  String _toJson(GreenLeaf greenLeaf) {
    var mapData = new Map();
    mapData["quantity"] = greenLeaf.quantity;
    mapData["fineLeaf"] = greenLeaf.fineLeaf;
    mapData["rate"] = greenLeaf.rate;
    mapData["amount"] = greenLeaf.amount;
    String jsonContact = json.encode(mapData);
    return jsonContact;
  }
}