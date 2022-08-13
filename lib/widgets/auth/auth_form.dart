import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = "";
  String _userName = "";
  String _userPassword = "";

  void _trySubmit() {
    //trigger all the validator in the text form fields
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus(); //close the keyboard
    if (isValid) {
      //if all validator return null
      _formKey.currentState
          .save(); //trigger all the onSaved in the text form fields
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
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
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
                  RaisedButton(
                    child: Text(_isLogin ? "Login" : "Signup"),
                    onPressed: _trySubmit,
                  ),
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
