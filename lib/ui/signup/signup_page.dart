import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_flutter_app/ui/signup/signup_controller.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
        ),
        body: const SignupForm(),
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final signupController = Provider.of<SignupController>(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Join Us',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                  
                ),
              ),
            ],
          ),
          const Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    'to ensure you dont miss out in keeping the best recipe.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                    overflow: TextOverflow.visible,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: signupController.nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              errorText: signupController.nameError,
            ),
            onChanged: (value) => signupController.signUpName(value),
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: signupController.emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              errorText: signupController.emailError,
            ),
            onChanged: (value) => signupController.signUpEmail(value),
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: signupController.passwordController,
            obscureText: signupController.obscureText,
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(
                  signupController.obscureText
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: signupController.toggleObscureText,
              ),
              errorText: signupController.passwordError,
            ),
            onChanged: (value) => signupController.signUpPassword(value),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.login),
              label: const Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () => signupController.signUp(context),
            ),
          ),
        ],
      ),
    );
  }
}
