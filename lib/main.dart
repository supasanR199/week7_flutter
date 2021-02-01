import 'package:flutter/material.dart';

void main() => runApp(MyHome());

class MyHome extends StatelessWidget {
  final appTitle = 'Example Form';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      initialRoute: '/',
      routes: {
        //      '/homepage': (context) => Homepage(),
      },
      home: MyApp(title: appTitle),
    );
  }
}

class MyApp extends StatelessWidget {
  final String title;
  MyApp({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: Center(
          child: ListView(children: <Widget>[
        MyRadio(),
      ])),
    );
  }
}

class MyRadio extends StatefulWidget {
  MyRadio({Key key}) : super(key: key);

  @override
  _MyRadioState createState() => _MyRadioState();
}

class _MyRadioState extends State<MyRadio> {
  dynamic route;
  bool checkboxValueA = true;
  bool checkboxValueB = true;
  List<String> provices = ['', 'BKK', 'Pathumthani', 'Outbound'];
  dynamic provice = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildRadioButton(),
            Row(children: [
              Text('$route'),
            ]),
            buildCheckbox(),
            Row(children: [
              Text('$checkboxValueA'),
            ]),
            Row(children: [
              Text('$checkboxValueB'),
            ]),
            buildSelectField(),
          ]),
    );
  }

  Row buildCheckbox() {
    return Row(children: [
      Checkbox(
        value: checkboxValueA,
        onChanged: (bool value) {
          setState(() {
            checkboxValueA = value;
          });
        },
      ),
      Text('CheckBox A'),
      Checkbox(
        value: checkboxValueB,
        onChanged: (bool value) {
          setState(() {
            checkboxValueB = value;
          });
        },
      ),
      Text('CheckBox B'),
    ]);
  }

  Row buildRadioButton() {
    return Row(children: [
      Radio(
        value: 'M',
        groupValue: route,
        onChanged: (value) {
          setState(() {
            route = value;
          });
        },
      ),
      Text('Male'),
      Radio(
        value: 'F',
        groupValue: route,
        onChanged: (value) {
          // _handleTapboxChanged(value);
          setState(() {
            route = value;
          });
        },
      ),
      Text('Female'),
    ]);
  }

  InputDecorator buildSelectField() {
    return InputDecorator(
      decoration: InputDecoration(labelText: 'Province'),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          items: provices.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem),
            );
          }).toList(),
          value: provice,
          onChanged: (String newValueSelected) {
            setState(() {
              provice = newValueSelected;
            });
          },
        ),
      ),
    );
  }
}
