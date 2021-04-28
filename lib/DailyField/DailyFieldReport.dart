import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tea_records/DailyField/FieldReportService.dart';

import 'FieldReport.dart';

class DailyFieldReportForm extends StatefulWidget {
  DailyFieldReportForm({Key key, this.title}) : super(key: key);
  final String title;

  @override
  FieldReportState createState() => new FieldReportState();
}

class FieldReportState extends State<DailyFieldReportForm> {
  final qtyController = TextEditingController();
  final noPluckerController = TextEditingController();
  TextEditingController cropAchievedController = new TextEditingController();
  TextEditingController pluckerController = new TextEditingController();
  double totalAmount = 0;
  List<String> _gardenList = <String>['', 'Sundarpur', 'Raidang', 'Baruakhat', 'Majidpur'];
  String _garden = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  FieldReport fieldReport = new FieldReport();

  textListener() {
    cropAchievedController.text = qtyController.text;
    if (qtyController.text.length !=0 && noPluckerController.text.length != 0) {
      String pluckerAchieved = (double.parse(qtyController.text) / double.parse(noPluckerController.text)).round().toString();
      print(pluckerAchieved);
      pluckerController.text = pluckerAchieved;
    }
  }

  @override
  void dispose() {
    super.dispose();
    qtyController.dispose();
    noPluckerController.dispose();
  }

  @override
  void initState() {
    super.initState();
    qtyController.addListener(textListener);
    noPluckerController.addListener(textListener);
  }

  bool isValidLeafCount(String input) {
    if (input.length > 0) {
      if ((0 <= double.parse(input)) && (double.parse(input) <= 100)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }


  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save(); //This invokes each onSaved event
      var fieldReportService = new FieldReportService();
      fieldReportService.saveFieldReport(fieldReport).then((value) => showMessage(
          'Daily Field Report data is submitted!', Colors.blue));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.title),
        centerTitle: false,
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[

                  new FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Select Garden',
                          errorText: state.hasError ? state.errorText : null,
                        ),
                        isEmpty: _garden == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton<String>(
                            value: _garden,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                fieldReport.garden = newValue;
                                _garden = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _gardenList.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                    validator: (val) {
                      return val != '' ? null : 'Please select a garden';
                    },
                  ),

                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter Fine Leaf(%)',
                      labelText: 'Fine Leaf(%)',
                    ),
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp(r"^\d+.?\d{0,2}")),
                    ],
                    keyboardType: TextInputType.number,
                    validator: (value) => isValidLeafCount(value)
                        ? null
                        : 'Fine Leaf should be between 0 to 100',
                    onSaved: (val) => fieldReport.fineLeaf = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter Leaf Quantity (Kg)',
                      labelText: 'Quantity (Kg)',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp(r"^\d+.?\d{0,2}")),
                    ],
                    validator: (val) => val.isEmpty ? 'Quantity is required' : null,
                    onSaved: (val) => fieldReport.glfCount = val,
                    controller: qtyController,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter Total Mandays',
                      labelText: 'Total Mandays',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp(r"^\d+.?\d{0,2}")),
                    ],
                    validator: (val) => val.isEmpty ? 'Total Mandays is required' : null,
                    onSaved: (val) => fieldReport.totalMandays = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter No. Of Pluckers',
                      labelText: 'No. Of Pluckers',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp(r"^\d+.?\d{0,2}")),
                    ],
                    validator: (val) => val.isEmpty ? 'No. of Plucker is required' : null,
                    onSaved: (val) => fieldReport.noPluckers = val,
                    controller: noPluckerController,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter Plucking Area(Hectare)',
                      labelText: 'Plucking Area(Hectare)',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp(r"^\d+.?\d{0,2}")),
                    ],
                    validator: (val) => val.isEmpty ? 'Plucking area is required' : null,
                    onSaved: (val) => fieldReport.pluckingArea = val,
                  ),
                  new TextFormField(
                    enabled: false,
                    decoration: const InputDecoration(
                      hintText: 'Crop Target',
                      labelText: 'Crop Target',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp(r"^\d+.?\d{0,2}")),
                    ],
                    onSaved: (val) => fieldReport.cropTarget = val,

                  ),
                  new TextFormField(
                    enabled: false,
                    decoration: const InputDecoration(
                      hintText: 'Crop Achieved',
                      labelText: 'Crop Achieved',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp(r"^\d+.?\d{0,2}")),
                    ],
                    validator: (val) => val.isEmpty ? 'Crop Achieved is required' : null,
                    onSaved: (val) => fieldReport.cropAchieved = val,
                    controller: cropAchievedController,
                  ),

                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter Explanation For crop -ve Deviation',
                      labelText: 'Explanation For crop -ve Deviation',
                    ),
                    onSaved: (val) => fieldReport.cropReason = val,
                  ),
                  new TextFormField(
                    enabled: false,
                    decoration: const InputDecoration(
                      hintText: 'Pluckers Target',
                      labelText: 'Pluckers Target',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp(r"^\d+.?\d{0,2}")),
                    ],
                    onSaved: (val) => fieldReport.pluckerTarget = val,
                  ),
                  new TextFormField(
                    enabled: false,
                    decoration: const InputDecoration(
                      hintText: 'Pluckers Achieved',
                      labelText: 'Pluckers Achieved',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp(r"^\d+.?\d{0,2}")),
                    ],
                    validator: (val) => val.isEmpty ? 'Quantity is required' : null,
                    onSaved: (val) => fieldReport.glfCount = val,
                    controller: pluckerController,
                  ),

                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter Explanation For Pluckers -ve Deviation',
                      labelText: 'Explanation For Pluckers -ve Deviation',
                    ),
                    onSaved: (val) => fieldReport.pluckerReason = val,
                  ),
                  new Container(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Submit'),
                        onPressed: _submitForm,
                      )),
                ],
              ))),
    );
  }
}