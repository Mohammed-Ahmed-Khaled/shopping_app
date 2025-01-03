import 'package:flutter/material.dart';
import 'package:shopping_app/models/offer_model.dart';
import 'package:shopping_app/widgets/snakbar_widget.dart';
import 'package:shopping_app/generated/l10n.dart';

class OfferCard extends StatefulWidget {
  final OfferModel offer;

  const OfferCard({
    super.key,
    required this.offer,
  });

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                widget.offer.image,
                fit: BoxFit.fitWidth,
              ),
            ),
            Text(
              widget.offer.title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("\$ ${widget.offer.priceAfterDiscount}"),
            const SizedBox(height: 10),
            IconButton(
              onPressed: () {
                CustomSnackBar.show(context, S.of(context).addedToCart);
              },
              icon: widget.offer.icon,
            ),
          ],
        ),
      ),
    );
  }
}
