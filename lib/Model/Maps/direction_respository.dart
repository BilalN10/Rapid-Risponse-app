import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'directtion_model.dart';

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRepository({Dio dio}) : _dio = dio;

  Future<Directions> getDirections({
    LatLng origin,
    LatLng destination,
  }) async {
    _dio.interceptors.clear();
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': 'AIzaSyCeJyzlb58PN8RaSL8wtX3s_y-Zc36VrnU',
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      try {
        return Directions.fromMap(response.data);
      } catch (e) {}
    }
    return null;
  }
}
