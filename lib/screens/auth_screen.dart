import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _submitAuthForm(
      {String email,
      String username,
      String password,
      File userImage,
      bool isLogin,
      BuildContext ctx}) async {
    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
      final ref = FirebaseStorage.instance
          .ref()
          .child("user_image")
          .child(userCredential.user.uid + ".jpg");

      var url;
      await ref.putFile(userImage).whenComplete(() async {
        print("image uploaded successfully");
        url = await ref.getDownloadURL();
      });
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user.uid)
          .set({
        "username": username,
        "email": email,
        "image_url": url,
      });

      //platform exception is firebase exception
    } on PlatformException catch (error) {
      print("oh no, an error occurred");
      var message = "Please check your credentials!";
      if (error.message != null) {
        message = error.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print("oh no, an error occurred");
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
