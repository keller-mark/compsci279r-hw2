import 'package:flutter/material.dart';
import 'package:todo_app/task.dart';

/* Dart programs look for the "main" function. */
void main() {
  runApp(const MyApp());
}

/*
  Define a stateless widget which shows each task item
  and its checkbox + label elements.
*/
class TodoItem extends StatelessWidget {
  /*
    It will take a setChecked callback from the parent list widget,
    so we must define an instance variable for that function.
  */
  final Function(int, bool) setChecked;
  /* Define the other instance variables that are primitive values. */
  final int id;
  final String title;
  final String created;
  final bool isChecked;

  /* The constructor will take the id, title, creation date, checked status, and callback. */
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
    /* Render a checkbox item that has a label. */
    return CheckboxListTile(
      title: Text(this.title),
      /* Pass in the checked status as the current value. */
      value: this.isChecked,
      /* Provide the onChange callback, where we will notify the parent widget. */
      onChanged: (bool? value) {
        // Call the parent's setChecked callback function,
        // originally provided in the constructor of the widget.
        // Reference: https://stackoverflow.com/a/51778268
        this.setChecked(this.id, value!);
      },
    );
  }
}

/* In a StatefulWidget, state can change during the widget lifecycle. */
// We need to be able to update the state of the task list to add/update/remove tasks.
class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

// Define the state class for the TodoList widget,
// where we provide the build() render function,
// and manage the state lifecycle.
class _TodoListState extends State<TodoList> {

  // Define a list to store the task object instances.
  // Reference: https://stackoverflow.com/a/63458217
  List<Task> _myTasks = <Task>[];
  // Define a text field controller variable,
  // which will be set up in the initState() call,
  // so we must declare it as late (since it does not have an initial value here).
  late TextEditingController _controller;

  // Create the text field controller during state initialization during the lifecycle.
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  // Clean up the text field controller during state tear-down during the lifecycle.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Provide the render function which will render the list and the text field and other buttons.
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
              _clearTasks();
            },
            child: Text('Clear all tasks'),
          )
        )
      ]
    );
  }

  // Define the deletion function, which will set the task list to an empty list.
  _clearTasks() {
    // Call setState to trigger a re-render.
    setState(() {
      _myTasks = <Task>[];
    });
  }

  // Define the task addition function, which will append a new task instance
  // based on the string provided by the user in the text field.
  _addTask(String title) {
    _myTasks.add(new Task(id: _myTasks.length, title: title, created: DateTime.now(), isChecked: false));
    // Call setState to trigger a re-render.
    setState(() {
      _myTasks = _myTasks;
    });
  }

  // Define the task checking function, which will modify the isChecked variable
  // of the specified task instance (matched on the task id).
  _setChecked(int id, bool isChecked) {
    // Iterate over all tasks to find the one with the matching id.
    for(int i = 0; i < _myTasks.length; i++) {
      // If the id matches, update the task's isChecked variable.
      if(_myTasks[i].id! == id) {
        _myTasks[i].isChecked = isChecked;
      }
    }
    // Call setState to trigger a re-render.
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
          // In the body, render the TodoList widget defined above.
          child: TodoList(),
        ),
      ),
    );
  }
  
}
