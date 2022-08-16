import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/pickers/user_image_picker.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  final void Function({
    String email,
    String password,
    String username,
    bool isLogin,
    File userImage,
    BuildContext ctx,
  }) submitFun;
  //final Function submitFun;
  final bool isLoading;
  AuthForm(
    this.submitFun,
    this.isLoading,
  );

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = "";
  String _userName = "";
  String _userPassword = "";
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    //trigger all the validator in the text form fields
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus(); //close the keyboard

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Please add an image"),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid) {
      //if all validator return null
      _formKey.currentState
          .save(); //trigger all the onSaved in the text form fields
      widget.submitFun(
        email: _userEmail.trim(), //trim remove any space
        password: _userPassword,
        username: _userName,
        isLogin: _isLogin,
        userImage: _userImageFile,
        ctx: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // to make sure the column only take hight as much as needed
                children: [
                  if (!_isLogin) UserImagePicker(_pickedImage),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    key: ValueKey("email"),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    decoration: InputDecoration(labelText: "Email address"),
                    validator: (value) {
                      if (value.isEmpty || !value.contains("@")) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey("username"),
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      onSaved: (value) {
                        _userName = value;
                      },
                      validator: (value) {
                        if (value.isEmpty || value.length < 5) {
                          return "Please enter at least 4 charactres.";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Username"),
                    ),
                  TextFormField(
                    key: ValueKey("password"),
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    validator: (value) {
                      if (value.isEmpty || value.length < 8) {
                        return "Password must be at least 8 characters long.";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text(_isLogin ? "Login" : "Signup"),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          //update UI
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? "Create new account"
                          : "I already have an account"),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
