import 'package:flutter/material.dart';
import 'package:shopping_app/animation/fade.dart';
import 'package:shopping_app/generated/l10n.dart';
import 'package:shopping_app/screens/shopping_homepage.dart';
import 'package:shopping_app/widgets/text_formfield.dart';
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(S.of(context).success),
          content: Text(S.of(context).accountCreated),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.pushReplacement(
                  context,
                  AnimatedPageTransition(
                    page:
                        ShoppingHomePage(togglelanguage: widget.toggleLanguage),
                  ),
                );
              },
              child: Text(S.of(context).close),
            ),
          ],
        ),
      );
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
              TextFormFieldWidget(
                labelText: S.of(context).email,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: _validateEmail,
                prefixIcon: Icons.email,
              ),
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
                onPressed: _submitForm,
                child: Text(S.of(context).signUp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
