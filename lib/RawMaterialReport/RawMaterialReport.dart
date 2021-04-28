import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tea_records/RawMaterialReport/RawMaterial.dart';
import 'package:tea_records/RawMaterialReport/rawMaterialService.dart';

class RawMaterialdReportForm extends StatefulWidget {
  RawMaterialdReportForm({Key key, this.title}) : super(key: key);
  final String title;

  @override
  RawMaterialState createState() => new RawMaterialState();
}

class RawMaterialState extends State<RawMaterialdReportForm> {
  List<String> _gardenList = <String>['', 'Muthrapam', 'Blf', 'Total Own', 'Borjan'];
  String _garden = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  RawMaterial rawMaterial = new RawMaterial();

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
      var rawMaterialService = new RawMaterialService();
      rawMaterialService.saveRawMaterialReport(rawMaterial).then((value) => showMessage(
          'Raw Material Report data is submitted!', Colors.blue));
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
                                rawMaterial.garden = newValue;
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
                      hintText: 'Enter Leaf Quantity (Kg)',
                      labelText: 'Quantity (Kg)',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp(r"^\d+.?\d{0,2}")),
                    ],
                    validator: (val) => val.isEmpty ? 'Quantity is required' : null,
                    onSaved: (val) => rawMaterial.glfCount = val,
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
                    onSaved: (val) => rawMaterial.fineLeaf = val,
                  ),
                  new TextFormField(
                    enabled: false,
                    decoration: const InputDecoration(
                      hintText: 'Min Fine leaf Target',
                      labelText: 'Min Fine leaf Target',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp(r"^\d+.?\d{0,2}")),
                    ],
                    onSaved: (val) => rawMaterial.fineLeafTarget = val,

                  ),

                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter Explanation For Deviation',
                      labelText: 'Explanation For Deviation',
                    ),
                    onSaved: (val) => rawMaterial.deviationReason = val,
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