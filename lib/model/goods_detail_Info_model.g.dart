// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_detail_Info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsDetailModel _$GoodsDetailModelFromJson(Map<String, dynamic> json) {
  return GoodsDetailModel(
    (json['productList'] as List)
        ?.map((e) => e == null
            ? null
            : GoodsDetailProductList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['attribute'] as List)
        ?.map((e) => e == null
            ? null
            : GoodsDetailAttribute.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['specificationList'] as List)
        ?.map((e) => e == null
            ? null
            : GoodsDetailSpecificationList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['brand'] as Map<String, dynamic>,
    json['share'] as bool,
    json['userHasCollect'] as int,
    json['info'] as Map<String, dynamic>,
    (json['issue'] as List)
        ?.map((e) => e == null
            ? null
            : GoodsDetailIssue.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['shareImage'] as String,
    json['comment'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$GoodsDetailModelToJson(GoodsDetailModel instance) =>
    <String, dynamic>{
      'productList': instance.productList,
      'attribute': instance.attribute,
      'specificationList': instance.specificationList,
      'brand': instance.brand,
      'share': instance.share,
      'userHasCollect': instance.userHasCollect,
      'info': instance.info,
      'issue': instance.issue,
      'shareImage': instance.shareImage,
      'comment': instance.comment,
    };

GoodsDetailComment _$GoodsDetailCommentFromJson(Map<String, dynamic> json) {
  return GoodsDetailComment(
    json['count'] as int,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GoodsDetailCommentData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GoodsDetailCommentToJson(GoodsDetailComment instance) =>
    <String, dynamic>{
      'count': instance.count,
      'data': instance.data,
    };

GoodsDetailInfo _$GoodsDetailInfoFromJson(Map<String, dynamic> json) {
  return GoodsDetailInfo(
    json['detail'] as String,
    json['shareUrl'] as String,
    json['isOnSale'] as bool,
    json['updateTime'] as String,
    json['isHot'] as bool,
    json['isNew'] as bool,
    json['brief'] as String,
    json['brandId'] as int,
    json['goodsSn'] as String,
    (json['retailPrice'] as num)?.toDouble(),
    json['id'] as int,
    json['name'] as String,
    (json['gallery'] as List)?.map((e) => e as String)?.toList(),
    json['addTime'] as String,
    json['sortOrder'] as int,
    json['keywords'] as String,
    json['unit'] as String,
    json['picUrl'] as String,
    json['deleted'] as bool,
    (json['counterPrice'] as num)?.toDouble(),
    json['categoryId'] as int,
  );
}

Map<String, dynamic> _$GoodsDetailInfoToJson(GoodsDetailInfo instance) =>
    <String, dynamic>{
      'detail': instance.detail,
      'shareUrl': instance.shareUrl,
      'isOnSale': instance.isOnSale,
      'updateTime': instance.updateTime,
      'isHot': instance.isHot,
      'isNew': instance.isNew,
      'brief': instance.brief,
      'brandId': instance.brandId,
      'goodsSn': instance.goodsSn,
      'retailPrice': instance.retailPrice,
      'id': instance.id,
      'name': instance.name,
      'gallery': instance.gallery,
      'addTime': instance.addTime,
      'sortOrder': instance.sortOrder,
      'keywords': instance.keywords,
      'unit': instance.unit,
      'picUrl': instance.picUrl,
      'deleted': instance.deleted,
      'counterPrice': instance.counterPrice,
      'categoryId': instance.categoryId,
    };

GoodsDetailBrand _$GoodsDetailBrandFromJson(Map<String, dynamic> json) {
  return GoodsDetailBrand(
    json['sortOrder'] as int,
    json['desc'] as String,
    json['picUrl'] as String,
    json['name'] as String,
    json['deleted'] as bool,
    json['updateTime'] as String,
    json['id'] as int,
    (json['floorPrice'] as num)?.toDouble(),
    json['addTime'] as String,
  );
}

Map<String, dynamic> _$GoodsDetailBrandToJson(GoodsDetailBrand instance) =>
    <String, dynamic>{
      'sortOrder': instance.sortOrder,
      'desc': instance.desc,
      'picUrl': instance.picUrl,
      'name': instance.name,
      'deleted': instance.deleted,
      'updateTime': instance.updateTime,
      'id': instance.id,
      'floorPrice': instance.floorPrice,
      'addTime': instance.addTime,
    };

GoodsDetailProductList _$GoodsDetailProductListFromJson(
    Map<String, dynamic> json) {
  return GoodsDetailProductList(
    json['url'] as String,
    (json['price'] as num)?.toDouble(),
    json['deleted'] as bool,
    json['updateTime'] as String,
    json['id'] as int,
    (json['specifications'] as List)?.map((e) => e as String)?.toList(),
    json['goodsId'] as int,
    json['addTime'] as String,
    json['number'] as int,
  );
}

Map<String, dynamic> _$GoodsDetailProductListToJson(
        GoodsDetailProductList instance) =>
    <String, dynamic>{
      'url': instance.url,
      'price': instance.price,
      'deleted': instance.deleted,
      'updateTime': instance.updateTime,
      'id': instance.id,
      'specifications': instance.specifications,
      'goodsId': instance.goodsId,
      'addTime': instance.addTime,
      'number': instance.number,
    };

GoodsDetailAttribute _$GoodsDetailAttributeFromJson(Map<String, dynamic> json) {
  return GoodsDetailAttribute(
    json['value'] as String,
    json['deleted'] as bool,
    json['updateTime'] as String,
    json['id'] as int,
    json['goodsId'] as int,
    json['addTime'] as String,
    json['attribute'] as String,
  );
}

Map<String, dynamic> _$GoodsDetailAttributeToJson(
        GoodsDetailAttribute instance) =>
    <String, dynamic>{
      'value': instance.value,
      'deleted': instance.deleted,
      'updateTime': instance.updateTime,
      'id': instance.id,
      'goodsId': instance.goodsId,
      'addTime': instance.addTime,
      'attribute': instance.attribute,
    };

GoodsDetailValueList _$GoodsDetailValueListFromJson(Map<String, dynamic> json) {
  return GoodsDetailValueList(
    json['picUrl'] as String,
    json['value'] as String,
    json['deleted'] as bool,
    json['specification'] as String,
    json['id'] as int,
    json['updateTime'] as String,
    json['goodsId'] as int,
    json['addTime'] as String,
  );
}

Map<String, dynamic> _$GoodsDetailValueListToJson(
        GoodsDetailValueList instance) =>
    <String, dynamic>{
      'picUrl': instance.picUrl,
      'value': instance.value,
      'deleted': instance.deleted,
      'specification': instance.specification,
      'id': instance.id,
      'updateTime': instance.updateTime,
      'goodsId': instance.goodsId,
      'addTime': instance.addTime,
    };

GoodsDetailSpecificationList _$GoodsDetailSpecificationListFromJson(
    Map<String, dynamic> json) {
  return GoodsDetailSpecificationList(
    (json['valueList'] as List)
        ?.map((e) => e == null
            ? null
            : GoodsDetailValueList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['name'] as String,
  );
}

Map<String, dynamic> _$GoodsDetailSpecificationListToJson(
        GoodsDetailSpecificationList instance) =>
    <String, dynamic>{
      'valueList': instance.valueList,
      'name': instance.name,
    };

GoodsDetailIssue _$GoodsDetailIssueFromJson(Map<String, dynamic> json) {
  return GoodsDetailIssue(
    json['deleted'] as bool,
    json['updateTime'] as String,
    json['id'] as int,
    json['answer'] as String,
    json['question'] as String,
    json['addTime'] as String,
  );
}

Map<String, dynamic> _$GoodsDetailIssueToJson(GoodsDetailIssue instance) =>
    <String, dynamic>{
      'deleted': instance.deleted,
      'updateTime': instance.updateTime,
      'id': instance.id,
      'answer': instance.answer,
      'question': instance.question,
      'addTime': instance.addTime,
    };

GoodsDetailCommentData _$GoodsDetailCommentDataFromJson(
    Map<String, dynamic> json) {
  return GoodsDetailCommentData(
    json['content'] as String,
    (json['picList'] as List)?.map((e) => e as String)?.toList(),
    json['nickname'] as String,
    json['avatar'] as String,
    json['id'] as int,
    json['addTime'] as String,
  );
}

Map<String, dynamic> _$GoodsDetailCommentDataToJson(
        GoodsDetailCommentData instance) =>
    <String, dynamic>{
      'content': instance.content,
      'picList': instance.picList,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'id': instance.id,
      'addTime': instance.addTime,
    };
