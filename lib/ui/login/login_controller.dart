import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/ui/home_page/home_page.dart';

class LoginController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? emailError;
  String? passwordError;

  void updateEmail(String email) {
    if (email.contains('@') && email.contains('.')) {
      emailError = null;
    } else {
      emailError = 'Enter a valid email';
    }
    notifyListeners();
  }

  void updatePassword(String password) {
    if (password.length >= 6) {
      passwordError = null;
    } else {
      passwordError = 'Password must be at least 6 characters';
    }
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // List<RecipeModel> recipes = await DbHelper.dbHelper.getAllRecipes();

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
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
