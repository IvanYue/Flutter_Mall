import 'package:json_annotation/json_annotation.dart';

part 'cateory_model.g.dart';


class CategoryListModel{
  List<CateoryModel> itemList;
  CategoryListModel(this.itemList);
  factory CategoryListModel.fromJson(List<dynamic> itemJson){
    List<CateoryModel> list ;
    list= itemJson.map((e)=>CateoryModel.fromJson(e)).toList();
    return CategoryListModel(list); 
  } 
}


@JsonSerializable()
class CateoryModel extends Object {

	@JsonKey(name: 'pid')
	int pid;

	@JsonKey(name: 'iconUrl')
	String iconUrl;

	@JsonKey(name: 'addTime')
	String addTime;

	@JsonKey(name: 'desc')
	String desc;

	@JsonKey(name: 'picUrl')
	String picUrl;

	@JsonKey(name: 'name')
	String name;

	@JsonKey(name: 'level')
	String level;

	@JsonKey(name: 'id')
	int id;

	@JsonKey(name: 'sortOrder')
	int sortOrder;

	@JsonKey(name: 'updateTime')
	String updateTime;

	@JsonKey(name: 'deleted')
	bool deleted;

	@JsonKey(name: 'keywords')
	String keywords;

	CateoryModel(this.pid,this.iconUrl,this.addTime,this.desc,this.picUrl,this.name,this.level,this.id,this.sortOrder,this.updateTime,this.deleted,this.keywords,);

	factory CateoryModel.fromJson(Map<String, dynamic> srcJson) => _$CateoryModelFromJson(srcJson);

	Map<String, dynamic> toJson() => _$CateoryModelToJson(this);

}
