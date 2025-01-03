import 'package:flutter/material.dart';
import 'package:shopping_app/data/data.dart';

class ProductPageView extends StatelessWidget {
  const ProductPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: PageView.builder(
        itemCount: products.length,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(products[index].image),
          );
        },
      ),
    );
  }
}
