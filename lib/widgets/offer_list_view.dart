import 'package:flutter/material.dart';
import 'package:shopping_app/data/data.dart';
import 'package:shopping_app/widgets/offer_card.dart';

class OfferListView extends StatelessWidget {
  const OfferListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: offers.length,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: OfferCard(
              offer: offers[index],
            ),
          );
        },
      ),
    );
  }
}
