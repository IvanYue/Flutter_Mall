import 'package:json_annotation/json_annotation.dart';

part 'goods_detail_Info_model.g.dart';

@JsonSerializable()
class GoodsDetailModel extends Object {

	@JsonKey(name: 'productList')
	List<GoodsDetailProductList> productList;

	@JsonKey(name: 'attribute')
	List<GoodsDetailAttribute> attribute;

	@JsonKey(name: 'specificationList')
	List<GoodsDetailSpecificationList> specificationList;

	@JsonKey(name: 'brand')
	Map<String,dynamic> brand;

	@JsonKey(name: 'share')
	bool share;

	@JsonKey(name: 'userHasCollect')
	int userHasCollect;

	@JsonKey(name: 'info')
	Map<String,dynamic> info;

	@JsonKey(name: 'issue')
	List<GoodsDetailIssue> issue;

	@JsonKey(name: 'shareImage')
	String shareImage;

	@JsonKey(name: 'comment')
	Map<String,dynamic> comment;

	GoodsDetailModel(this.productList,this.attribute,this.specificationList,this.brand,this.share,this.userHasCollect,this.info,this.issue,this.shareImage,this.comment,);

	factory GoodsDetailModel.fromJson(Map<String, dynamic> srcJson) => _$GoodsDetailModelFromJson(srcJson);

	Map<String, dynamic> toJson() => _$GoodsDetailModelToJson(this);

}

@JsonSerializable()
class GoodsDetailComment extends Object {

	@JsonKey(name: 'count')
	int count;

	@JsonKey(name: 'data')
	List<GoodsDetailCommentData> data;

	GoodsDetailComment(this.count,this.data,);

	factory GoodsDetailComment.fromJson(Map<String, dynamic> srcJson) => _$GoodsDetailCommentFromJson(srcJson);

	Map<String, dynamic> toJson() => _$GoodsDetailCommentToJson(this);

}

@JsonSerializable()
class GoodsDetailInfo extends Object {

	@JsonKey(name: 'detail')
	String detail;

	@JsonKey(name: 'shareUrl')
	String shareUrl;

	@JsonKey(name: 'isOnSale')
	bool isOnSale;

	@JsonKey(name: 'updateTime')
	String updateTime;

	@JsonKey(name: 'isHot')
	bool isHot;

	@JsonKey(name: 'isNew')
	bool isNew;

	@JsonKey(name: 'brief')
	String brief;

	@JsonKey(name: 'brandId')
	int brandId;

	@JsonKey(name: 'goodsSn')
	String goodsSn;

	@JsonKey(name: 'retailPrice')
	double retailPrice;

	@JsonKey(name: 'id')
	int id;

	@JsonKey(name: 'name')
	String name;

	@JsonKey(name: 'gallery')
	List<String> gallery;

	@JsonKey(name: 'addTime')
	String addTime;

	@JsonKey(name: 'sortOrder')
	int sortOrder;

	@JsonKey(name: 'keywords')
	String keywords;

	@JsonKey(name: 'unit')
	String unit;

	@JsonKey(name: 'picUrl')
	String picUrl;

	@JsonKey(name: 'deleted')
	bool deleted;

	@JsonKey(name: 'counterPrice')
	double counterPrice;

	@JsonKey(name: 'categoryId')
	int categoryId;

	GoodsDetailInfo(this.detail,this.shareUrl,this.isOnSale,this.updateTime,this.isHot,this.isNew,this.brief,this.brandId,this.goodsSn,this.retailPrice,this.id,this.name,this.gallery,this.addTime,this.sortOrder,this.keywords,this.unit,this.picUrl,this.deleted,this.counterPrice,this.categoryId,);

	factory GoodsDetailInfo.fromJson(Map<String, dynamic> srcJson) => _$GoodsDetailInfoFromJson(srcJson);

	Map<String, dynamic> toJson() => _$GoodsDetailInfoToJson(this);

}

@JsonSerializable()
class GoodsDetailBrand extends Object {

	@JsonKey(name: 'sortOrder')
	int sortOrder;

	@JsonKey(name: 'desc')
	String desc;

	@JsonKey(name: 'picUrl')
	String picUrl;

	@JsonKey(name: 'name')
	String name;

	@JsonKey(name: 'deleted')
	bool deleted;

	@JsonKey(name: 'updateTime')
	String updateTime;

	@JsonKey(name: 'id')
	int id;

	@JsonKey(name: 'floorPrice')
	double floorPrice;

	@JsonKey(name: 'addTime')
	String addTime;

	GoodsDetailBrand(this.sortOrder,this.desc,this.picUrl,this.name,this.deleted,this.updateTime,this.id,this.floorPrice,this.addTime,);

	factory GoodsDetailBrand.fromJson(Map<String, dynamic> srcJson) => _$GoodsDetailBrandFromJson(srcJson);

	Map<String, dynamic> toJson() => _$GoodsDetailBrandToJson(this);

}

@JsonSerializable()
class GoodsDetailProductList extends Object {

	@JsonKey(name: 'url')
	String url;

	@JsonKey(name: 'price')
	double price;

	@JsonKey(name: 'deleted')
	bool deleted;

	@JsonKey(name: 'updateTime')
	String updateTime;

	@JsonKey(name: 'id')
	int id;

	@JsonKey(name: 'specifications')
	List<String> specifications;

	@JsonKey(name: 'goodsId')
	int goodsId;

	@JsonKey(name: 'addTime')
	String addTime;

	@JsonKey(name: 'number')
	int number;

	GoodsDetailProductList(this.url,this.price,this.deleted,this.updateTime,this.id,this.specifications,this.goodsId,this.addTime,this.number,);

	factory GoodsDetailProductList.fromJson(Map<String, dynamic> srcJson) => _$GoodsDetailProductListFromJson(srcJson);

	Map<String, dynamic> toJson() => _$GoodsDetailProductListToJson(this);

}

@JsonSerializable()
class GoodsDetailAttribute extends Object {

	@JsonKey(name: 'value')
	String value;

	@JsonKey(name: 'deleted')
	bool deleted;

	@JsonKey(name: 'updateTime')
	String updateTime;

	@JsonKey(name: 'id')
	int id;

	@JsonKey(name: 'goodsId')
	int goodsId;

	@JsonKey(name: 'addTime')
	String addTime;

	@JsonKey(name: 'attribute')
	String attribute;

	GoodsDetailAttribute(this.value,this.deleted,this.updateTime,this.id,this.goodsId,this.addTime,this.attribute,);

	factory GoodsDetailAttribute.fromJson(Map<String, dynamic> srcJson) => _$GoodsDetailAttributeFromJson(srcJson);

	Map<String, dynamic> toJson() => _$GoodsDetailAttributeToJson(this);

}

@JsonSerializable()
class GoodsDetailValueList extends Object {

	@JsonKey(name: 'picUrl')
	String picUrl;

	@JsonKey(name: 'value')
	String value;

	@JsonKey(name: 'deleted')
	bool deleted;

	@JsonKey(name: 'specification')
	String specification;

	@JsonKey(name: 'id')
	int id;

	@JsonKey(name: 'updateTime')
	String updateTime;

	@JsonKey(name: 'goodsId')
	int goodsId;

	@JsonKey(name: 'addTime')
	String addTime;

	GoodsDetailValueList(this.picUrl,this.value,this.deleted,this.specification,this.id,this.updateTime,this.goodsId,this.addTime,);

	factory GoodsDetailValueList.fromJson(Map<String, dynamic> srcJson) => _$GoodsDetailValueListFromJson(srcJson);

	Map<String, dynamic> toJson() => _$GoodsDetailValueListToJson(this);

}

@JsonSerializable()
class GoodsDetailSpecificationList extends Object {

	@JsonKey(name: 'valueList')
	List<GoodsDetailValueList> valueList;

	@JsonKey(name: 'name')
	String name;

	GoodsDetailSpecificationList(this.valueList,this.name,);

	factory GoodsDetailSpecificationList.fromJson(Map<String, dynamic> srcJson) => _$GoodsDetailSpecificationListFromJson(srcJson);

	Map<String, dynamic> toJson() => _$GoodsDetailSpecificationListToJson(this);

}

@JsonSerializable()
class GoodsDetailIssue extends Object {

	@JsonKey(name: 'deleted')
	bool deleted;

	@JsonKey(name: 'updateTime')
	String updateTime;

	@JsonKey(name: 'id')
	int id;

	@JsonKey(name: 'answer')
	String answer;

	@JsonKey(name: 'question')
	String question;

	@JsonKey(name: 'addTime')
	String addTime;

	GoodsDetailIssue(this.deleted,this.updateTime,this.id,this.answer,this.question,this.addTime,);

	factory GoodsDetailIssue.fromJson(Map<String, dynamic> srcJson) => _$GoodsDetailIssueFromJson(srcJson);

	Map<String, dynamic> toJson() => _$GoodsDetailIssueToJson(this);

}

@JsonSerializable()
class GoodsDetailCommentData extends Object {

	@JsonKey(name: 'content')
	String content;

	@JsonKey(name: 'picList')
	List<String> picList;

	@JsonKey(name: 'nickname')
	String nickname;

	@JsonKey(name: 'avatar')
	String avatar;

	@JsonKey(name: 'id')
	int id;

	@JsonKey(name: 'addTime')
	String addTime;

	GoodsDetailCommentData(this.content,this.picList,this.nickname,this.avatar,this.id,this.addTime,);

	factory GoodsDetailCommentData.fromJson(Map<String, dynamic> srcJson) => _$GoodsDetailCommentDataFromJson(srcJson);

	Map<String, dynamic> toJson() => _$GoodsDetailCommentDataToJson(this);

}
