import 'dart:developer';
import 'package:beachdu/data/pdf_generator.dart';
import 'package:beachdu/data/secure_storage/secure_fire_store.dart';
import 'package:beachdu/domain/core/api_endpoints/api_endpoints.dart';
import 'package:beachdu/domain/core/failure/failure.dart';
import 'package:beachdu/domain/model/date_tome_responce_model/date_tome_responce_model.dart';
import 'package:beachdu/domain/model/order_model/get_all_order_responce_model/get_all_order_responce_model.dart';
import 'package:beachdu/domain/model/order_model/order_cancelation_request_model/order_cancelation_request_model.dart';
import 'package:beachdu/domain/model/order_model/order_cancelation_responce_model/order_cancelation_responce_model.dart';
import 'package:beachdu/domain/model/order_model/order_placed_request_model/order_placed_request_model.dart';
import 'package:beachdu/domain/model/order_model/order_placed_responce_model/order_placed_responce_model.dart';
import 'package:beachdu/domain/model/promo_code_model/promo_code_request_model/promo_code_request_model.dart';
import 'package:beachdu/domain/model/promo_code_model/promo_code_responce_model/promo_code_responce_model.dart';
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
      final responce = await _dio.post(
        ApiEndPoints.getPromoCode,
        data: promoCodeRequestModel.toJson(),
      );
      return Right(PromoCodeResponceModel.fromJson(responce.data));
    } on DioException catch (e) {
      //log('getPomoCode DioException $e');
      return Left(Failure(message: e.response?.data['error'] ?? errorMessage));
    } catch (e) {
      // log('getPomoCode catch $e');
      return Left(Failure(message: errorMessage));
    }
  }

  @override
  Future<Either<Failure, OrderPlacedResponceModel>> orderPlacing({
    required OrderPlacedRequestModel orderPlacedRequestModel,
  }) async {
    try {
      final accessToken =
          await SecureSotrage.getToken().then((token) => token.accessToken);
      _dio.options.headers.addAll(
        {
          'authorization': "Bearer $accessToken",
        },
      );
      log('orderPlacing ${orderPlacedRequestModel.toJson()}');
      final responce = await _dio.post(
        ApiEndPoints.orderPlacing,
        data: orderPlacedRequestModel.toJson(),
      );
      return Right(OrderPlacedResponceModel.fromJson(responce.data));
    } on DioException catch (e) {
      return Left(Failure(message: e.response?.data['error'] ?? errorMessage));
    } catch (e) {
      return Left(Failure(message: errorMessage));
    }
  }

  @override
  Future<Either<Failure, GetAllOrderResponceModel>> getOrders() async {
    try {
      final number = await SecureSotrage.getNumber();
      final accessToken =
          await SecureSotrage.getToken().then((token) => token.accessToken);
      _dio.options.headers.addAll(
        {
          'authorization': "Bearer $accessToken",
        },
      );

      final responce =
          await _dio.get(ApiEndPoints.getOrders.replaceAll('{number}', number));

      return Right(GetAllOrderResponceModel.fromJson(responce.data));
    } on DioException catch (e) {
      log('getOrders DioException $e');
      return Left(Failure(message: errorMessage));
    } catch (e) {
      log('getOrders catch $e');
      return Left(Failure(message: errorMessage));
    }
  }

  @override
  Future<Either<Failure, OrderCancelationResponceModel>> orderCancel({
    required OrderCancelationRequestModel orderCancelationRequestModel,
    required String orderId,
  }) async {
    try {
      final accessToken =
          await SecureSotrage.getToken().then((token) => token.accessToken);
      _dio.options.headers.addAll(
        {
          'authorization': "Bearer $accessToken",
        },
      );

      final responce = await _dio.put(
        ApiEndPoints.orderCancel.replaceAll(
          '{order_id}',
          orderId,
        ),
        data: orderCancelationRequestModel.toJson(),
      );
      log(_dio.options.headers.toString());

      return Right(OrderCancelationResponceModel.fromJson(responce.data));
    } on DioException catch (e) {
      log('orderCancel DioException $e');
      return Left(Failure(message: e.response?.data['error'] ?? errorMessage));
    } catch (e) {
      log('orderCancel catch $e');
      return Left(Failure(message: errorMessage));
    }
  }

  @override
  Future<Either<Failure, DateTomeResponceModel>> getDateTime() async {
    try {
      final responce = await _dio.get(
        ApiEndPoints.dateTime,
      );

      return Right(DateTomeResponceModel.fromJson(responce.data));
    } on DioException catch (e) {
      log('getDateTime DioException $e');
      return Left(Failure(message: e.response?.data['error'] ?? errorMessage));
    } catch (e) {
      log('getDateTime catch $e');
      return Left(Failure(message: errorMessage));
    }
  }

  @override
  Future<Either<Failure, String>> invoiceDownLoad({
    required String orderId,
    required String number,
  }) async {
    try {
      // Request storage permission
      final permissionGranted = await takePermission();
      if (!permissionGranted) {
        return Left(Failure(message: 'Storage denied'));
      } else {
        final accessToken =
            await SecureSotrage.getToken().then((token) => token.accessToken);
        _dio.options.headers.addAll({'authorization': "Bearer $accessToken"});

        final url = ApiEndPoints.invoiceDownLoad
            .replaceAll('{order_id}', orderId)
            .replaceAll('{number}', number);

        final response = await _dio.get(
          url,
          data: {"orderID": orderId},
        );

        if (response.statusCode == 200) {
          return Right(response.data);
        } else {
          const errorMessage = 'Download failed';
          return Left(Failure(message: errorMessage));
        }
      }
    } on DioException catch (e) {
      log('invoiceDownLoad DioError: ${e.message}');
      return Left(Failure(message: 'Network error'));
    } catch (e) {
      log('invoiceDownLoad catch: $e');
      return Left(Failure(message: 'Unexpected error'));
    }
  }

  @override
  Future<void> downloadInvoice(
      {required String orderId, required String number}) async {
    try {
      // Request storage permission
      final permissionGranted = await takePermission();
      if (!permissionGranted) {
        log('Storage permission denied. Download cannot proceed.');
        return;
      } else {
        final accessToken =
            await SecureSotrage.getToken().then((token) => token.accessToken);
        _dio.options.headers.addAll({'authorization': "Bearer $accessToken"});

        final url = ApiEndPoints.invoiceDownLoad
            .replaceAll('{order_id}', orderId)
            .replaceAll('{number}', number);

        final response = await _dio.get(url,
            data: {"orderID": orderId},
            options: Options(responseType: ResponseType.bytes));

        if (response.statusCode == 200) {
          final pdfBytes = List<int>.from(response.data);
          await downloadPDFBuffer(pdfBytes, 'invoice.pdf');
          log('Invoice downloaded successfully!');
        } else {
          const errorMessage = 'Download failed';
          log(errorMessage);
        }
      }
    } on DioException catch (e) {
      log('invoiceDownLoad DioError: ${e.message}');
    } catch (e) {
      log('invoiceDownLoad catch: $e');
    }
  }
}
