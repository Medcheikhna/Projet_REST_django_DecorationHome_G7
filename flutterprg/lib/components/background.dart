import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Background extends StatelessWidget {
  final Widget? child;
  const Background({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(131, 87, 73, 119),
        backgroundColor: const Color.fromARGB(255, 243, 130, 1).withOpacity(0.1),
        // backgroundColor: Color.fromARGB(255, 248, 177, 96).withOpacity(0.2),
      ),
      resizeToAvoidBottomInset: false,
      // body: Container(
      //   color: Color.fromARGB(255, 248, 177, 96).withOpacity(0.2),
      //   width: double.infinity,
      //   height: MediaQuery.of(context).size.height,
      //   child: Stack(
      //     alignment: Alignment.center,
      //     children: <Widget>[
      //       SafeArea(child: child),
      //     ],
      //   ),
      // ),
      body: Container(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.1, 0.4, 0.7, 0.9],
                colors: [
                  const Color.fromARGB(255, 243, 130, 1).withOpacity(0.1),
                  const Color.fromARGB(255, 172, 102, 10).withOpacity(0.2),
                  const Color.fromARGB(255, 160, 91, 2).withOpacity(0.4),
                  const Color.fromARGB(82, 209, 119, 1).withOpacity(0.5),
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SafeArea(child: child!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
