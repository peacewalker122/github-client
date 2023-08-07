// TODO(CodelabUser): Create an OAuth App
import 'package:flutter_dotenv/flutter_dotenv.dart';

var githubClientId = dotenv.get('GITHUB_CLIENT_ID');
var githubClientSecret = dotenv.get('GITHUB_CLIENT_SECRET');

// OAuth scopes for repository and user information
const githubScopes = ['repo', 'read:org'];
