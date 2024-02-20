import 'dart:developer';

import 'package:beachdu/domain/core/api_endpoints/api_endpoints.dart';
import 'package:beachdu/domain/core/failure/failure.dart';
import 'package:beachdu/domain/model/get_base_price_model_responce/get_base_price_model_responce.dart';
import 'package:beachdu/domain/model/get_question_model/get_question_model.dart';
import 'package:beachdu/domain/model/picke_question_model/picke_question_model.dart';
import 'package:beachdu/domain/repository/question_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: QuestionRepo)
@injectable
class QuestionService implements QuestionRepo {
  final _dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));
  @override
  Future<Either<Failure, GetQuestionModel>> getQuestions({
    required String categoryType,
  }) async {
    try {
      final responce =
          await _dio.get('${ApiEndPoints.getquestions}/$categoryType');
      // log('getQuestions data ${responce.data}');
      return Right(GetQuestionModel.fromJson(responce.data));
    } on DioException catch (e) {
      // log('getQuestions DioException error');
      return Left(Failure(message: e.message ?? errorMessage));
    } catch (e) {
      //log('getQuestions catch error');
      return Left(Failure(message: errorMessage));
    }
  }

  @override
  Future<Either<Failure, GetBasePriceModelResponce>> getBasePrice({
    required PickeQuestionModel pickeQuestionModel,
  }) async {
    try {
      log('${pickeQuestionModel.toJson()}');
      final responce = await _dio.post(ApiEndPoints.getBasePrice,
          data: pickeQuestionModel.toJson());
      log('Base price json data ${pickeQuestionModel.toJson()}');
      for (var element in pickeQuestionModel.selectedOptions!) {
        log('getBasePrice pickeQuestionModel for in lopp ${element.toJson()}');
      }
      return Right(GetBasePriceModelResponce.fromJson(responce.data));
    } on DioException catch (e) {
      log('getBasePrice DioException $e');
      return Left(Failure(message: e.message));
    } catch (e) {
      log('getBasePrice catch $e');
      return Left(Failure(message: e.toString()));
    }
  }
}
