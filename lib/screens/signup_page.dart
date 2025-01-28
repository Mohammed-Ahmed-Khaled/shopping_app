import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/animation/fade.dart';
import 'package:shopping_app/generated/l10n.dart';
import 'package:shopping_app/screens/login_page.dart';
import 'package:shopping_app/screens/shopping_homepage.dart';
import 'package:shopping_app/widgets/snakbar_widget.dart';
import 'package:shopping_app/widgets/text_form_field.dart';
import 'package:shopping_app/widgets/text_widget.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback toggleLanguage;
  const SignUpPage({
    super.key,
    required this.toggleLanguage,
  });

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _passwordVisible = true;

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty || !RegExp(r'^[A-Z]').hasMatch(value)) {
      return "Full name must start with a capital letter";
    }
    return null;
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

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        CustomSnackBar.show(
          context,
          S.of(context).accountCreated,
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
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: S.of(context).signUp,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: widget.toggleLanguage, // Toggle between languages
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormFieldWidget(
                  labelText: S.of(context).fullName,
                  controller: _fullNameController,
                  validator: _validateFullName,
                  prefixIcon: Icons.person,
                ),
                SizedBox(height: 10),
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
                SizedBox(height: 10),
                TextFormFieldWidget(
                  labelText: S.of(context).confirmPassword,
                  obscureText: _passwordVisible,
                  controller: _confirmPasswordController,
                  validator: _validateConfirmPassword,
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
                  onPressed: _signUp,
                  child: Text(S.of(context).signUp),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.of(context).alreadyHaveAccount),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          AnimatedPageTransition(
                            page: LoginPage(
                              toggleLanguage: widget.toggleLanguage,
                            ),
                          ),
                        );
                      },
                      child: Text(S.of(context).login),
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
