import 'package:flutter/material.dart';
import '/screens/profile2/profile_screen.dart';
import '/size_config.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../screens/CartScreen/cart_screen.dart';
import '../screens/home/home_screen.dart';

class BottomAppBar1 extends StatefulWidget {
  const BottomAppBar1({Key? key}) : super(key: key);

  @override
  State<BottomAppBar1> createState() => _BottomAppBar1State();
}

class _BottomAppBar1State extends State<BottomAppBar1> {
  int _state = 0;
  final List<Widget> _tabs = <Widget>[
    HomeScreen(),
    const ProfileScreen(),
    CartScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(122, 248, 177, 96).withOpacity(0.2),
        backgroundColor: const Color.fromARGB(255, 248, 177, 96).withOpacity(0.2),
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 214, 130, 21).withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: GNav(
            gap: 8,
            selectedIndex: _state,
            padding: const EdgeInsets.all(16),
            tabBackgroundColor: const Color.fromARGB(68, 57, 54, 107),
            color: const Color.fromARGB(255, 128, 77, 0),
            activeColor: const Color.fromARGB(255, 255, 255, 255),
            onTabChange: (index) {
              setState(() {
                _state = index;
              });
            },
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.person, text: 'profile'),
              GButton(icon: Icons.shopping_cart, text: 'Cart'),
            ],
          ),
        ),
      ),
      body: _tabs.elementAt(_state),
    );
  }
}
