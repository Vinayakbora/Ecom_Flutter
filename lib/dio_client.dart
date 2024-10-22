import 'package:dio/dio.dart';
import 'package:flutter_assngmnt/api_service.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient(){
    _dio.options
      ..baseUrl = ApiService.baseUrl
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 20)
      ..headers = { 'Content-Type' : 'json/application'
    };
  }

  Future get(String endpoint,{Map<String, dynamic>? queryParameter}) async {
    try {
        return await _dio.get(endpoint, queryParameters: queryParameter);
      } catch (e) {
        rethrow;
      }
    }
    
  }
