import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_chat_app/Widgets/Pickers/image_picker.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key key, this.submitAuthForm, this.loader}) : super(key: key);
  final bool loader;
  final void Function(
      {String email,
      String password,
      String username,
      bool isLoginMode,
      File image}) submitAuthForm;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  String email = '';
  String password = '';
  String userName = '';
  var loginMode = true;
  File _pickedImage;

  GlobalKey<FormState> _form = GlobalKey<FormState>();
  void pickImage(image) {
    _pickedImage = image;
  }

  _trySubmit() {
    final isValid = _form.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_pickedImage == null && !loginMode) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an Image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (isValid) {
      _form.currentState.save();
      widget.submitAuthForm(
          email: email.trim(),
          password: password.trim(),
          username: userName.trim(),
          isLoginMode: loginMode,
          image: _pickedImage);
      print(email);
      print(userName);
      print(password);

      ///Gonna take care of you sooon bitch
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!loginMode)
                  PickDPWidget(
                    imagePickFn: pickImage,
                  ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  key: ValueKey('email'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter your email";
                    } else if (!value.contains('@') && !value.contains('.')) {
                      return 'Enter a valid email';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    labelText: 'Email',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (!loginMode)
                  TextFormField(
                    key: ValueKey('username'),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.perm_contact_calendar_outlined),
                      labelText: 'Username',
                    ),
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'Username must be at least 4 characters long';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      userName = value;
                    },
                  ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  key: ValueKey('password'),
                  textInputAction:
                      loginMode ? TextInputAction.done : TextInputAction.next,
                  onFieldSubmitted: (value) => _trySubmit(),
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'Password must be 7 characters long';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 20,
                ),
                if (widget.loader) CircularProgressIndicator(),
                if (!widget.loader)
                  RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(loginMode ? "Login" : 'SignUp'),
                    ),
                    onPressed: _trySubmit,
                  ),
                if (!widget.loader)
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        loginMode = !loginMode;
                      });
                    },
                    child: Text(loginMode
                        ? "Create a new account"
                        : 'I already have an account'),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
