import 'package:flutter/material.dart';
import '/components/background.dart';

import '../../../size_config.dart';
import 'Shop.dart';
import 'ajouterProduit.dart';
import 'discount_banner.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const DiscountBanner(),
              SizedBox(height: getProportionateScreenWidth(30)),
              AjouterProduit(),
              SizedBox(height: getProportionateScreenWidth(30)),
              const Shop(),
              SizedBox(height: getProportionateScreenWidth(30)),
              const SpecialOffers(),
            ],
          ),
        ),
      ),
    );
  }
}
