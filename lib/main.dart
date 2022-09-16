import 'package:flutter/material.dart';
import 'package:todo_app/task.dart';

void main() {
  runApp(const MyApp());
}

class TodoItem extends StatelessWidget {

  final Function(int, bool) setChecked;
  final int id;
  final String title;
  final String created;
  final bool isChecked;

  const TodoItem({
    super.key,
    required this.id,
    required this.title,
    required this.created,
    required this.isChecked,
    required this.setChecked,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(this.title),
      value: this.isChecked,
      onChanged: (bool? value) {
        // Call the parent's setChecked callback function.
        // Reference: https://stackoverflow.com/a/51778268
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

  // Reference: https://stackoverflow.com/a/63458217
  List<Task> _myTasks = <Task>[];
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _myTasks.add(new Task(id: 0, title: "Test", created: DateTime.now(), isChecked: true));
    _myTasks.add(new Task(id: 1, title: "Test 2", created: DateTime.now(), isChecked: false));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            // Specify the number of items that are possible to render.
            // Multiply by two because we want to include dividers in between.
            itemCount: _myTasks.length * 2,
            // Define how each item is rendered.
            itemBuilder: (context, i) {
              // If odd, render divider.
              if(i.isOdd) return const Divider();
              // Otherwise, render a task item with label/checkbox.
              // Divide by two to get a list item index.
              final index = i ~/ 2;
              final data = _myTasks[index];
              // Return a TodoItem widget.
              return TodoItem(id: data.id!, title: data.title!, created: "Now", isChecked: data.isChecked!, setChecked: _setChecked);
            }
          )
        ),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Add task',
          ),
          onSubmitted: (String value) async {
            _addTask(value);
            _controller.text = "";
          }
        ),
        Center(
          child: TextButton(
            onPressed: () {
              setState(() {
                _myTasks = <Task>[];
              });
            },
            child: Text('Clear all tasks'),
          )
        )
      ]
    );
  }

  _addTask(String title) {
    _myTasks.add(new Task(id: _myTasks.length, title: title, created: DateTime.now(), isChecked: false));
    setState(() {
      _myTasks = _myTasks;
    });
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
