// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cateory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CateoryModel _$CateoryModelFromJson(Map<String, dynamic> json) {
  return CateoryModel(
    json['pid'] as int,
    json['iconUrl'] as String,
    json['addTime'] as String,
    json['desc'] as String,
    json['picUrl'] as String,
    json['name'] as String,
    json['level'] as String,
    json['id'] as int,
    json['sortOrder'] as int,
    json['updateTime'] as String,
    json['deleted'] as bool,
    json['keywords'] as String,
  );
}

Map<String, dynamic> _$CateoryModelToJson(CateoryModel instance) =>
    <String, dynamic>{
      'pid': instance.pid,
      'iconUrl': instance.iconUrl,
      'addTime': instance.addTime,
      'desc': instance.desc,
      'picUrl': instance.picUrl,
      'name': instance.name,
      'level': instance.level,
      'id': instance.id,
      'sortOrder': instance.sortOrder,
      'updateTime': instance.updateTime,
      'deleted': instance.deleted,
      'keywords': instance.keywords,
    };
