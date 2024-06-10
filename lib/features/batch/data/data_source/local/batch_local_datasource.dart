import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/failure/failure.dart';
import 'package:student_management_starter/core/networking/local/hive_service.dart';
import 'package:student_management_starter/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';

final batchLocalDatasourceProvider = Provider(
  (ref) => BatchLocalDatasource(
    hiveService: ref.read(hiveServiceProvider),
    batchHiveModel: ref.read(batchHiveModelProvider),
  ),
);

class BatchLocalDatasource {
  final HiveService hiveService;
  final BatchHiveModel batchHiveModel;

  BatchLocalDatasource(
      {required this.hiveService, required this.batchHiveModel});


  Future<Either<Failure,bool>> addBatch(BatchEntity batch) async{
    try{
      final hiveBatch = batchHiveModel.fromEntityToModel(batch); // converting the batch entity to batch mode
      await hiveService.addBatch(hiveBatch); // adding the converted model into the local storage
      return const Right(true);
    }catch(e){
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure,List<BatchEntity>>> getAllBatches() async {
    try{
      final allHiveBatches = await hiveService.getAllBatches(); // getting the batches from the storage which comes in model form
      final allBatchesEntity = batchHiveModel.toEntityList(allHiveBatches); // converting the list of models into list of entities
      return Right(allBatchesEntity);
  }catch(e){
      return Left(Failure(error: e.toString()));
  }
}


}
