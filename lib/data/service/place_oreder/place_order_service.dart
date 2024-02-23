import 'dart:developer';

import 'package:beachdu/data/secure_storage/secure_fire_store.dart';
import 'package:beachdu/domain/core/api_endpoints/api_endpoints.dart';
import 'package:beachdu/domain/core/failure/failure.dart';
import 'package:beachdu/domain/model/place_order/promo_code_request_model/promo_code_request_model.dart';
import 'package:beachdu/domain/model/place_order/promo_code_responce_model/promo_code_responce_model.dart';
import 'package:beachdu/domain/repository/place_order.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PlaceOrderRepo)
@singleton
class PlaceOrderService implements PlaceOrderRepo {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));
  @override
  Future<Either<Failure, PromoCodeResponceModel>> getPomoCode({
    required PromoCodeRequestModel promoCodeRequestModel,
  }) async {
    try {
      final accessToken =
          await SecureSotrage.getToken().then((token) => token.accessToken);
      _dio.options.headers.addAll(
        {
          'authorization': "Bearer $accessToken",
        },
      );
      log('accessToken $accessToken');
      log('promoCodeRequestModel ${promoCodeRequestModel.toJson()}');
      final responce = await _dio.post(
        ApiEndPoints.getPromoCode,
        data: promoCodeRequestModel.toJson(),
      );

      log('getPomoCode data ${responce.data}');
      return Right(PromoCodeResponceModel.fromJson(responce.data));
    } on DioException catch (e) {
      log('getPomoCode DioException $e');
      return Left(Failure(message: e.message ?? errorMessage));
    } catch (e) {
      log('getPomoCode catch $e');
      return Left(Failure(message: e.toString()));
    }
  }
}