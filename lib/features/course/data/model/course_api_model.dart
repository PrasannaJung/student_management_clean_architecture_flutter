import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';

final courseApiModelProvider = Provider((ref){
  return CourseApiModel.empty();
});

@JsonSerializable()
class CourseApiModel{
  @JsonKey(name:"_id")
  final String courseId;
  final String courseName;

  CourseApiModel({required this.courseId, required this.courseName});

  // empty constructor
  CourseApiModel.empty() : courseId = '', courseName = '';

  // this function is used to convert the incoming json into the Model
  factory CourseApiModel.fromJson(Map<String, dynamic> json){
    return CourseApiModel(courseId: json["_id"], courseName: json["courseName"]);
  }

  // this function is used to return a json data
  Map<String, dynamic> toJson(){
    return {
      // "_id":batchId,
      "courseName":courseName
    };
  }

  CourseEntity toEntity() {
    return CourseEntity(courseName: courseName, courseId: courseId);
  }

  CourseApiModel fromEntity(CourseEntity entity) {
    return CourseApiModel(
        courseName: entity.courseName, courseId: entity.courseId ?? "");
  }

  List<CourseEntity> toCourseEntityList(List<CourseApiModel> lst) {
    return lst.map((model) => model.toEntity()).toList();
  }

}