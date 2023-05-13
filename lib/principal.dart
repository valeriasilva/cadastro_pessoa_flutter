import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
final controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: TextField(controller: controller),
        actions: [
          IconButton(
            onPressed: (){
              final name = controller.text;
              createUser(name: name);
            },
            icon: Icon(Icons.add))
        ],
      )
    );
    
      Future createUser({required String name}) async {
      final docUser = FirebaseFirestore.instance.collection('pessoa').doc();

      final user = User(
        id : docUser.id,
        name: name,
        sobrenome: "Martins da Silva",
      );

      final json = user.toJson();
      //Cria um documento e escreve os dados no banco de dados Firebase
      await docUser.set(json);
    }
}

class User {
  String id;
  final String name;
  final String sobrenome;

  User({
    this.id = '',
    required this.name,
    required this.sobrenome,
  });
  
  Map<String, dynamic> toJson()=> {
    'id' : id,
    'name': name,
    'sobrenome': sobrenome,
  };
}