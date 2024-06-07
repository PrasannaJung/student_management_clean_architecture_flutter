import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management_starter/app/constants/hive_table_constant.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:uuid/uuid.dart';

// this creates a binary file that will help create an actual table in the hive database since it only understands the binary format
part 'batch_hive_model.g.dart'; // g-> generated file
// to create this file -> dart run build_runner build -d (-d flag is for delete conflicting files)

final batchHiveModelProvider = Provider((ref) { return BatchHiveModel.empty();});

@HiveType(typeId: HiveTableConstant.batchTableId)
class BatchHiveModel {
  @HiveField(0)
  final String? batchId;
  @HiveField(1)
  final String batchName;

//   BatchHiveModel({
//     this.batchId,
//     required this.batchName
// });

  BatchHiveModel({
    String? batchId,
    required this.batchName,
  }) : batchId = batchId ??
            const Uuid()
                .v4(); // hive doesn't auto generate the id so we have to provide it

  BatchHiveModel.empty()
      : batchId = '',
        batchName = '';

  // convert hive object to entity
  BatchEntity toEntity() => BatchEntity(batchName: batchName, batchId: batchId);

// convert the entity to model
  BatchHiveModel fromEntityToModel(BatchEntity entity) =>
      BatchHiveModel(batchName: entity.batchName, batchId: entity.batchId);

// convert the data coming from hive db in the list format to list of entities
  List<BatchEntity> toEntityList(List<BatchHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();
}
