import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/presentation/view/home_view.dart';
import '../view_model/login/login_bloc.dart';
import 'register_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'sujinasht@gmail.com');
  final _passwordController = TextEditingController(text: 'sujina123');

  final _gap = const SizedBox(height: 8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/bnw.png', // Make sure the PNG is inside the assets folder
                              height: 180.0,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'The Beauty Aesthetics', //
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 52, 62), //
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Let's login to continue your beauty journey.",
                              style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              key: const ValueKey('email'),
                              controller: _emailController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              key: const ValueKey('password'),
                              controller: _passwordController,
                              obscureText: !state.isPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    state.isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    context
                                        .read<LoginBloc>()
                                        .add(TogglePasswordVisibilityEvent());
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    _gap,
                    _gap,
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();

                          context.read<LoginBloc>().add(
                                LoginUserEvent(
                                  email: email,
                                  password: password,
                                  context: context,
                                  destination: HomeView(),
                                ),
                              );
                        }
                      },
                      child: const SizedBox(
                        height: 50,
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Brand Bold',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // Center the content
                      children: [
                        const Text('Don’t have an account?'),
                        TextButton(
                          key: const ValueKey('registerButton'),
                          onPressed: () {
                            context.read<LoginBloc>().add(
                                  NavigateRegisterScreenEvent(
                                    destination: RegisterView(),
                                    context: context,
                                  ),
                                );
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Brand Bold',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
