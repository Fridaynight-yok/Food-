import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddFoodScreen extends StatefulWidget {
  final CollectionReference<Map<String, dynamic>> foods;
  const AddFoodScreen({super.key, required this.foods});

  @override
  State<AddFoodScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddFoodScreen> {
  final chefController = TextEditingController();
  final menuController = TextEditingController();
  final ingredientsController = TextEditingController();
  final imageController = TextEditingController();

  Future<void> addUser() async {
    final String chef = chefController.text;
    final String menu = menuController.text;
    final String ingredients = ingredientsController.text;
    final String image = imageController.text;

    if (chef.isNotEmpty &&
        menu.isNotEmpty &&
        ingredients.isNotEmpty &&
        image.isNotEmpty) {
      chefController.clear();
      menuController.clear();
      ingredientsController.clear();
      imageController.clear();

      // เพิ่มข้อมูล
      await widget.foods.add({
        'chef': {"name": chef},
        'menu_name': menu,
        'ingredients': ingredients,
        'image_url': image,
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เพิ่มรายการอาหาร')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: chefController,
              decoration: InputDecoration(labelText: 'ชื่อ - เชฟ'),
            ),
            TextField(
              controller: menuController,
              decoration: InputDecoration(labelText: 'เมนู'),
            ),
            TextField(
              controller: ingredientsController,
              decoration: InputDecoration(labelText: 'ส่วนประกอบ'),
            ),
            TextField(
              controller: imageController,
              decoration: InputDecoration(labelText: 'รูป'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: addUser, child: Text('เพิ่มผู้ใช้')),
          ],
        ),
      ),
    );
  }
}
