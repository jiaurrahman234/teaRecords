import 'dart:convert';

import 'package:tea_records/DailyField/FieldReport.dart';
import 'package:http/http.dart' as http;

class FieldReportService {
  static const _serviceUrl = 'http://mockbin.org/echo';
  static final _headers = {'Content-Type': 'application/json'};

  Future<FieldReport> saveFieldReport(FieldReport fieldReport) async {
    try {
      String json = _toJson(fieldReport);
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

  FieldReport _fromJson(String fieldReport) {
    Map<String, dynamic> map = json.decode(fieldReport);
    var fieldReportData = new FieldReport();
    fieldReportData.garden          = map['garden'];
    fieldReportData.fineLeaf        = map['fineLeaf'];
    fieldReportData.glfCount        = map['glfCount'];
    fieldReportData.totalMandays    = map['totalMandays'];
    fieldReportData.noPluckers      = map['noPluckers'];
    fieldReportData.pluckingArea    = map['pluckingArea'];
    fieldReportData.cropTarget      = map['cropTarget'];
    fieldReportData.cropAchieved    = map['cropAchieved'];
    fieldReportData.cropReason      = map['cropReason'];
    fieldReportData.pluckerTarget   = map['pluckerTarget'];
    fieldReportData.pluckerAchieved = map['pluckerAchieved'];
    fieldReportData.pluckerReason   = map['pluckerReason'];
    return fieldReportData;
  }

  String _toJson(FieldReport fieldReportData) {
    var map = new Map();
     map['garden']              =    fieldReportData.garden         ;
     map['fineLeaf']            =    fieldReportData.fineLeaf       ;
     map['glfCount']            =    fieldReportData.glfCount       ;
     map['totalMandays']        =    fieldReportData.totalMandays   ;
     map['noPluckers']          =    fieldReportData.noPluckers     ;
     map['pluckingArea']        =    fieldReportData.pluckingArea   ;
     map['cropTarget']          =    fieldReportData.cropTarget     ;
     map['cropAchieved']        =    fieldReportData.cropAchieved   ;
     map['cropReason']          =    fieldReportData.cropReason     ;
     map['pluckerTarget']       =    fieldReportData.pluckerTarget  ;
     map['pluckerAchieved']     =    fieldReportData.pluckerAchieved;
     map['pluckerReason']       =    fieldReportData.pluckerReason  ;
    String jsonContact = json.encode(map);
    return jsonContact;
  }
}