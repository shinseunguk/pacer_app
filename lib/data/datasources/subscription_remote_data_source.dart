import 'package:dio/dio.dart';

import '../../core/network/api_paths.dart';
import '../models/entitlement_model.dart';

class SubscriptionRemoteDataSource {
  const SubscriptionRemoteDataSource(this._dio);

  final Dio _dio;

  Future<EntitlementModel> getEntitlement() async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiPaths.myEntitlement,
    );
    return EntitlementModel.fromJson(response.data ?? const {});
  }

  Future<EntitlementModel> verify({
    required String platform,
    required String receipt,
    required String productId,
  }) {
    return _post(ApiPaths.verifyPurchase, platform, receipt, productId);
  }

  Future<EntitlementModel> restore({
    required String platform,
    required String receipt,
    required String productId,
  }) {
    return _post(ApiPaths.restorePurchase, platform, receipt, productId);
  }

  Future<EntitlementModel> _post(
    String path,
    String platform,
    String receipt,
    String productId,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      path,
      data: {'platform': platform, 'receipt': receipt, 'productId': productId},
    );
    return EntitlementModel.fromJson(response.data ?? const {});
  }
}
