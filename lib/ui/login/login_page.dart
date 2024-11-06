import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_flutter_app/ui/signup/signup_page.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginController(),
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Consumer<LoginController>(
              builder: (context, loginController, _) {
                return Form(
                  key: loginController.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.restaurant_menu,
                            color: Colors.brown,
                            size: 30,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Recipe App',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      TextFormField(
                        controller: loginController.emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          errorText: loginController.emailError,
                        ),
                        onChanged: loginController.updateEmail,
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: loginController.passwordController,
                        obscureText: loginController.obscureText,
                        onChanged: loginController.updatePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          errorText: loginController.passwordError,
                          suffixIcon: IconButton(
                            icon: Icon(
                              loginController.obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: loginController.toggleObscureText,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.login),
                          label: const Text('Log In'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () => loginController.login(context),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupPage()),
                          );
                        },
                        child: const Text(
                          'Create a new account',
                          style: TextStyle(
                            color: Colors.brown,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
