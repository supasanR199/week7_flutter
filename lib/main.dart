import 'package:flutter/material.dart';
import 'package:flutter_week_7/secondPage.dart';
import 'package:flutter_week_7/thirdpage.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyHome());

class MyHome extends StatelessWidget {
  final appTitle = 'Example Form';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      initialRoute: '/',
      routes: {
        // '/': (context) => MyApp(),
        '/second': (context) => SecondPage(),
        '/thrid': (context) => ThirdPage(),
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Supasan'),
              accountEmail: Text('supasan.garry@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: FlutterLogo(
                  size: 42.8,
                ),
                backgroundColor: Colors.red[50],
              ),
            ),
            ListTile(
              title: Text('SECOND PAGE'),
              onTap: () {
                Navigator.pushNamed(context, '/second');
              },
            ),
            ListTile(
              title: Text('THRID PAGE'),
              onTap: () {
                Navigator.pushNamed(context, '/thrid');
              },
            )
          ],
        ),
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
  File _avatar;
  final _format = DateFormat('dd/MM/yyyy');
  dynamic route;
  bool checkboxValueA = true;
  bool checkboxValueB = true;
  List<String> provices = ['', 'BKK', 'Pathumthani', 'Outbound'];
  dynamic provice = '';
  final picker = ImagePicker();

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
            buildDateField(),
            _avatar == null
                ? RaisedButton(
                    onPressed: () {
                      onChooseImage();
                    },
                    child: Text('Choose Avatar'),
                  )
                : Image.file(_avatar)
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

  DateTimeField buildDateField() {
    return DateTimeField(
      decoration: InputDecoration(labelText: 'Birth Date'),
      format: _format,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
    );
  }

  onChooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _avatar = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
