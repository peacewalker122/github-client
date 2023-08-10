import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:github_client/appbar.dart';
import 'package:github_client/github_repository_detail.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubRepositoryWidget extends StatefulWidget {
  const GithubRepositoryWidget({required this.gitHub, super.key});

  final GitHub gitHub;

  @override
  State<GithubRepositoryWidget> createState() => _GithubRepositoryWidgetState();
}

class _GithubRepositoryWidgetState extends State<GithubRepositoryWidget> {
  @override
  initState() {
    super.initState();
    _repositories = widget.gitHub.repositories.listRepositories().toList();
  }

  late Future<List<Repository>> _repositories;

  void RepositoryDetail(Repository repository) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RepositoryDetailWidget(repository: repository),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: customAppBar,
      ),
      body: FutureBuilder(
        future: _repositories,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error}',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var repositories = snapshot.data as List<Repository>;

          return ListView.builder(
            primary: false,
            itemCount: repositories.length,
            itemBuilder: (context, index) {
              var repository = repositories[index];
              return ListTile(
                title: Text(repository.fullName),
                subtitle: Text(repository.description ?? ''),
                onTap: () => RepositoryDetail(repository),
              );
            },
          );
        },
      ),
    );
  }
}
