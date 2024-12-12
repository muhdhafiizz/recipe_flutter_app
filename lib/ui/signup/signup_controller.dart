import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/ui/login/login_page.dart';

class SignupController extends ChangeNotifier{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void toggleObscureText() {
    obscureText = !obscureText;
  }

  String? emailError;
  String? nameError;
  String? passwordError;

  void signUpEmail(String email) {
    if (email.contains('@') && email.contains('.')) {
      emailError = null;
    } else {
      emailError = 'Enter a valid email';
    }
    notifyListeners();
  }

  void signUpName (String name) {
    if (name.isNotEmpty) {
      emailError = null;
    } else {
      emailError = 'Enter your name';
    }
    notifyListeners();
  }

  void signUpPassword(String password) {
    if (password.length >= 6) {
      passwordError = null;
    } else {
      passwordError = 'Password must be at least 6 characters';
    }
    notifyListeners();
  }

  Future<void> signUp(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty || nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please insert your email and password to sign up'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await userCredential.user?.updateDisplayName(nameController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User successfully created!'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
    }
  }
}
