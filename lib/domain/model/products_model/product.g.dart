// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['_id'] as String?,
      productImage: json['productImage'] as String?,
      basePrice: json['basePrice'] as int?,
      estimatedPrice: json['estimatedPrice'] as int?,
      variant: json['variant'] as String?,
      model: json['model'] as String?,
      brandName: json['brandName'] as String?,
      seriesName: json['seriesName'] as String?,
      categoryType: json['categoryType'] as String?,
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'productImage': instance.productImage,
      'basePrice': instance.basePrice,
      'estimatedPrice': instance.estimatedPrice,
      'variant': instance.variant,
      'model': instance.model,
      'brandName': instance.brandName,
      'seriesName': instance.seriesName,
      'categoryType': instance.categoryType,
      '__v': instance.v,
    };
