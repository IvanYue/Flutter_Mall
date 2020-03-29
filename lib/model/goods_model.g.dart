// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsModelData _$GoodsModelDataFromJson(Map<String, dynamic> json) {
  return GoodsModelData(
    (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : GoodsModelList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['total'] as int,
    (json['filterCategoryList'] as List)
        ?.map((e) => e == null
            ? null
            : GoodsModelFilterCategoryList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['pages'] as int,
    json['page'] as int,
    json['limit'] as int,
  );
}

Map<String, dynamic> _$GoodsModelDataToJson(GoodsModelData instance) =>
    <String, dynamic>{
      'list': instance.list,
      'total': instance.total,
      'filterCategoryList': instance.filterCategoryList,
      'pages': instance.pages,
      'page': instance.page,
      'limit': instance.limit,
    };

GoodsModelList _$GoodsModelListFromJson(Map<String, dynamic> json) {
  return GoodsModelList(
    json['isNew'] as bool,
    json['id'] as int,
    (json['counterPrice'] as num)?.toDouble(),
    json['picUrl'] as String,
    json['name'] as String,
    (json['retailPrice'] as num)?.toDouble(),
    json['isHot'] as bool,
    json['brief'] as String,
  );
}

Map<String, dynamic> _$GoodsModelListToJson(GoodsModelList instance) =>
    <String, dynamic>{
      'isNew': instance.isNew,
      'id': instance.id,
      'counterPrice': instance.counterPrice,
      'picUrl': instance.picUrl,
      'name': instance.name,
      'retailPrice': instance.retailPrice,
      'isHot': instance.isHot,
      'brief': instance.brief,
    };

GoodsModelFilterCategoryList _$GoodsModelFilterCategoryListFromJson(
    Map<String, dynamic> json) {
  return GoodsModelFilterCategoryList(
    json['desc'] as String,
    json['sortOrder'] as int,
    json['name'] as String,
    json['updateTime'] as String,
    json['addTime'] as String,
    json['deleted'] as bool,
    json['iconUrl'] as String,
    json['level'] as String,
    json['keywords'] as String,
    json['picUrl'] as String,
    json['id'] as int,
    json['pid'] as int,
  );
}

Map<String, dynamic> _$GoodsModelFilterCategoryListToJson(
        GoodsModelFilterCategoryList instance) =>
    <String, dynamic>{
      'desc': instance.desc,
      'sortOrder': instance.sortOrder,
      'name': instance.name,
      'updateTime': instance.updateTime,
      'addTime': instance.addTime,
      'deleted': instance.deleted,
      'iconUrl': instance.iconUrl,
      'level': instance.level,
      'keywords': instance.keywords,
      'picUrl': instance.picUrl,
      'id': instance.id,
      'pid': instance.pid,
    };
