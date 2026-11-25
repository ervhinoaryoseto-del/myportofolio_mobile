import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  testWidgets('renders MyPortfolio home page', (tester) async {
    final client = MockClient((_) async => http.Response('[]', 200));
    await tester.pumpWidget(MyApp(apiClient: ApiClient(client: client)));
    expect(find.text('MyPortfolio'), findsOneWidget);
  });
}
