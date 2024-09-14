import 'package:dio/dio.dart';
import 'package:chat/src/domain/core/i_base_client.dart';
import 'package:flutter/material.dart';

class ApiService extends IBaseClient {
  // Dio instance
  late Dio _dio;

  // Base URL for your API
  String baseUrl = "";

  // Constructor
  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(minutes: 2),
        receiveTimeout: const Duration(minutes: 2),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Optional: Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // You can add headers here like authorization token
          debugPrint("Requesting: ${options.uri}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint("Response: ${response.statusCode}");
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          debugPrint("Error: ${error.message}");
          return handler.next(error);
        },
      ),
    );
  }

  // GET request
  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      Response response = await _dio.get(endpoint, queryParameters: queryParams);
      return response;
    } catch (e) {
      throw Exception("Failed to load data: $e");
    }
  }

  // POST request
  Future<Response> post(String endpoint, {dynamic data}) async {
    try {
      Response response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      throw Exception("Failed to post data: $e");
    }
  }

  // PUT request
  Future<Response> put(String endpoint, {dynamic data}) async {
    try {
      Response response = await _dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      throw Exception("Failed to update data: $e");
    }
  }

  // DELETE request
  Future<Response> delete(String endpoint) async {
    try {
      Response response = await _dio.delete(endpoint);
      return response;
    } catch (e) {
      throw Exception("Failed to delete data: $e");
    }
  }
}
