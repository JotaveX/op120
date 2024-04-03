import 'dart:convert';

import 'package:flutter/material.dart';
// Remove the unused import directive
import 'package:http/http.dart' as http;

class CreateUserWidget extends StatefulWidget {
  String? get userId => null;

  @override
  _CreateUserWidgetState createState() => _CreateUserWidgetState();
}

class _CreateUserWidgetState extends State<CreateUserWidget> {
  String nome = '';
  String email = '';
  String senha = '';

  @override
  Widget build(BuildContext context) {
    var obscureText = true;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create User'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) {
                setState(() {
                  nome = value;
                });
              },
            ),
            SizedBox(height: 10), // Add some spacing
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            SizedBox(height: 10), // Add some spacing
            TextField(
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  senha = value;
                });
              },
              obscureText: obscureText,
            ),
            const SizedBox(height: 10), // Add some spacing
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink, // Set the text color
              ),
              onPressed: () async {
                // TODO: Implement logic to create user

                final response = await http
                    .post(
                      Uri.parse('http://localhost:4000/usuario'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'nome': nome,
                        'email': email,
                        'senha': senha,
                      }),
                    )
                    .then((value) => Navigator.pushNamed(context, '/user'));

                // if (response.statusCode == 200) {
                //   // If the server returns a 200 OK response,
                //   // then parse the JSON.
                //   print('User created successfully');
                // } else {
                //   // If the server did not return a 200 OK response,
                //   // then throw an exception.
                //   throw Exception('Failed to create user');
                // }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
