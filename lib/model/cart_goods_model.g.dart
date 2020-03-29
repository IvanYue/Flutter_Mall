// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_goods_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartGoodsModel _$CartGoodsModelFromJson(Map<String, dynamic> json) {
  return CartGoodsModel(
    json['name'] as String,
    (json['price'] as num)?.toDouble(),
    json['id'] as int,
    json['count'] as String,
    json['imag'] as String,
    json['selected'] as bool,
  );
}

Map<String, dynamic> _$CartGoodsModelToJson(CartGoodsModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'id': instance.id,
      'count': instance.count,
      'imag': instance.imag,
      'selected': instance.selected,
    };
