import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: new Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _infText = "Enter your data";

  void _resetFields() {
    weightController.clear();
    heightController.clear();

    setState(() {
      _infText = "Enter your data";
    });
  }

  void _calcBMI() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double bmi = weight / (height * height);

      if (bmi < 18.6) {
        _infText = "Low Weight. BMI (${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 18.6 && bmi < 24.9) {
        _infText = "Ideal Weight. BMI (${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 24.9 && bmi < 29.9) {
        _infText = "Overweight. BMI (${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 29.9 && bmi < 34.9) {
        _infText = "Obesity I. BMI (${bmi.toStringAsPrecision(4)})";
      } else if (bmi >= 34.9 && bmi < 39.9) {
        _infText = "Obesity II. BMI (${bmi.toStringAsPrecision(4)})";
      } else {
        _infText = "Obesity III. BMI (${bmi.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person, size: 120.0, color: Colors.lightBlue),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Weight:",
                        labelStyle: TextStyle(color: Colors.lightBlue)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.lightBlue, fontSize: 25.0),
                    controller: weightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Mandatory";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Height:",
                        labelStyle: TextStyle(color: Colors.lightBlue)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.lightBlue, fontSize: 25.0),
                    controller: heightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Mandatory";
                      }
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Container(
                        height: 50.0,
                        child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _calcBMI();
                              }
                            },
                            child: Text("Calculate",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25.0)),
                            color: Colors.lightBlue),
                      )),
                  Text(
                    _infText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.lightBlue, fontSize: 25.0),
                  )
                ],
              ))),
    );
  }
}
