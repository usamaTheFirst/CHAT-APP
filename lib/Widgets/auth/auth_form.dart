import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  String email = '';
  String password = '';
  String userName = '';
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  _trySubmit() {
    final isValid = _form.currentState.validate();
    if (isValid) {
      _form.currentState.save();

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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Form(
              key: _form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
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
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
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
                    obscureText: true,
                    decoration: InputDecoration(
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
                    height: 20,
                  ),
                  RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text("Login"),
                    ),
                    onPressed: _trySubmit,
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {},
                    child: Text("Create a new account"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
