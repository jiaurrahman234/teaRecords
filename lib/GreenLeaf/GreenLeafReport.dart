import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'GreenLeaf.dart';
import 'GreenLeafService.dart';

class GreenLeafForm extends StatefulWidget {
  GreenLeafForm({Key key, this.title}) : super(key: key);
  final String title;

  @override
  GreenLeafState createState() => new GreenLeafState();
}

class GreenLeafState extends State<GreenLeafForm> {
  final qtyController = TextEditingController();
  final rateController = TextEditingController();
  TextEditingController amountController = new TextEditingController();
  double totalAmount = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  GreenLeaf greenLeaf = new GreenLeaf();

  textListener() {
    if (qtyController.text.length !=0 && rateController.text.length != 0) {
      print((double.parse(qtyController.text) * double.parse(rateController.text)).toString());
      String amount = (double.parse(qtyController.text) * double.parse(rateController.text)).toStringAsFixed(2);
      amountController.text = amount;
    }
  }

  @override
  void dispose() {
    super.dispose();
    qtyController.dispose();
    rateController.dispose();
  }

  @override
  void initState() {
    super.initState();
    qtyController.addListener(textListener);
    rateController.addListener(textListener);
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
      var greenLeafService = new GreenLeafService();
      greenLeafService.saveLeaf(greenLeaf).then((value) => showMessage(
          'Daily green leaf for Rs ${value.amount} is submitted!', Colors.blue));
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
                    onSaved: (val) => greenLeaf.quantity = val,
                    controller: qtyController,
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
                      onSaved: (val) => greenLeaf.fineLeaf = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter Rate(Rs)',
                      labelText: 'Rate(Rs)',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp(r"^\d+.?\d{0,2}")),
                    ],
                    validator: (val) => val.isEmpty ? 'Rate is required' : null,
                    onSaved: (val) => greenLeaf.rate = val,
                    controller: rateController,
                  ),
                  new TextFormField(
                    controller: amountController,
                    enabled: false,
                    decoration: const InputDecoration(
                      hintText: 'Amount(Rs)',
                      labelText: 'Amount(Rs)',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp(r"^\d+.?\d{0,2}")),
                    ],
                    validator: (val) =>
                        val.isEmpty ? 'Amount is required' : null,
                    onSaved: (val) => greenLeaf.amount = val,
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