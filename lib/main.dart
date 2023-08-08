import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_client/post.dart';
import 'package:github_client/post_list.dart';
import 'package:github_client/widget_text_input.dart';


void main() {
  dotenv.load(fileName: ".env.development");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];
  String text = 'Github Client';

  void changeText(String value) {
    setState(() {
      posts.add(Post(value, 'Title'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Github Client')),
        body: Column(
          children: <Widget>[
            Expanded(child: WidgetTextInput(this.changeText)),
            Expanded(child: PostList(this.posts))
          ],
        ));
  }
}