import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Simple Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoPage(title: 'Flutter Simple Todo'),
    );
  }
}

class TodoPage extends StatefulWidget {
  TodoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<String> _todos = List<String>();
  List<String> _dones = List<String>();

  final _newTodoController = TextEditingController();

  void _addNewTodo(String newTodo) {
    _newTodoController.clear();
    setState(() {
      _todos.insert(0,newTodo);
    });
  }

  void _doneTodo(String doneTodo) {
    setState(() {
      _todos.remove(doneTodo);
      _dones.insert(0,doneTodo);
    });
  }

  Widget _buildTodoWidget(String todo) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 4.0),
      child: Card(
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(4.0),
                  child: IconButton(
                    icon: Icon(Icons.check),
                    onPressed: (){
                      _doneTodo(todo);
                    },
                  ),
                ),
                Flexible(
                  child: Container(
                    child: Text(
                      todo, 
                      style: TextStyle(fontSize: 18.0,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: _newTodoController,
                    decoration: InputDecoration(filled: true, labelText: "New Todo"),
                  ),
              ),
              Container(
                margin: EdgeInsets.all(4.0),
                child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: (){
                    _addNewTodo(_newTodoController.text)
                  },
                ),
              )
              ],
            ),
          ),
        ),
        Flexible(
          child: _todos.length > 0
              ? ListView.builder(
                  itemBuilder: (context, index) =>
                      _buildTodoWidget(_todos[index]),
                  itemCount: _todos.length,
                )
              : Text("No Data"),
        ),
      ]),
    );
  }
}
