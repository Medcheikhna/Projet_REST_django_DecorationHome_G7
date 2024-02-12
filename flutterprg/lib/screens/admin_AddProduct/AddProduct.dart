import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '/components/background.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:dio/dio.dart';
import '../../models/Categories.dart';
import '../admin_showProduct/adminShowProduct.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();
  String imagePath = "";
  String filename = "";
  int _selectedCategoryId = 16;
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    // _selectedCategoryId = '';
  }

  Future<void> _fetchCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString("Authorization");
    final url = Uri.parse('http://192.168.56.1:8000/categories/');
    final response = await http.get(url, headers: {
      "Authorization": 'Token $action',
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = convert.jsonDecode(response.body);
      final categories =
          data.map((category) => Category.fromJson(category)).toList();
      setState(() {
        _categories = categories;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch categories.'),
            actions: [
              TextButton(
                child: Text('OK'),
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

  Future<void> _addProduct() async {
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString("Authorization");
    var dio = Dio();
    dio.options.headers["authorization"] = 'token ${action}';

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
            title: Text('Success'),
            content: Text('Product added successfully.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pop(); // Go back to the previous page (ProductsScreen)
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ProductsScreen()),
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
            title: Text('Error'),
            content: Text('Failed to add product.'),
            actions: [
              TextButton(
                child: Text('OK'),
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
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    FilePickerResult result =
                        await FilePicker.platform.pickFiles();

                    File file = File(result.files.single.path ?? " ");

                    setState(() {
                      imagePath = file.path;
                      filename = file.path.split('/').last;
                    });
                  },
                  child: Text('Upload Image'),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButton<String>(
                  value: _selectedCategoryId.toString(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategoryId = int.parse(newValue!);
                      // print(_selectedCategoryId);
                      // _categories.forEach((category) {
                      //   print("Category ID: ${category.id}");
                      // });
                    });
                  },
                  items: _categories.isEmpty
                      ? []
                      : _categories
                          .map<DropdownMenuItem<String>>((Category category) {
                          return DropdownMenuItem<String>(
                            value: category.id.toString(),
                            child: Text(category.name),
                          );
                        }).toList(),
                  hint: Text('Sélectionnez une catégorie'),
                ),
                SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  onPressed: _addProduct,
                  child: Text(
                    'Add Product',
                    style: TextStyle(
                        color: Color.fromARGB(175, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
