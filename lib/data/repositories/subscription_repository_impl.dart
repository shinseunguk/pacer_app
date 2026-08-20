import 'package:dio/dio.dart';

import '../../core/error/error_mapper.dart';
import '../../domain/entities/entitlement.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../datasources/subscription_remote_data_source.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  const SubscriptionRepositoryImpl(this._remote);

  final SubscriptionRemoteDataSource _remote;

  @override
  Future<Entitlement> getEntitlement() async {
    try {
      final model = await _remote.getEntitlement();
      return model.toEntity();
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }

  @override
  Future<Entitlement> verify({
    required String platform,
    required String receipt,
    required String productId,
  }) async {
    try {
      final model = await _remote.verify(
        platform: platform,
        receipt: receipt,
        productId: productId,
      );
      return model.toEntity();
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }

  @override
  Future<Entitlement> restore({
    required String platform,
    required String receipt,
    required String productId,
  }) async {
    try {
      final model = await _remote.restore(
        platform: platform,
        receipt: receipt,
        productId: productId,
      );
      return model.toEntity();
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }
}
