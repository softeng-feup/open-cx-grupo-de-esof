
import 'package:flutter/material.dart';
import 'package:flutter_app/UserMainScreen/UserMainScreen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  final String username;
  final String password;

  Post({this.username, this.password});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      //userId: json['userId'],
      username: json['username'],
      password: json['password'],
    );
  }
}

class PostList {
  final List<Post> posts;

  PostList({
    this.posts,
  });

  factory PostList.fromJson(List<dynamic> parsedjson) {
    List<Post> posts = new List<Post>();
    posts = parsedjson.map((i)=>Post.fromJson(i)).toList();
    return PostList(
      posts: posts,
    );
  }
}

Future<PostList> fetchPost() async {
  final response =
    await http.get('http://open-cx.herokuapp.com/users');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return PostList.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class HomePage extends StatefulWidget {
  HomePage( {Key key}) : super(key: key);

  static const String routeName = "/";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<PostList> postlist;

  @override
  void initState() {
    super.initState();
    postlist = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'QuizApp',
        home: Scaffold(
          appBar: AppBar(
            title: Text('QuizApp'),
          ),
          body: Center(
              child: Column(
                  children: <Widget>[
                    FutureBuilder<PostList>(
                      future: postlist,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data.posts[0].username);
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }

                        // By default, show a loading spinner.
                        return CircularProgressIndicator();;
                      },
                    ),
                   /* Padding(padding: EdgeInsets.only(top: 40.0)),
                    RichText(
                      text: TextSpan(
                        text: 'QuizApp',
                        style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 50,
                            color: Colors.lightBlue
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 40.0)),
                      RichText(
                        text: TextSpan(
                          text: 'Login',
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.black,
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Login_Form(),
                    ),
                    Padding(padding: EdgeInsets.only(top: 40.0)),
                    Create_Account_Button()

                    */
              ])
          ),
        )
    );
  }
}




class Login_Form extends StatelessWidget {
  static final _formKey = new GlobalKey<FormState>();

  String _password;

  String _username;



  void validateLogin(String username, String password) {
    //Future<Post> response = fetchPost();

    //if (response.username == username)
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.values(List(5)),
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        <Widget>[
          RichText(
            text: TextSpan(
              text: 'Username',
              style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) => _username = value,
          ),
          Padding(padding: EdgeInsets.only(top: 40.0)),
          RichText(
            text: TextSpan(
              text: 'Password',
              style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
              onSaved: (value) => _password = value,
            obscureText:true
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // Process data.
                  _formKey.currentState.save();
                  print(_username);
                  print(_password);
                  validateLogin(_username, _password);
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

}

class Create_Account_Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.lightBlue,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      padding: EdgeInsets.all(8.0),
      splashColor: Colors.blue,
      onPressed: () {
        _buttonTap(context);
      },
      child: RichText(
        text: TextSpan(
          text: "Don't have an account?",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        textScaleFactor: 2,
      ),
    );
  }

  _buttonTap(BuildContext context) {
    // Nao funciona, nao sei porque
    //Navigator.pushNamed(context, page1.routeName);

    Navigator.push(context, new MaterialPageRoute(
        builder: (context) =>
        new UserMainScreen())
    );
  }
}