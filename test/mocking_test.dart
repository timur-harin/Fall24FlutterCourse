import 'package:fall_24_flutter_course/templates/lab7/album.dart';
import 'package:fall_24_flutter_course/templates/lab7/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'mocking_test.mocks.dart';

// Do not forget to run generation for mocks
// https://docs.flutter.dev/cookbook/testing/unit/mocking#:~:text=Add%20the%20annotation%20%40GenerateMocks(%5Bhttp.Client%5D)%20to%20the%20main%20function%20to%20generate%20a%20MockClient%20class%20with%20mockito.s
@GenerateMocks([http.Client])
void main() {
  // TODO add API creation
  final apiService = ApiService();

  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      final client = MockClient();

      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async =>
              // TODO add checking response (http.Response) and code (200) check
              http.Response(
                  '{"userId": 1, "id": 1, "title": "Album Title"}', 200));

      // TODO add call to fetchAlbum
      expect(await apiService.fetchAlbum(client), isA<Album>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async =>
              // TODO add checking response (http.Response) and code (404) check
              http.Response('Not Found', 404));

      // TODO add call to fetchAlbum
      expect(() async => await apiService.fetchAlbum(client), throwsException);
    });
  });
}
