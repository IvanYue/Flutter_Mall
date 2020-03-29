// 分类列表
class CategoryFistItemModel{
    int     id;
    String  name;
    String  keywords;
    String  desc;
    int     pid;
    String  iconUrl;
    String  picUrl;
    String  level;
    int     sortOrder;
    String  addTime;
    String  updateTime;
    bool    deleted;
    
 // 声明一个和类名相同的函数，来作为类的构造函数。
  // this关键字指向了当前类的实例, 上面的代码可以简化为：
CategoryFistItemModel({
  this.id,
  this.name,
  this.keywords,
  this.desc,
  this.pid,
  this.iconUrl,
  this.level,
  this.sortOrder,
  this.addTime,
  this.updateTime,
  this.deleted}
);

//工厂模式-用这种模式可以省略New关键字
factory CategoryFistItemModel.fromJson(dynamic json){
  return CategoryFistItemModel(
    id: json['id'],
    name: json['name'],
    keywords: json['keywords'],
    desc: json['desc'],
    pid: json['pid'],
    iconUrl: json['iconUrl'],
    level: json['level'],
    sortOrder: json['sortOrder'],
    addTime: json['addTime'],
    updateTime: json['updateTime'],
    deleted: json['deleted']
  );
}

}

class ResponseModel{
  List<CategoryFistItemModel> data;
  String errmsg;
  int errno;
  ResponseModel({this.data,this.errmsg,this.errno});
  factory ResponseModel.fromjson(dynamic json){
    ResponseModel model =  ResponseModel(
      data: json['data'].map((item)=>CategoryFistItemModel.fromJson(item)).toList(),
      errmsg: json['errmsg'],
      errno: json['errno']
      );

      return model;
  }
}
