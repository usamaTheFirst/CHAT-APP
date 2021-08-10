import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_chat_app/Widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool loader = false;
  final _auth = FirebaseAuth.instance;
  Future<void> _submitAuthForm(
      {String email,
      String password,
      String username,
      File image,
      bool isLoginMode}) async {
    UserCredential _credential;
    try {
      setState(() {
        loader = true;
      });
      if (isLoginMode) {
        _credential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        _credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(_credential.user.uid + '.jpg');

        await ref
            .putFile(
              image,
            )
            .whenComplete(() => null);
        final url = await ref.getDownloadURL();

        await _credential.user.updateDisplayName(username);

        await _credential.user.updatePhotoURL(url);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_credential.user.uid)
            .set({'username': username, "email": email, 'image_url': url});
      }
    } catch (error) {
      var message = 'An error occurred please check your credentials';
      // print(message);
      if (error.message != null) {
        message = error.message.toString();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$message'),
          backgroundColor: Theme.of(context).errorColor,
        ));
        setState(() {
          loader = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        submitAuthForm: _submitAuthForm,
        loader: loader,
      ),
    );
  }
}
