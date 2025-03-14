import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterprg/screens/home/components/body.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/Categories.dart';
import '../../../size_config.dart';
import '../../admin_showProduct/adminShowProduct.dart';
import '../home_screen.dart';
import 'AjouterProduitPage.dart';
import 'package:http/http.dart' as http;
import 'section_title.dart';
import 'dart:convert' as convert;

class AjouterProduit extends StatefulWidget {
  const AjouterProduit({super.key});

  @override
  _AjouterProduitState createState() => _AjouterProduitState();
}

class _AjouterProduitState extends State<AjouterProduit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();
  String imagePath = "";
  String filename = "";
  final String _selectedCategoryId = '';
  final List<Category> _categories = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchCategories();
  // }

  // Future<void> _fetchCategories() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String action = prefs.getString("Authorization");
  //   final url = Uri.parse('http://192.168.56.1:8000/categories/');
  //   final response = await http.get(url, headers: {
  //     "Authorization": 'Token $action',
  //   });

  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = convert.jsonDecode(response.body);
  //     final categories =
  //         data.map((category) => Category.fromJson(category)).toList();
  //     setState(() {
  //       _categories = categories;
  //     });
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Error'),
  //           content: Text('Failed to fetch categories.'),
  //           actions: [
  //             TextButton(
  //               child: Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  Future _addProduct() async {
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString("Authorization");
    var dio = Dio();
    dio.options.headers["authorization"] = 'token $action';

    FormData data = FormData.fromMap({
      'image_url': await MultipartFile.fromFile(imagePath),
      'name': _nameController.text,
      'description': _descriptionController.text,
      'price': _priceController.text,
      'category': _selectedCategoryId
    });

    var response =
        await dio.post('http://192.168.56.1:8000/products/create/', data: data);

    print(response.statusCode);
    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Product added successfully.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pop(); // Go back to the previous page (ProductsScreen)
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Body()),
                  );
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to add product.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: const SectionTitle(
            title: "Add your Product",
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        const Icon(Icons.add_sharp),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(144, 190, 115, 30), elevation: 0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AjouterProduitPage(),
              ),
            );
          },
          child: const Text(
            'Add Product',
            style: TextStyle(
              color: Color.fromARGB(175, 255, 255, 255),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
