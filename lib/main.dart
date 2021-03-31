import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_app/models/form.dart';
import 'package:form_app/successForm.dart';
import 'package:intl/intl.dart';
import 'package:gsheets/gsheets.dart';

// your google auth credentials
const _credentials = r'''
{
  "type": "service_account",
  "project_id": "customer-inquiry-app",
  "private_key_id": "bb6601ee9b1a1eec1c6b798e8a96d107750c85b8",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDponvQPEOQWRjV\nFGCN0vvkWOIyx/WL6qvfRua1rEsG5G8sm6ahXAv854HoVF8R/OL1AUe5EyeWZeko\nm7Lr+XEYuhPL4absXr/I/PeXFB35EEkO4K58HQ7ob3XejuLVxLI91mV+AYnBqTEc\nJcJPY2YJPYsU0oQvR5uqTiOlXUDBrXBH/a2Zu+ViZz+szwWlK//MZ7QVrH7DiDn9\n6mTsL0jU4ECEK3XyXDTuHwWG4243o4Zz3Te8NXesbS3h4CTefBMjrCd+9qeBGFip\nUQyOGc1/iTzKUJ/vKf2thVrBifRjWU7+NmSAxRMJkKYnOWnoc6zARGRYmECjPPNW\nlk5K3mRVAgMBAAECggEAFIEYbAJt947U5BZ2vDEGaa2h+czyGtvMm7ra5+99Yix4\nKVURFFuXXb8U9/E3qsTOnQFbbGhm8rHHpbMMdTNIyV/DTwMN0El8fBo0wdiXzNJb\nZxKG8wjl1GERL312IPFd/JlYAkKw9q3E9psbE4vor5TsI4wE4oAJWbKj5DvBQX4D\n99uzk9Xr7a88jpA+uHSmCdvWQYocilOAEQvWBVPWQZ21ZOnkk1gILqVKosDKqD6k\nXX7WZ2hVRguDx17aJScWGIJePdGvlCmXf4+/IP90LwrDME3ndAnXoW/xMwVic3W2\n00E3UCbv3G4TlGO9Tc2v/99kPPyRzfRs/sEF84cSXQKBgQD2wceb0vHTCzNeUlsf\n58Ox9YwMO6b4hVOcb34YYdSRrocEypARitIe8HNoIuYELQD89ZBJzLNSiSszyocb\n9uma9gsMgj+ViweDdS5Q4A4QbOyGsMUmaQcYRS7zfMIkDGPnSux5W4BKydKg7LJU\nXXMZxihi7zpimyKW7FGBY676lwKBgQDyYt79onZ3AeqX2TU3YeVK5Nqr3s/q19kl\nq3J3x+qZ8llWMebQGvUINR9EEv6VNqfZ2vlFqpsGXYOuB9w9HPy+2Lr2GIlP7JuB\n/rbT6zwB+uBiWJR9uaZJPkflFPtRuA4BetHtVv0fViIL0yn4cJB6325i7a9m5xT+\nE/rp/MGR8wKBgQClLG+OKfT/3SaEg8JFqCFB1Wjqo1+QScb/F06jyZC998KffWxU\nocUnOrM1yO6JawqXSVVNYT3ECNencnFgUbZrqTkaJXGki4z6/QyEzIX9jrwBKQC/\nRlyebWkRSbi24qhZIbkLPymwZkqct/RjLq6mWROdrh859DiCKCwi3XQ6fwKBgF7s\nvavTLlXZGEizthWkbynvinv43LB6K/6GsGOclZIIyVfqXxxtEj1OoJoGXlGNgBrf\nmPPhpqjNgr5rMaN1cL5FHqM2ZMA6R4SXfn5sB6o22B1r12uNg0P38iwTFYGhdUq7\nEO/EO4lEMD01S6CSZOLaEd8IesLwCNageImehShlAoGBAKB3v3xrWzfYPgshU807\nmtmmTVH2tB1ye1Xw/QlLoGmQ1dumdAOXHU0oB/vvpes8y7Cplfuh9G5XQGzDpsUm\n68oOU7zBDjk+imwcn4M+8sdnnfOvN5NDAeuizRXw91lCO4A843f2vfm4/NjR6G0g\nGcEIssdtSqFhJ2b9sCyax2Pa\n-----END PRIVATE KEY-----\n",
  "client_email": "cutsomer-inquiry-app@customer-inquiry-app.iam.gserviceaccount.com",
  "client_id": "107540768267283919293",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/cutsomer-inquiry-app%40customer-inquiry-app.iam.gserviceaccount.com"
}
''';
// your spreadsheet id
const _spreadsheetId = '1KWJpR27m0fW2S48xDhoUjD_docK7gCzThlcHTT0EpYg';
//const _spreadsheetId = '1kb2u7hE6JtOVKAQDx7fWiVZjo4YY2MGs3duZFOmT41w';

var checkBoxResult = '';
var name;
var cname;

void main() {
  runApp(MyApp());
}

void updateSheet(AppForm appForm, BuildContext context) async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  var sheet = await ss.worksheetByTitle('Sheet1');
  // create worksheet if it does not exist yet
  sheet ??= await ss.addWorksheet('Sheet1');

  // insert list in row #1
  final firstRow = [
    'Company Name',
    'Name',
    'Mobile Number 1',
    'Mobile Number 2',
    'Email ID 1',
    'Email ID 2',
    'Website',
    'Address',
    'Pin Code',
    'City',
    'State',
    'Country',
    'Entry By',
    'Reference By',
    'Remarks',
    'Type',
    'Date',
  ];
  await sheet.values.insertRow(1, firstRow);
  // prints [index, letter, number, label]
  print(await sheet.values.row(1));

  // get first row as List of Cell objects
  final cellsRow = await sheet.cells.row(1);
  // update each cell's value by adding char '_' at the beginning
  cellsRow.forEach((cell) => cell.value = '${cell.value}');
  // actually updating sheets cells
  await sheet.cells.insert(cellsRow);
  // prints [_index, _letter, _number, _label]
  //print(await sheet.values.row(1));

  //appends each row into gsheet
  if (await sheet.values.appendRow([
    appForm.companyName,
    appForm.name,
    appForm.mobile1,
    appForm.mobile2,
    appForm.email1,
    appForm.email2,
    appForm.website,
    appForm.address,
    appForm.pinCode,
    appForm.city,
    appForm.state,
    appForm.country,
    appForm.entryBy,
    appForm.referenceBy,
    appForm.remarks,
    checkBoxResult,
    //appForm.type,
    appForm.date,
  ])) {
    //navigate success
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Screen1();
    }));
  } else {
    //throw error
    showAlertDialog(context);
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Center(child: Text('Ok!')),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Center(child: Text("Error")),
    content: Text("Error occurred while submitting the data. Please ty again!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Sheet Demo',
      theme: ThemeData(
        primaryColor: Colors.brown[800],
      ),
      home: HomeScreen(title: 'Custom Inquiry'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  DateTime _selectedDate;
  FocusNode myFocusNode;

  //TextField Controllers
  TextEditingController companyNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobile1Controller = TextEditingController();
  TextEditingController mobile2Controller = TextEditingController();
  TextEditingController email1Controller = TextEditingController();
  TextEditingController email2Controller = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController entryByController = TextEditingController();
  TextEditingController referenceByController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      getCheckboxItems();

      AppForm appForm = AppForm(
          companyNameController.text,
          nameController.text,
          mobile1Controller.text,
          mobile2Controller.text,
          email1Controller.text,
          email2Controller.text,
          websiteController.text,
          addressController.text,
          pinCodeController.text,
          cityController.text,
          stateController.text,
          countryController.text,
          entryByController.text,
          referenceByController.text,
          remarksController.text,
          dateController.text);

      if ((appForm.companyName).isNotEmpty || (appForm.name).isNotEmpty) {
        _showSnackBar("Submitting the Data");
        updateSheet(appForm, context);
      } else {
        showAlertDialog1(context);
      }
    } else {
      showAlertDialog2(context);
    }
  }

  showAlertDialog2(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Center(child: Text('Ok!')),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert2 = AlertDialog(
      title: Center(child: Text("Warning! ⚠")),
      content: Text("One or more invalid field(s)!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert2;
      },
    );
  }

  showAlertDialog1(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Center(child: Text('Ok!')),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert1 = AlertDialog(
      title: Center(child: Text("Error")),
      content: Text("Enter either Name or Company Name Field!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert1;
      },
    );
  }

  Map<String, bool> values = {
    'Manufacturer': false,
    'Trader': false,
    'Dealer': false,
    'Distributor': false,
  };
  var tmpArray = [];
  getCheckboxItems() {
    values.forEach((key, value) {
      if (value == true) {
        tmpArray.add(key);
      }
    });

    checkBoxResult = '';
    checkBoxResult = tmpArray.join(',');
    tmpArray.clear();
  }

  _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void clearText() {
    companyNameController.clear();
    nameController.clear();
    mobile1Controller.clear();
    mobile2Controller.clear();
    email1Controller.clear();
    email2Controller.clear();
    websiteController.clear();
    addressController.clear();
    pinCodeController.clear();
    cityController.clear();
    stateController.clear();
    countryController.clear();
    entryByController.clear();
    referenceByController.clear();
    remarksController.clear();
    dateController.clear();
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.brown,
                onPrimary: Colors.white,
                surface: Colors.brown,
                onSurface: Colors.brown,
              ),
              dialogBackgroundColor: Color.fromRGBO(236, 219, 218, 1),
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      dateController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: dateController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(myFocusNode);
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quarterMediaWidth = MediaQuery.of(context).size.width * 0.95;
    final halfMediaWidth = quarterMediaWidth / 2.2;

    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 219, 218, 1),
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.topCenter,
                      width: quarterMediaWidth,
                      child: TextFormField(
                        controller: companyNameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black26, width: 1.8)),
                          hintText: "Company Name",
                        ),
                      ),
                    ), //Company name
                    Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.topCenter,
                      width: quarterMediaWidth,
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Full Name",
                          contentPadding: EdgeInsets.all(15),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black26, width: 1.8)),
                        ),
                      ),
                    ), //Full name
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8),
                          width: halfMediaWidth,
                          child: TextFormField(
                            controller: mobile1Controller,
                            focusNode: myFocusNode,
                            validator: (value) {
                              if (value.isNotEmpty) {
                                if (!RegExp("^(?:[+0]9)?[0-9]{10}")
                                    .hasMatch(value)) {
                                  return 'Not a valid Mobile Number!';
                                }
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black26, width: 1.8)),
                                hintText: "Mobile Number 1 "),
                          ),
                        ), //Mobile 1
                        Container(
                          padding: EdgeInsets.all(8),
                          width: halfMediaWidth,
                          child: TextFormField(
                            controller: mobile2Controller,
                            validator: (value) {
                              if (value.isNotEmpty) {
                                if (!RegExp("^(?:[+0]9)?[0-9]{10}")
                                    .hasMatch(value)) {
                                  return 'Not a valid Mobile Number!';
                                }
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black26, width: 1.8)),
                                hintText: "Mobile Number 2"),
                          ),
                        ), //Mobile 2
                      ],
                    ), //Mobile
                    Container(
                      padding: EdgeInsets.all(8),
                      width: quarterMediaWidth,
                      child: TextFormField(
                        controller: email1Controller,
                        validator: (value) {
                          if (value.isNotEmpty) {
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return 'Not a valid Email';
                            }
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 1.8)),
                            hintText: "Email ID 1"),
                      ),
                    ), //Email 1
                    Container(
                      padding: EdgeInsets.all(8),
                      width: quarterMediaWidth,
                      child: TextFormField(
                        controller: email2Controller,
                        validator: (value) {
                          if (value.isNotEmpty) {
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return 'Not a valid Email';
                            }
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 1.8)),
                            hintText: "Email ID 2"),
                      ),
                    ), //Email 2
                    Container(
                      padding: EdgeInsets.all(8),
                      width: quarterMediaWidth,
                      child: TextFormField(
                        controller: websiteController,
                        validator: (value) {
                          if (value.isNotEmpty) {
                            if (!RegExp("^[a-zA-Z]+.[a-zA-Z0-9.-]+.[a-zA-Z]")
                                .hasMatch(value)) {
                              return 'Not a valid website';
                            }
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 1.8)),
                            hintText: "Website"),
                      ),
                    ), //Website
                    Container(
                        padding: EdgeInsets.all(8),
                        width: quarterMediaWidth,
                        child: TextFormField(
                          controller: addressController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black26,
                              width: 1.8,
                            )),
                            hintText: "Address",
                          ),
                        )), //Address
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8),
                          width: halfMediaWidth,
                          child: TextFormField(
                            controller: cityController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black26, width: 1.8)),
                                hintText: "City"),
                          ),
                        ), //City
                        Container(
                          padding: EdgeInsets.all(8),
                          width: halfMediaWidth,
                          child: TextFormField(
                            controller: pinCodeController,
                            validator: (value) {
                              if (value.isNotEmpty) {
                                if (!RegExp("^[0-9]{6}").hasMatch(value)) {
                                  return 'Not a valid Pin code!';
                                }
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black26, width: 1.8)),
                                hintText: "Pin Code"),
                          ),
                        ), //Pin Code
                      ],
                    ), //City Pin Code
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8),
                          width: halfMediaWidth,
                          child: TextFormField(
                            controller: stateController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black26, width: 1.8)),
                                hintText: "State"),
                          ),
                        ), //State
                        Container(
                          width: halfMediaWidth,
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            controller: countryController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black26, width: 1.8)),
                                hintText: "Country"),
                          ),
                        ), //Country
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      width: quarterMediaWidth,
                      child: TextFormField(
                        controller: entryByController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 1.8)),
                            hintText: "Entry By"),
                      ),
                    ), //Entry By
                    Container(
                      padding: EdgeInsets.all(8),
                      width: quarterMediaWidth,
                      child: TextFormField(
                        controller: referenceByController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 1.8)),
                            hintText: "Reference By"),
                      ),
                    ), //Reference By
                    Container(
                      padding: EdgeInsets.all(8),
                      width: quarterMediaWidth,
                      child: TextFormField(
                        controller: remarksController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 1.8)),
                            hintText: "Remarks"),
                      ),
                    ), //Remarks
                    Container(
                      //color: Colors.grey[200],
                      //margin: EdgeInsets.fromLTRB(0, 20, 200, 20),
                      margin: EdgeInsets.all(8),
                      height: 300, width: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            padding: EdgeInsets.all(8),
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Type',
                              style: (TextStyle(fontSize: 18)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            width: quarterMediaWidth,
                            child: ListView(
                              shrinkWrap: true,
                              children: values.keys.map((String key) {
                                return new CheckboxListTile(
                                  title: new Text(key),
                                  value: values[key],
                                  activeColor: Colors.brown,
                                  checkColor: Colors.white,
                                  onChanged: (bool value) {
                                    setState(() {
                                      values[key] = value;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ), //Type
                    Container(
                      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
                      width: quarterMediaWidth,
                      child: TextFormField(
                        controller: dateController,
                        onTap: () {
                          _selectDate(context);
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 1.8)),
                            hintText: "Date"),
                      ),
                    ), //Date
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.brown,
                          textColor: Colors.white,
                          //onPressed: _validateField,
                          onPressed: _submitForm,
                          padding: EdgeInsets.only(right: 8),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          child: Text('Save Data!'),
                        ),
                        RaisedButton(
                          onPressed: clearText,
                          color: Colors.grey,
                          child: Text('Clear'),
                          textColor: Colors.white,
                          padding: EdgeInsets.only(left: 8.0),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
