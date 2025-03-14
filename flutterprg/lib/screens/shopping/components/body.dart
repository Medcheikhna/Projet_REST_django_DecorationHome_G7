import 'package:flutter/material.dart';
import '/services/fetchCategories.dart';
import '/services/fetchProducts.dart';
import '/size_config.dart';
import 'categories.dart';
import 'recommond_products.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    double? defaultSize = SizeConfig.defaultSize;

    // It enables scrolling
    return Container(
      color: const Color.fromARGB(255, 248, 177, 96).withOpacity(0.2),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(defaultSize! * 2), //20
                child: const Text(
                  "Product Categories",
                ),
              ),
              FutureBuilder(
                future: fetchCategories(),
                builder: (context, snapshot) => snapshot.hasData
                    ? Categories(categories: snapshot.data)
                    : Center(child: Image.asset("assets/ripple.gif")),
              ),
              const Divider(height: 5),
              Padding(
                padding: EdgeInsets.all(defaultSize* 2), //20
                child: const Text("Products"),
              ),
              // Right Now product is our demo product
              FutureBuilder(
                future: fetchProducts(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? RecommandProducts(products: snapshot.data)
                      : Center(child: Image.asset('assets/ripple.gif'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
