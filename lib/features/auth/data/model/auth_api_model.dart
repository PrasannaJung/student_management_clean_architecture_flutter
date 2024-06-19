import 'package:json_annotation/json_annotation.dart';
import 'package:student_management_starter/features/auth/domain/entity/auth_entity.dart';
import 'package:student_management_starter/features/batch/data/model/batch_api_model.dart';
import 'package:student_management_starter/features/course/data/model/course_api_model.dart';

part 'auth_api_model.g.dart';


@JsonSerializable()
class AuthApiModel  {
  @JsonKey(name: "_id")
  final String id;
  final String fname;
  final String lname;
  final String phone;
  final String? image;
  final BatchApiModel batch;
  final List<CourseApiModel> courses;
  final String username;
  final String password;

  AuthApiModel({
    required this.id,
    required this.fname,
    required this.lname,
    required this.phone,
    this.image,
    required this.batch,
    required this.courses,
    required this.username,
    required this.password,
});

  // empty constructor
  // AuthApiModel.empty()
  //     : id = '',
  //       fname = '',
  //       lname = '',
  //       phone = '',
  //       batch = BatchApiModel.empty(),
  //       courses = [],
  //       username = '',
  //       password = '';
  //

  // this function is used to convert the incoming json into the Model
  // factory AuthApiModel.fromJson(Map<String, dynamic> json){
  //   return AuthApiModel(
  //       studentId: json["_id"],
  //       fname: json["fname"],
  //       lname: json["lname"],
  //       username: json["username"],
  //       password: json["password"],
  //       phone: json["phone"],
  //       courses: json["courses"],
  //       batch: json["batch"]
  //   );
  // }
  //
  // // this function is used to return a json data
  // Map<String, dynamic> toJson(){
  //   return {
  //     // "_id":batchId,
  //     "fname":fname,
  //     "lname":lname,
  //     "username":username,
  //     "phone":phone,
  //   };
  // }


  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      fname: fname,
      lname: lname,
      image: image,
      phone: phone,
      batch: batch.toEntity(),
      courses: courses.map((e) => e.toEntity()).toList(),
      username: username,
      password: password ?? '',
    );
  }
}
