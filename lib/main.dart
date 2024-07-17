import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthWidget(),
    );
  }
}

class AuthWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Login App'),
      ),
      body: Center(
        child: authState.isAuthenticated ? LoggedInWidget() : LoginWidget(),
      ),
    );
  }
}

class LoginWidget extends ConsumerStatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends ConsumerState<LoginWidget> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final username = _usernameController.text;
              final password = _passwordController.text;
              await authNotifier.login(username, password);
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}

class LoggedInWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);
    final authState = ref.watch(authProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Welcome, you are logged in!'),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            authNotifier.logout();
          },
          child: Text('Logout'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            await authNotifier.fetchData();
          },
          child: Text('Fetch Data'),
        ),
        SizedBox(height: 20),
        if (authState.data != null) Text('Data: ${authState.data}'),
      ],
    );
  }
}
