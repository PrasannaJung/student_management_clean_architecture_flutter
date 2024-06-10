import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/failure/failure.dart';
import 'package:student_management_starter/features/batch/data/data_source/local/batch_local_datasource.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_starter/features/batch/domain/repository/batch_repository.dart';

final batchLocalRepositoryProvider = Provider<IBatchRepository>((ref) {
  return BatchLocalRepository(
      batchLocalDatasource: ref.read(batchLocalDatasourceProvider));
});

class BatchLocalRepository implements IBatchRepository {
  BatchLocalDatasource batchLocalDatasource;

  BatchLocalRepository({required this.batchLocalDatasource});

  @override
  Future<Either<Failure, bool>> addBatch(BatchEntity batch) {
    return batchLocalDatasource.addBatch(batch);
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getAllBatches() {
    return batchLocalDatasource.getAllBatches();
  }
}
