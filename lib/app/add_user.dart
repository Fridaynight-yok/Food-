import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUserScreen extends StatefulWidget {
  final CollectionReference<Map<String, dynamic>> users;
  const AddUserScreen({super.key, required this.users});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final chefController = TextEditingController();
  final menuController = TextEditingController();
  final ingredientsController = TextEditingController();
  final imageController = TextEditingController();

  Future<void> addUser() async {
    final String chef = chefController.text;
    final String menu = menuController.text;
    final String ingredients = ingredientsController.text;
    final String image = imageController.text;

    if (chef.isNotEmpty && menu.isNotEmpty && ingredients.isNotEmpty) {
      chefController.clear();
      menuController.clear();
      ingredientsController.clear();
      imageController.clear();

      // เพิ่มข้อมูล
      await widget.users.add({
        'chef': chef,
        'menu': menu,
        'ingredients': ingredients,
        'image': image,
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
      appBar: AppBar(title: Text('เพิ่มผู้ใช้')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              maxLength: 20,
              controller: chefController,
              decoration: InputDecoration(labelText: 'เชฟ'),
            ),
            TextField(
              maxLength: 20,
              controller: menuController,
              decoration: InputDecoration(labelText: 'เมนู'),
              keyboardType: TextInputType.number, //keyborad will show as number
            ),
            TextField(
              maxLength: 100,
              controller: ingredientsController,
              decoration: InputDecoration(labelText: 'ส่วนประกอบ'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              maxLength: 60,
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
