import 'package:json_annotation/json_annotation.dart';

part 'goods_model.g.dart';


@JsonSerializable()
class GoodsModelData extends Object {

	@JsonKey(name: 'list')
	List<GoodsModelList> list;

	@JsonKey(name: 'total')
	int total;

	@JsonKey(name: 'filterCategoryList')
	List<GoodsModelFilterCategoryList> filterCategoryList;

	@JsonKey(name: 'pages')
	int pages;

	@JsonKey(name: 'page')
	int page;

	@JsonKey(name: 'limit')
	int limit;

	GoodsModelData(this.list,this.total,this.filterCategoryList,this.pages,this.page,this.limit,);

	factory GoodsModelData.fromJson(Map<String, dynamic> srcJson) => _$GoodsModelDataFromJson(srcJson);

	Map<String, dynamic> toJson() => _$GoodsModelDataToJson(this);

}

@JsonSerializable()
class GoodsModelList extends Object {

	@JsonKey(name: 'isNew')
	bool isNew;

	@JsonKey(name: 'id')
	int id;

	@JsonKey(name: 'counterPrice')
	double counterPrice;

	@JsonKey(name: 'picUrl')
	String picUrl;

	@JsonKey(name: 'name')
	String name;

	@JsonKey(name: 'retailPrice')
	double retailPrice;

	@JsonKey(name: 'isHot')
	bool isHot;

	@JsonKey(name: 'brief')
	String brief;

	GoodsModelList(this.isNew,this.id,this.counterPrice,this.picUrl,this.name,this.retailPrice,this.isHot,this.brief,);

	factory GoodsModelList.fromJson(Map<String, dynamic> srcJson) => _$GoodsModelListFromJson(srcJson);

	Map<String, dynamic> toJson() => _$GoodsModelListToJson(this);

}

@JsonSerializable()
class GoodsModelFilterCategoryList extends Object {

	@JsonKey(name: 'desc')
	String desc;

	@JsonKey(name: 'sortOrder')
	int sortOrder;

	@JsonKey(name: 'name')
	String name;

	@JsonKey(name: 'updateTime')
	String updateTime;

	@JsonKey(name: 'addTime')
	String addTime;

	@JsonKey(name: 'deleted')
	bool deleted;

	@JsonKey(name: 'iconUrl')
	String iconUrl;

	@JsonKey(name: 'level')
	String level;

	@JsonKey(name: 'keywords')
	String keywords;

	@JsonKey(name: 'picUrl')
	String picUrl;

	@JsonKey(name: 'id')
	int id;

	@JsonKey(name: 'pid')
	int pid;

	GoodsModelFilterCategoryList(this.desc,this.sortOrder,this.name,this.updateTime,this.addTime,this.deleted,this.iconUrl,this.level,this.keywords,this.picUrl,this.id,this.pid,);

	factory GoodsModelFilterCategoryList.fromJson(Map<String, dynamic> srcJson) => _$GoodsModelFilterCategoryListFromJson(srcJson);

	Map<String, dynamic> toJson() => _$GoodsModelFilterCategoryListToJson(this);

}
