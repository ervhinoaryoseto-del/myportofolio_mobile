/// Base URL of the Django REST Framework backend.
///
/// Android emulator uses 10.0.2.2 to reach the host machine.
/// Override for other targets with:
/// --dart-define=API_BASE_URL=http://localhost:8000
const String apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:8000',
);
