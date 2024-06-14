import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_management_starter/app/constants/api_endpoint.dart';
import 'package:student_management_starter/core/failure/failure.dart';

class AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSource({required this.dio});

  Future<Either<Failure, String>> uploadProfilePicture(File image) async {
    try {
      String fileName = image.path.split("/").last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture':
              await MultipartFile.fromFile(image.path, filename: fileName),
        },
      );

      Response response = await dio.post(
        ApiEndpoints.uploadImage,
        data: formData
      );
      
      return Right(response.data["data"]);

    } on DioException catch (e) {
      return Left(Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0'));
    }
  }
}
