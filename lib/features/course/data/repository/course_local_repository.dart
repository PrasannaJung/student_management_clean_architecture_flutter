import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/failure/failure.dart';
import 'package:student_management_starter/features/course/data/data_source/local/course_local_datasource.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';
import 'package:student_management_starter/features/course/domain/repository/course_repository.dart';

final courseLocalRepositoryProvider = Provider<ICourseRepository>((ref) =>
    CourseLocalRepository(
        courseLocalDatasource: ref.read(courseLocalDatasourceProvider)));

class CourseLocalRepository implements ICourseRepository {
  final CourseLocalDatasource courseLocalDatasource;

  CourseLocalRepository({required this.courseLocalDatasource});

  @override
  Future<Either<Failure, bool>> addCourse(CourseEntity course) {
    return courseLocalDatasource.addCourse(course);
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getAllCourses() {
    return courseLocalDatasource.getAllCourses();
  }
}
