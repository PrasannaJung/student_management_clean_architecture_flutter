import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/failure/failure.dart';
import 'package:student_management_starter/features/course/data/data_source/remote/course_remote_datasource.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';
import 'package:student_management_starter/features/course/domain/repository/course_repository.dart';


final courseRemoteRepoProvider = Provider((ref){
  return CourseRemoteImpl(courseRemoteDatasource: ref.read(courseRemoteDataSourceProvider));
});

class CourseRemoteImpl extends ICourseRepository{
  CourseRemoteDatasource courseRemoteDatasource;

  CourseRemoteImpl({required this.courseRemoteDatasource});

  @override
  Future<Either<Failure, bool>> addCourse(CourseEntity course) {
    return courseRemoteDatasource.addCourse(course);
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getAllCourses() {
    return courseRemoteDatasource.getAllCourses();
  }


}