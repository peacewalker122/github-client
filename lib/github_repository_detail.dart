import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RepositoryDetailWidget extends StatefulWidget {
  const RepositoryDetailWidget({required this.repository, super.key});

  final Repository repository;

  @override
  State<RepositoryDetailWidget> createState() => _RepositoryDetailWidgetState();
}

class _RepositoryDetailWidgetState extends State<RepositoryDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.repository.fullName),
      ),
      body: ListView.builder(
          primary: false,
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Text(widget.repository.fullName),
                  subtitle: Text(widget.repository.description ?? ''),
                ),
                ListTile(
                  title: Text('Language'),
                  subtitle: Text(widget.repository.language ?? ''),
                ),
                ListTile(
                  title: Text('Stars'),
                  subtitle: Text(widget.repository.stargazersCount.toString()),
                ),
                ListTile(
                  title: Text('Forks'),
                  subtitle: Text(widget.repository.forksCount.toString()),
                ),
                ListTile(
                  title: Text('Open Issues'),
                  subtitle: Text(widget.repository.openIssuesCount.toString()),
                ),
                ListTile(
                  title: Text('Watchers'),
                  subtitle: Text(widget.repository.watchersCount.toString()),
                ),
                ListTile(
                  title: Text('Default Branch'),
                  subtitle: Text(widget.repository.defaultBranch),
                ),
                ListTile(
                  title: Text('Created'),
                  subtitle: Text(widget.repository.createdAt.toString()),
                ),
                ListTile(
                  title: Text('Updated'),
                  subtitle: Text(widget.repository.updatedAt.toString()),
                ),
                ListTile(
                  title: Text('Pushed'),
                  subtitle: Text(widget.repository.pushedAt.toString()),
                ),
                ListTile(
                  title: Text('Homepage'),
                  subtitle: Text(widget.repository.homepage ?? ''),
                ),
                ListTile(
                  title: Text('Size'),
                  subtitle: Text(widget.repository.size.toString()),
                ),
                ListTile(
                  title: Text('Forks'),
                  subtitle: Text(widget.repository.forksCount.toString()),
                ),
                ListTile(
                  title: Text('Open Issues'),
                  subtitle: Text(widget.repository.openIssuesCount.toString()),
                ),
                ListTile(
                  title: Text('Watchers'),
                  subtitle: Text(widget.repository.watchersCount.toString()),
                ),
                ListTile(
                  title: Text('Default Branch'),
                  subtitle: Text(widget.repository.defaultBranch),
                ),
                ListTile(
                  title: Text('Created'),
                  subtitle: Text(widget.repository.createdAt.toString()),
                ),
                ListTile(
                  title: Text('Updated'),
                  subtitle: Text(widget.repository.updatedAt.toString()),
                ),
                ListTile(
                  title: Text('Pushed'),
                  subtitle: Text(widget.repository.pushedAt.toString()),
                ),
                ListTile(
                  title: Text('Homepage'),
                  subtitle: Text(widget.repository.homepage ?? ''),
                ),
                ListTile(
                  title: Text('Size'),
                  subtitle: Text(widget.repository.size.toString()),
                ),
              ],
            );
          }),
    );
  }
}
