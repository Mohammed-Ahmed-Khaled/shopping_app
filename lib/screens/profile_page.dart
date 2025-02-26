import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shopping_app/animation/fade.dart';
import 'package:shopping_app/generated/l10n.dart';
import 'package:shopping_app/models/user_model.dart';
import 'package:shopping_app/screens/login_page.dart';
import 'package:shopping_app/services/firestore.dart';
import 'package:shopping_app/widgets/text_widget.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback toggleLanguage;
  final String uid;

  const ProfilePage({
    super.key,
    required this.toggleLanguage,
    required this.uid,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserService _userService = UserService();
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticated = false;
  bool _authInProgress = true;

  Future<void> _authenticate() async {
    try {
      bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Please Authenticate to Access Your Profile',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticated = didAuthenticate;
        _authInProgress = false;
      });
    } catch (e) {
      setState(() {
        _authInProgress = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Biometric authentication failed. Please try again."),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    if (_authInProgress) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (!_isAuthenticated) {
      return Scaffold(
        body: Center(
          child: Text("Please Complete Biometric Authentication."),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: S.of(context).profile,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: widget.toggleLanguage,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                AnimatedPageTransition(
                  page: LoginPage(
                    toggleLanguage: widget.toggleLanguage,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<UserModel?>(
        future: _userService.getUser(widget.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No user data available.'));
          }
          final user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: user.image.startsWith('http')
                      ? NetworkImage(user.image)
                      : AssetImage(user.image) as ImageProvider,
                ),
                SizedBox(height: 20),
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  user.email,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
