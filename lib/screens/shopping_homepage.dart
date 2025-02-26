import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/animation/fade.dart';
import 'package:shopping_app/screens/login_page.dart';
import 'package:shopping_app/screens/profile_page.dart';
import 'package:shopping_app/widgets/text_widget.dart';
import 'package:shopping_app/widgets/product_page_view.dart';
import 'package:shopping_app/widgets/products_grid_view.dart';
import 'package:shopping_app/widgets/offers_list_view.dart';
import 'package:shopping_app/generated/l10n.dart';

class ShoppingHomePage extends StatelessWidget {
  const ShoppingHomePage({
    super.key,
    required this.toggleLanguage,
  });

  final VoidCallback toggleLanguage;

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          AnimatedPageTransition(
            page: LoginPage(toggleLanguage: toggleLanguage),
          ),
        );
      });
      return const SizedBox.shrink();
    }
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: S.of(context).appTitle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: toggleLanguage,
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.push(
              context,
              AnimatedPageTransition(
                page: ProfilePage(
                  uid: currentUser.uid,
                  toggleLanguage: toggleLanguage,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                AnimatedPageTransition(
                  page: LoginPage(
                    toggleLanguage: toggleLanguage,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(text: S.of(context).ourProducts),
              SizedBox(height: 10),
              ProductPageView(),
              SizedBox(height: 10),
              ProductGridView(),
              SizedBox(height: 10),
              TextWidget(text: S.of(context).hotOffers),
              SizedBox(height: 10),
              OfferListView(),
            ],
          ),
        ),
      ),
    );
  }
}
