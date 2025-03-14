import 'package:flutter/material.dart';
import '/screens/shopping/components/body.dart';
import '/size_config.dart';
import '../CartScreen/cart_screen.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      foregroundColor: const Color.fromARGB(131, 87, 73, 119),
      backgroundColor: const Color.fromARGB(255, 248, 177, 96).withOpacity(0.2),
      actions: <Widget>[
        Center(
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart
                    // height: SizeConfig.defaultSize * 4, //20
                    ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CartScreen();
                      },
                    ),
                  );
                },
              ),
              ///////////////////////////////////////////
              // Padding(
              //     padding: const EdgeInsets.only(right: 10),
              //     child: Consumer<Cart>(
              //       builder: (context, cart, child) {
              //         return Text(
              //           "${cart.totalprice}",
              //           style: TextStyle(
              //               color: Colors.red, fontWeight: FontWeight.bold),
              //         );
              //       },
              //     ))
            ],
          ),
        ),
        SizedBox(width: SizeConfig.defaultSize),
      ],
    );
  }
}
