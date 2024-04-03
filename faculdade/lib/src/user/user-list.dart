import 'dart:convert';

import 'package:flutter/material.dart';
// Remove the unused import directive
import 'package:faculdade/src/user/user-create.dart';
import 'package:faculdade/src/user/user-edit.dart';
import 'package:http/http.dart' as http;

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  void dispose() {
    super.dispose();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('http://localhost:4000/usuario'));

    if (response.statusCode == 200) {
      setState(() {
        users = jsonDecode(response.body);
        print(users);
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final nome = user['nome'].toString();
          final email = user['email'].toString();

          return ListTile(
            title: Text('Nome: $nome'),
            subtitle: Text('Email: $email'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    int userIdInt = int.parse(user['id'].toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditUserWidget(userId: userIdInt),
                      ),
                    ).then((value) => fetchUsers());
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    // Send delete request to the backend
                    print('Deleting user ${user['id']}');
                    final response = await http.delete(Uri.parse(
                        'http://localhost:4000/usuario/${user['id']}'));
                    if (response.statusCode == 200) {
                      // If the server returns a 200 OK response,
                      // display a success alert
                      fetchUsers();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Success'),
                            content: Text('User deleted successfully'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // If the server did not return a 200 OK response,
                      // display an error alert
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text('Failed to delete user'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateUserWidget()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
