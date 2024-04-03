import 'dart:convert';

import 'package:flutter/material.dart';
// Remove the unused import directive
import 'package:faculdade/src/models/usuario.model.dart';
import 'package:http/http.dart' as http;

class EditUserWidget extends StatefulWidget {
  int userId;

  EditUserWidget({super.key, required this.userId});

  @override
  _EditUserWidgetState createState() => _EditUserWidgetState();
}

class _EditUserWidgetState extends State<EditUserWidget> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future fetchUser() async {
    final response = await http
        .get(Uri.parse('http://localhost:4000/usuario/${widget.userId}'));

    if (response.statusCode == 200) {
      final user = jsonDecode(response.body)[0];
      print(user);
      setState(() {
        nomeController.text = user['nome'].toString();
        emailController.text = user['email'].toString();
        senhaController.text = user['senha'].toString();
      });
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isPasswordVisible = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            SizedBox(height: 10), // Add some spacing
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            SizedBox(height: 10), // Add some spacing
            TextField(
              controller: senhaController,
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final response = await http
                    .put(
                      Uri.parse(
                          'http://localhost:4000/usuario/${widget.userId}'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'nome': nomeController.text,
                        'email': emailController.text,
                        'senha': senhaController.text,
                      }),
                    )
                    .then((value) => Navigator.pop(context));
              },
              child: const Text('Edit'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     showDialog(
            //       context: context,
            //       builder: (BuildContext context) {
            //         return AlertDialog(
            //           title: const Text('Delete User'),
            //           content: const Text('Are you sure you want to delete?'),
            //           actions: [
            //             TextButton(
            //               onPressed: () async {
            //                 print(
            //                     'http://localhost:4000/usuario/${widget.userId}');
            //                 final response = await http.delete(
            //                   Uri.parse(
            //                       'http://localhost:4000/usuario/${widget.userId}'),
            //                 );
            //                 if (response.statusCode == 200) {
            //                   Navigator.pop(context);
            //                   Navigator.pop(context);
            //                 } else {
            //                   throw Exception('Failed to delete user');
            //                 }
            //               },
            //               child: const Text('Delete'),
            //             ),
            //             TextButton(
            //               onPressed: () {
            //                 Navigator.pop(context);
            //               },
            //               child: const Text('Cancel'),
            //             ),
            //           ],
            //         );
            //       },
            //     );
            //   },
            //   child: const Text('Delete'),
            // ),
          ],
        ),
      ),
    );
  }
}

// class _EditUserWidgetState extends State<EditUserWidget> {
//   TextEditingController nomeController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController senhaController = TextEditingController();

//   Future fetchUser() async {
//     final response = await http
//         .get(Uri.parse('http://localhost:4000/usuario/${widget.userId}'));

//     if (response.statusCode == 200) {]
//       final user = jsonDecode(response.body);
//       setState(() {
//         nomeController.text = user['nome'];
//         emailController.text = user['email'];
//         senhaController.text = user['senha'];
        
//       });
//     } else {
//       throw Exception('Failed to load user');
//     }
//   }

//   String nome = '';
//   String email = '';
//   String senha = '';

//   @override
//   void initState() {
//     super.initState();
//     fetchUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit User'),
//         backgroundColor: Colors.pink,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               decoration: const InputDecoration(
//                 labelText: 'Nome',
//                 border: OutlineInputBorder(),
//                 contentPadding: EdgeInsets.all(10),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   nome = value;
//                 });
//               },
//             ),
//             SizedBox(height: 10), // Add some spacing
//             TextField(
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//                 contentPadding: EdgeInsets.all(10),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   email = value;
//                 });
//               },
//             ),
//             SizedBox(height: 10), // Add some spacing
//             TextField(
//               decoration: const InputDecoration(
//                 labelText: 'Senha',
//                 border: OutlineInputBorder(),
//                 contentPadding: EdgeInsets.all(10),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   senha = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 10), // Add some spacing
//             ElevatedButton(
//               onPressed: () async {
//                 final user = User(nome, email, senha);
//                 // TODO: Implement logic to create user
//                 final response = await http
//                     .put(
//                       Uri.parse(
//                           'http://localhost:4000/usuario/${widget.userId}'),
//                       headers: <String, String>{
//                         'Content-Type': 'application/json; charset=UTF-8',
//                       },
//                       body: jsonEncode(<String, String>{
//                         'nome': nome,
//                         'email': email,
//                         'senha': senha,
//                       }),
//                     )
//                     .then((value) => Navigator.pop(context));

//                 // if (response.statusCode == 200) {
//                 //   // If the server returns a 200 OK response,
//                 //   // then parse the JSON.
//                 //   print('User edited successfully');
//                 // } else {
//                 //   // If the server did not return a 200 OK response,
//                 //   // then throw an exception.
//                 //   throw Exception('Failed to edit user');
//                 // }
//               },
//               child: const Text('Edit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
