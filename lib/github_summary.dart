import 'package:flutter/material.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:github/github.dart';
import 'package:github_client/github_repository.dart';
import 'package:github_client/my_home_page.dart';

class GithubSummary extends StatefulWidget {
  const GithubSummary({required this.github, super.key});
  final GitHub github;

  @override
  State<GithubSummary> createState() => _GithubSummaryState();
}

class _GithubSummaryState extends State<GithubSummary> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        NavigationRail(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          labelType: NavigationRailLabelType.all,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Octicons.person),
              label: Text('Post List'),
            ),
            NavigationRailDestination(
              icon: Icon(Octicons.repo),
              label: Text('Repository'),
            ),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(
            child: IndexedStack(
          index: _selectedIndex,
          children: [
            const MyHomePage(),
            GithubRepositoryWidget(
              gitHub: widget.github,
            )
          ],
        ))
      ],
    );
  }
}
