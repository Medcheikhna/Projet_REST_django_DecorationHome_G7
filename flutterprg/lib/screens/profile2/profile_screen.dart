import 'dart:convert';
import 'package:flutter/material.dart';
import '/components/background.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Login/login_screen.dart';
import '../editProfile/editProfilr_screen.dart';
import '../my_order/My_Order.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 270,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10), //10
                      height: 140, //140
                      width: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color.fromARGB(78, 160, 109, 0),
                          width: 2, //8
                        ),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/profile.png"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FutureBuilder<Data>(
                            future: fetchData(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!.username,
                                  // style: kCaptionTextStyle
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 156, 89, 1),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }

                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                          FutureBuilder<Data>(
                            future: fetchData(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!.email,
                                  // style: kCaptionTextStyle
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 156, 89, 1),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }

                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  Icons.shopping_cart,
                  color: Color.fromARGB(255, 160, 91, 0),
                ),
                title: const Text(
                  'My Orders',
                  style: TextStyle(
                    color: Color.fromARGB(209, 138, 78, 0),
                  ),
                
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return OrderListPage();
                        // return null;
                      },
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 160, 91, 0),
                ),
                title: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Color.fromARGB(209, 138, 78, 0),
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditProfilePage();
                      },
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Color.fromARGB(255, 160, 91, 0),
                ),
                title: const Text(
                  'Log Out',
                  style: TextStyle(
                    color: Color.fromARGB(209, 138, 78, 0),
                  ),
                ),
                onTap: () async {
                  logout();

                  // Log out logic
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String action = prefs.getString("Authorization");
      Response respone = await get(
        Uri.parse('http://192.168.56.1:8000/api/logout/'),
        headers: {
        "Authorization": 'Token $action',
      }
      );

      if (respone.statusCode == 200) {
        prefs.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()),
                      (Route<dynamic> route) => false);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}


Future<Data> fetchData() async {
  final prefs = await SharedPreferences.getInstance();
  final String action = prefs.getString("Authorization");
  final response = await get(
      Uri.parse('http://192.168.56.1:8000/get-profile/'),
      headers: {
        "Authorization": 'Token $action',
      });
  if (response.statusCode == 200) {
    Data res = Data.fromJson(jsonDecode(response.body));
    return res;
  } else {
    throw Exception('Failed to load Data');
  }
}

class Data {
  // final String first_name;
  // final String lastt_name;
  String username;
  String email;
  String password;
  // final String phone_number;

    Data({
    // this.first_name,
    // this.lastt_name,
 required   this.username,
  required  this.email,
   required this.password,
    // this.phone_number,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      // first_name: json["first_name"] as String,
      // lastt_name: json["lastt_name"] as String,
      email: json["email"] as String,
      username: json["username"] as String,
      password: json["password"] as String,
      // phone_number: json["phone_number"] as String,
    );
  }
}





