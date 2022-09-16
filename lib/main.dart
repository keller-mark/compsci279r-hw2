import 'package:flutter/material.dart';
import 'package:todo_app/task.dart';

void main() {
  runApp(const MyApp());
}

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.id,
    required this.title,
    required this.created,
    required this.isChecked,
    required this.setChecked,
  });

  final Function(int, bool) setChecked;
  final int id;
  final String title;
  final String created;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(this.title),
      value: this.isChecked,
      onChanged: (bool? value) {
        this.setChecked(this.id, value!);
      },
    );
  }
}

/* In a StatefulWidget, state can change during the widget lifecycle. */
class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  List<Task> _myTasks = <Task>[];

  @override
  void initState() {
    super.initState();
    print("Init state");
    _myTasks.add(new Task(id: 0, title: "Test", created: DateTime.now(), isChecked: true));
    _myTasks.add(new Task(id: 1, title: "Test 2", created: DateTime.now(), isChecked: false));
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _myTasks.length * 2,
      itemBuilder: (context, i) {
        if(i.isOdd) return const Divider();
        print("build item");
        final index = i ~/ 2;
        final data = _myTasks[index];
        return TodoItem(id: data.id!, title: data.title!, created: "Now", isChecked: data.isChecked!, setChecked: _setChecked);
      }
    );
  }

  _setChecked(int id, bool isChecked) {
    for(int i = 0; i < _myTasks.length; i++) {
      if(_myTasks[i].id! == id) {
        _myTasks[i].isChecked = isChecked;
      }
    }
    setState(() {
      _myTasks = _myTasks;
    });
  }
  
}




/* A flutter app is a "widget" */
/* In a StatelessWidget, everything is immutable. */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /*
    The build method defines how the widget is displayed,
    and which smaller widgets it is composed of (similar to the DOM tree representation).
  */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /* Set the title that appears in the tab/window of the browser. */
      title: 'To-Do App',
      /*
        The scaffold widget is from the Material library and provides a navigation bar
        and a body that holds a widget subtree.
      */
      home: Scaffold(
        appBar: AppBar(
          title: const Text('To-Dos'),
        ),
        /* Align the body contents to the center of the screen. */
        body: const Center(
          child: TodoList(),
        ),
      ),
    );
  }
  
}
