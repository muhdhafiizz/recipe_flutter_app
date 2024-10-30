import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/data_repo/db_helper.dart';
import 'package:recipe_flutter_app/models/recipe_model.dart';
import 'package:recipe_flutter_app/ui/home_page/home_page.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _emailSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailSubject.stream.transform(_validateEmail);
  Stream<String> get passwordStream => _passwordSubject.stream.transform(_validatePassword);

  final _validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.contains('@') && email.contains('.')) {
        sink.add(email);
      } else {
        sink.addError('Enter a valid email');
      }
    },
  );

    final _validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length >= 6) {
        sink.add(password);
      } else {
        sink.addError('Password must be at least 6 characters');
      }
      },
    );  

  void updateEmail(String email) {
    _emailSubject.add(email);
  }

  void updatePassword(String password) {
    _passwordSubject.add(password);
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _emailSubject.close();
    _passwordSubject.close();
  }

  Future<void> login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        List<RecipeModel> recipes = await DbHelper.dbHelper.getAllRecipes();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void toggleObscureText() {
    obscureText = !obscureText;
  }
}
