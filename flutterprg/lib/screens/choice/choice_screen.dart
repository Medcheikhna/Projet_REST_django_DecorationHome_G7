import 'package:flutter/material.dart';
import '/components/bottomAppBar.dart';
import '/screens/choice/components/body.dart';
import '/size_config.dart';

class choiceScreen extends StatelessWidget {
  const choiceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
      bottomNavigationBar: BottomAppBar1(),
    );
  }
}
