import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';

final batchApiModelProvider = Provider((ref) => BatchApiModel.empty());

@JsonSerializable()
class BatchApiModel  {
  @JsonKey(name: "_id")
  final String batchId;
  final String batchName;

  BatchApiModel({required this.batchId, required this.batchName});

  // empty constructor
  BatchApiModel.empty() : batchId = '', batchName = '';

  // this function is used to convert the incoming json into the Model
  factory BatchApiModel.fromJson(Map<String, dynamic> json){
    return BatchApiModel(batchId: json["id"], batchName: json["batchName"]);
  }

  // this function is used to return a json data
  Map<String, dynamic> toJson(){
    return {
      "_id":batchId,
      "batchName":batchName
    };
  }


  BatchApiModel fromEntityToModel(BatchEntity entity){
    return BatchApiModel(batchId: entity.batchId ?? '', batchName: entity.batchName);
  }

  // converts a single batch api model to a single batch entity
  BatchEntity toEntity(){
    return BatchEntity(batchName: batchName, batchId: batchId);
  }

  List<BatchEntity> toEntityList(List<BatchApiModel> models) =>
      models.map((model) => model.toEntity()).toList();


}
