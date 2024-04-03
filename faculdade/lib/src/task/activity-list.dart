import 'dart:convert';

import 'package:faculdade/src/user/user-list.dart';
import 'package:flutter/material.dart';
// Remove the unused import directive
import 'package:faculdade/src/task/activity-create.dart';
import 'package:faculdade/src/task/activity-edit.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<dynamic> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final response =
        await http.get(Uri.parse('http://localhost:4000/atividade'));

    if (response.statusCode == 200) {
      setState(() {
        tasks = jsonDecode(response.body);
        print(tasks);
      });
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          final titulo = task['titulo'].toString();
          final dataEntrega = task['dataEntrega'].toString();
          final formattedDate =
              DateFormat('yyyy-MM-dd').format(DateTime.parse(dataEntrega));

          return ListTile(
            title: Text('Titulo: $titulo'),
            subtitle: Text('Data da entrega: $formattedDate'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTaskWidget(
                            atvId: task[
                                'id']), // Substitua 'id' pelo campo correto se necessário
                      ),
                    ).then((value) => fetchTasks());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    // Send delete request to the backend
                    final response = await http.delete(Uri.parse(
                        'http://localhost:4000/atividade/${task['id']}'));
                    if (response.statusCode == 200) {
                      // If the server returns a 200 OK response,
                      // display a success alert
                      fetchTasks();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Success'),
                            content: Text('Task deleted successfully'),
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
                            content: Text('Failed to delete task'),
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
            MaterialPageRoute(builder: (context) => CreateTaskWidget()),
          ).then((value) => fetchTasks());
        },
        child: Icon(Icons.add),
      ),
      // float refresh button
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
