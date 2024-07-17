import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_service.dart';

// A state class to represent the authentication state
class AuthState {
  final bool isAuthenticated;
  final String? data;

  AuthState({required this.isAuthenticated, this.data});
}

// A provider that holds the state of the authentication
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState(isAuthenticated: false));

  final AuthService _authService = AuthService();

  Future<void> login(String username, String password) async {
    final isAuthenticated = await _authService.login('...', 'secure');
    if (isAuthenticated) {
      state = AuthState(isAuthenticated: true);
    } else {
      // Handle failed login if necessary
    }
  }

  Future<void> fetchData() async {
    final data = await _authService.fetchData();
    if (data != null) {
      state = AuthState(isAuthenticated: true, data: data);
    } else {
      // Handle data fetch failure if necessary
    }
  }

  void logout() {
    state = AuthState(isAuthenticated: false);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
