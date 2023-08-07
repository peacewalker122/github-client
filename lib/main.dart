import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_client/post.dart';

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

class WidgetTextInput extends StatefulWidget {
  WidgetTextInput(this.onChanged);

  final Function(String) onChanged;

  @override
  State<WidgetTextInput> createState() => _WidgetTextInputState();
}

class _WidgetTextInputState extends State<WidgetTextInput> {
  String username = '';
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onChanged() {
    setState(() {
      FocusScope.of(context).unfocus();
      widget.onChanged(controller.text);
      username = controller.text;
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        onSubmitted: (value) => _onChanged(),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          border: OutlineInputBorder(),
          labelText: 'Username',
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _onChanged,
          ),
        ));
  }
}

class PostList extends StatefulWidget {
  final List<Post> posts;

  PostList(this.posts);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void like(Function callback) {
    setState(() {
      callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.posts.length,
        itemBuilder: (context, index) {
          var post = widget.posts[index];
          return Card(
            child: Row(children: <Widget>[
              Expanded(
                  child: ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
                // leading: Icon(Icons.person),
                // trailing: Icon(Icons.favorite),
              )),
              Row(children: <Widget>[
                Container(
                  child: Text(post.likes.toString()),
                  padding: const EdgeInsets.all(10),
                ),
                IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: () => this.like(post.likePost),
                  color: post.isLiked ? Colors.deepPurple : Colors.grey,
                )
              ])
            ]),
          );
        });
  }
}
