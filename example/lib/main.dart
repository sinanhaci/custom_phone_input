// ignore_for_file: unused_element

import 'package:custom_phone_input/custom_phone_input.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Phone Field Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                IntlPhoneField(
                  searchFieldStyle: TextStyle(),
                  pickerDialogStyle: _pickerDialogStyle(context),
                  dialogBackgroundColor: Colors.white,
                  backButtonColor: Colors.grey.withOpacity(0.3),
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
                    print('Country changed to: ' + country.name);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  child: Text('Submit'),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    _formKey.currentState?.validate();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

 _pickerDialogStyle(BuildContext context) {
    return PickerDialogStyle(
      searchFieldInputDecoration: InputDecoration(

        hintText: 'searchCountry',
        suffixIcon: Icon(Icons.search),
        alignLabelWithHint: true,
        fillColor: Colors.grey.withOpacity(0.3),
        hoverColor: Colors.grey.withOpacity(0.3),
        focusColor: Colors.grey.withOpacity(0.3),
        border: _textFieldBorder(context),
        focusedBorder: _textFieldBorder(context),
        enabledBorder: _textFieldBorder(context),
        iconColor: Colors.black,
        contentPadding: const EdgeInsets.only(left: 16),
        
      ),
      
      
      listTileDivider:
          Container(height: 1, color: Colors.grey.withOpacity(0.3),),
      searchFieldCursorColor: Colors.grey.withOpacity(0.3),
    );
  }
  _textFieldBorder(BuildContext context) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)));
  }
   _errorBorder(BuildContext context) {
    return OutlineInputBorder(
        borderRadius:BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.red));
  }