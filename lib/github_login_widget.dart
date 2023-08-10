import 'dart:developer';
import 'dart:io';

import 'package:github/github.dart';
import 'package:github_client/appbar.dart';
import 'package:github_client/github_summary.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final _authorizationEndpoint =
    Uri.parse('https://github.com/login/oauth/authorize');
final _tokenEndpoint = Uri.parse('https://github.com/login/oauth/access_token');

typedef AuthenticatedBuilder = Widget Function(
    BuildContext context, oauth2.Client client);

class GithubLogin extends StatefulWidget {
  const GithubLogin({
    required this.builder,
    required this.githubClientId,
    required this.githubClientSecret,
    required this.githubScopes,
    super.key,
  });

  final AuthenticatedBuilder builder;
  final String githubClientId;
  final String githubClientSecret;
  final List<String> githubScopes;

  @override
  State<GithubLogin> createState() => _GithubLoginState();
}

class _GithubLoginState extends State<GithubLogin> {
  HttpServer? _redirectServer;
  oauth2.Client? _client;

  @override
  Widget build(BuildContext context) {
    final client = _client;
    String accessToken = _client?.credentials.accessToken ?? '';
    GitHub githubCLient = _getGitHub(accessToken);

    if (client != null) {
      return widget.builder(context, client);
    }

    void successLogin() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GithubSummary(github: githubCLient)));
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: customAppBar,
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Center(
              child: Image.network(
                  'https://pngimg.com/uploads/github/github_PNG40.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 10),
            child: Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  textStyle: MaterialStateProperty.all(const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
                  minimumSize: MaterialStateProperty.all(Size(50, 50)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  mouseCursor: MaterialStateProperty.all(MouseCursor.defer),
                ),
                onPressed: () async {
                  await _redirectServer?.close();

                  _redirectServer = await HttpServer.bind('localhost', 33719);

                  var redirectUrl = Uri.parse(
                      'http://localhost:${_redirectServer!.port}/auth');
                  // print('Listening on $redirectUrl');

                  var authenticatedHttpClient =
                      await _getOAuth2Client(redirectUrl);
                  setState(() {
                    _client = authenticatedHttpClient;
                    accessToken = _client?.credentials.accessToken ?? '';
                    // print('inStarte GithubLOGIN: $accessToken');
                    githubCLient = _getGitHub(accessToken);
                    successLogin();
                  });
                },
                child: const Text(
                  'Login with Github',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  selectionColor: Color.fromARGB(255, 250, 250, 250),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  Future<oauth2.Client> _getOAuth2Client(Uri redirectUrl) async {
    if (widget.githubClientId.isEmpty || widget.githubClientSecret.isEmpty) {
      throw const GithubLoginException(
          'githubClientId and githubClientSecret must be not empty. '
          'See `lib/github_oauth_credentials.dart` for more detail.');
    }
    var grant = oauth2.AuthorizationCodeGrant(
      widget.githubClientId,
      _authorizationEndpoint,
      _tokenEndpoint,
      secret: widget.githubClientSecret,
      httpClient: _JsonAcceptingHttpClient(),
    );
    var authorizationUrl =
        grant.getAuthorizationUrl(redirectUrl, scopes: widget.githubScopes);

    await _redirect(authorizationUrl);
    var responseQueryParameters = await _listen();
    var client =
        await grant.handleAuthorizationResponse(responseQueryParameters);
    return client;
  }

  Future<void> _redirect(Uri authorizationUrl) async {
    if (await canLaunchUrl(authorizationUrl)) {
      await launchUrl(authorizationUrl);
    } else {
      throw GithubLoginException('Could not launch $authorizationUrl');
    }
  }

  Future<Map<String, String>> _listen() async {
    var request = await _redirectServer!.first;
    var params = request.uri.queryParameters;
    request.response.statusCode = 200;
    request.response.headers.set('content-type', 'text/plain');
    request.response.writeln('Authenticated! You can close this tab.');
    await request.response.close();
    await _redirectServer!.close();
    _redirectServer = null;
    return params;
  }
}

class _JsonAcceptingHttpClient extends http.BaseClient {
  final _httpClient = http.Client();
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Accept'] = 'application/json';
    return _httpClient.send(request);
  }
}

class GithubLoginException implements Exception {
  const GithubLoginException(this.message);
  final String message;
  @override
  String toString() => message;
}

GitHub _getGitHub(String accessToken) {
  return GitHub(auth: Authentication.withToken(accessToken));
}
