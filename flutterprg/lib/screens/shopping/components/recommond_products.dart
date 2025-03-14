import 'package:flutter/material.dart';
import '/screens/details_product/details_screen.dart';
import '../../../models/Product.dart';
import '../../../size_config.dart';
import 'product_card.dart';

class RecommandProducts extends StatelessWidget {
  const RecommandProducts({
    Key? key,
    this.products,
  }) : super(key: key);
  final List<Product>? products;

  @override
  Widget build(BuildContext context) {
    double? defaultSize = SizeConfig.defaultSize;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(defaultSize! * 2), //20
        child: GridView.builder(
          // We just turn off grid view scrolling
          shrinkWrap: true, //.Take the height of the widget inside it
          physics: const NeverScrollableScrollPhysics(),
          // just for demo
          itemCount: products!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                SizeConfig.orientation == Orientation.portrait ? 2 : 4,
            mainAxisSpacing: 20, //.vertical
            crossAxisSpacing: 20, //.horizental
            childAspectRatio: 0.693,
          ),
          itemBuilder: (context, index) => ProductCard(
              product: products![index],
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        product: products![index],
                      ),
                    ));
              }),
        ),
      ),
    );
  }
}
