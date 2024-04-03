import 'package:flutter/material.dart';
import 'package:faculdade/src/task/activity-list.dart';
import 'package:faculdade/src/user/user-list.dart';
import 'package:faculdade/src/usuario-atividade/usuarioAtividade-list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faculdade',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/user': (context) => UserList(),
        '/task': (context) => TaskList(),
        '/usuario-atividade': (context) => UsuarioAtividadeList(),
      },
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    appBar:
    AppBar(
      title: Text('Tasks'),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faculdade'),
      ),
      // Add a drawer to the scaffold
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('Users'),
              onTap: () {
                Navigator.pushNamed(context, '/user');
              },
            ),
            ListTile(
              title: const Text('Tasks'),
              onTap: () {
                Navigator.pushNamed(context, '/task');
              },
            ),
            ListTile(
              title: const Text('usuario-atividade'),
              onTap: () {
                Navigator.pushNamed(context, '/usuario-atividade');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName, required this.backgroundColor});
  final String cardName;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (cardName == 'User') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserList()),
          );
        }
        if (cardName == 'Task') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskList()),
          );
        }
      },
      child: Card(
        color: backgroundColor,
        child: Container(
          width: 600,
          height: 200,
          child: Center(child: Text(cardName)),
        ),
      ),
    );
  }
}
