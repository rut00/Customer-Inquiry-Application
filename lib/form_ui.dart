/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_app/main.dart';
import 'package:form_app/models/form.dart';
import 'package:email_validator/email_validator.dart' as emailValidator;
import 'package:validators/validators.dart' as validator;
import 'package:form_app/controller/controller.dart';

class FormUi {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //TextField Controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void _submitForm() {
    //if (_formKey.currentState.validate()) {
    AppForm appForm = AppForm(
      //this.firstNameController
      firstNameController.text,
      lastNameController.text,
      emailController.text,
      passwordController.text,
      confirmPasswordController.text,
    );

    _showSnackBar(String message) {
      final snackBar = SnackBar(
        content: Text(message),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    _showSnackBar("Submitting the Data");

    updateSheet(appForm);
  }

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                width: halfMediaWidth,
                child: TextFormField(
                  controller: firstNameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter first name";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: "First Name",
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                width: halfMediaWidth,
                child: TextFormField(
                  controller: lastNameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter last name";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Last Name",
                    contentPadding: EdgeInsets.all(15),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Email ID';
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return 'Please a valid Email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: "Email ID 1"),
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter second Email ID';
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return 'Please a valid Email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: "Email ID 1"),
              ),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(hintText: "Confirm Password"),
              ),
              RaisedButton(
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: _submitForm,
                child: Text('Save Data!'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
*/
