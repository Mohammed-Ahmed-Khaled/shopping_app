import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/animation/fade.dart';
import 'package:shopping_app/generated/l10n.dart';
import 'package:shopping_app/screens/shopping_homepage.dart';
import 'package:shopping_app/screens/signup_page.dart';
import 'package:shopping_app/widgets/snakbar_widget.dart';
import 'package:shopping_app/widgets/text_form_field.dart';
import 'package:shopping_app/widgets/text_widget.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback toggleLanguage;

  const LoginPage({
    super.key,
    required this.toggleLanguage,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty || !value.contains('@')) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  void _logIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        Navigator.pushReplacement(
          context,
          AnimatedPageTransition(
            page: ShoppingHomePage(toggleLanguage: widget.toggleLanguage),
          ),
        );
      } catch (e) {
        CustomSnackBar.show(
          context,
          e.toString(),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: S.of(context).login,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: widget.toggleLanguage,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      TextFormFieldWidget(
                        labelText: S.of(context).email,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: _validateEmail,
                        prefixIcon: Icons.email,
                      ),
                      SizedBox(height: 10),
                      TextFormFieldWidget(
                        labelText: S.of(context).password,
                        obscureText: _passwordVisible,
                        controller: _passwordController,
                        validator: _validatePassword,
                        prefixIcon: Icons.lock,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: _passwordVisible
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(Icons.visibility_off_outlined),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _logIn,
                        child: Text(S.of(context).login),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(S.of(context).dontHaveAccount),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                AnimatedPageTransition(
                                  page: SignUpPage(
                                    toggleLanguage: widget.toggleLanguage,
                                  ),
                                ),
                              );
                            },
                            child: Text(S.of(context).signUp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
