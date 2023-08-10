import 'package:flutter/material.dart';
import 'package:github_client/appbar.dart';
import 'package:github_client/post.dart';
import 'package:github_client/post_list.dart';
import 'package:github_client/widget_text_input.dart';

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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: customAppBar,
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: <Widget>[
              Expanded(child: WidgetTextInput(this.changeText)),
              Expanded(child: PostList(this.posts))
            ],
          ),
        ));
  }
}
