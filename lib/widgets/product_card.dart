import 'package:flutter/material.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/widgets/snakbar_widget.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                widget.product.image,
                fit: BoxFit.fitWidth,
              ),
            ),
            Text(
              widget.product.title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("\$ ${widget.product.price}"),
            const SizedBox(height: 10),
            IconButton(
              onPressed: () {
                CustomSnackBar.show(context, "Item added to the cart");
              },
              icon: widget.product.icon,
            ),
          ],
        ),
      ),
    );
  }
}
