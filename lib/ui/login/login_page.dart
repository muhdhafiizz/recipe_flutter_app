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
          color: Colors.brown,
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
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Recipe App',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
                                'to experience the best recipe app ever.',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.visible,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: loginController.emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  errorText: loginController.emailError,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
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
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      loginController.obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed:
                                        loginController.toggleObscureText,
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
                                  onPressed: () =>
                                      loginController.login(context),
                                ),
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupPage()),
                                  );
                                },
                                child: const Text(
                                  'Join us if you have not yet!',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
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
