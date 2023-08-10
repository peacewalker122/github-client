import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github/github.dart';
import 'package:github_client/github_login_widget.dart';
import 'package:github_client/github_oauth_client.dart';

Future<void> main() async {
  await dotenv.load();

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
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: GithubLogin(
        builder: (context, httpClient) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Logged in to Github'),
            ),
            body: const Center(
              child: Text('You are now logged in to Github!'),
            ),
          );
        },
        githubClientId: githubClientId,
        githubClientSecret: githubClientSecret,
        githubScopes: githubScopes,
      ),
    );
  }
}
