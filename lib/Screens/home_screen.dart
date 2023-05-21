
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users= [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API CALL'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount:users.length,
          itemBuilder: (context, index){
            final user  =users[index];
            final email = user.phone;
            return ListTile(
                  title: Text(email),
            );

          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:fetechUsers,
      ),
    );
  }
  void fetechUsers()async{
    print('user is called');
    const url = 'https://randomuser.me/api/?results=5000';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final transformed = results.map((e) {
      return User(
          gender: e['gender'],
          email: e['email'],
          phone:  e['phone'],
          cell:  e['cell'],
          nat:  e['nat'],
      );
    }).toList();
    setState(() {
      users = transformed;
    });
    //print('$users');
  }

}