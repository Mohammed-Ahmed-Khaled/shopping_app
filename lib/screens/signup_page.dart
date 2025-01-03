import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/text_widget.dart';
import 'package:shopping_app/widgets/text_formfield.dart';
import 'package:shopping_app/screens/shopping_homepage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

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
          title: const Text("Success"),
          content: const Text("Account created successfully"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ShoppingHomePage()),
                );
              },
              child: const Text("Close"),
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
        title: const TextWidget(
          text: 'Sign Up',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormFieldWidget(
                labelText: "Full Name",
                controller: _fullNameController,
                validator: _validateFullName,
                prefixIcon: Icons.person,
              ),
              TextFormFieldWidget(
                labelText: "Email",
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: _validateEmail,
                prefixIcon: Icons.email,
              ),
              TextFormFieldWidget(
                obscureText: _passwordVisible,
                labelText: "Password",
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
                obscureText: _passwordVisible,
                labelText: "Confirm Password",
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
                child: const Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
