import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tea_records/RawMaterialReport/RawMaterial.dart';

class RawMaterialService {
  static const _serviceUrl = 'http://mockbin.org/echo';
  static final _headers = {'Content-Type': 'application/json'};

  Future<RawMaterial> saveRawMaterialReport(RawMaterial rawMaterial) async {
    try {
      String json = _toJson(rawMaterial);
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

  RawMaterial _fromJson(String fieldReport) {
    Map<String, dynamic> map = json.decode(fieldReport);
    var rawMaterialData              = new RawMaterial();
    rawMaterialData.garden           = map['garden'];
    rawMaterialData.glfCount         = map['glfCount'];
    rawMaterialData.fineLeaf         = map['fineLeaf'];
    rawMaterialData.fineLeafTarget   = map['fineLeafTarget'];
    rawMaterialData.deviationReason  = map['deviationReason'];
    return rawMaterialData;
  }

  String _toJson(RawMaterial rawMaterialData) {
    var map = new Map();
    map['garden']          = rawMaterialData.garden;
    map['glfCount']        = rawMaterialData.glfCount;
    map['fineLeaf']        = rawMaterialData.fineLeaf;
    map['fineLeafTarget']  = rawMaterialData.fineLeafTarget;
    map['deviationReason'] = rawMaterialData.deviationReason;
    String jsonContact = json.encode(map);
    return jsonContact;
  }
}