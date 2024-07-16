import 'package:dio/dio.dart';
import 'package:homework/model/model_bird.dart';



class ApiService {
  static const String url = 'https://freetestapi.com/api/v1/birds';

  final Dio _dio = Dio();

 Future<List<Bird>> fetchBirds() async {
  try {
    Response response = await _dio.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = response.data;
      List<Bird> birds = [];

      for (var birdData in jsonResponse) {
        // Check if all required fields are not null
        if (birdData['name'] != null && birdData['family'] != null && birdData['order'] != null) {
          birds.add(Bird(
            name: birdData['name'],
            family: birdData['family'],
            order: birdData['order'],
          ));
        }
      }

      return birds;
    } else {
      throw Exception('Failed to load birds');
    }
  } catch (e) {
    throw Exception('Failed to load birds: $e');
  }
}

}
