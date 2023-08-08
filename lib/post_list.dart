import 'package:flutter/material.dart';
import 'post.dart';

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
