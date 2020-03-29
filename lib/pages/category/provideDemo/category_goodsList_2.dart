import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mall_litemall_demo/model/cateory_model.dart';
import 'package:provide/provide.dart';
import '../../../service/service_method.dart';
import '../../../model/goods_model.dart';
import '../../../provide/category_provide.dart';

class CategoryTopListGoodsWidget extends StatefulWidget {

  CategoryTopListGoodsWidget({Key key,}) : super(key: key);

  @override
  _CategoryTopListGoodsWidgetState createState() =>
      _CategoryTopListGoodsWidgetState();
}

class _CategoryTopListGoodsWidgetState
    extends State<CategoryTopListGoodsWidget> {
  List<CateoryModel> _categoryList;

  List<GoodsModelList> _goodList = [];
  int _selectdIndex = 0;
  int _secondCategoryPid;
  int _page;
  
  void _getGoodsList() {
     getCatrgoryGoodsList(
      _categoryList[_selectdIndex].id,1,
      (onSuccessList) {
        setState(() {
          _goodList = onSuccessList;
        });
      },
      onFail: (message) {
        print('>>>>>>>>>>>>>>>message:${message}');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        _topCategoryNavListView(),
        Expanded(child: _goodListWidget())
      ],
    ));
  }

//顶部分类导航
  Widget _rightInWellItem(CateoryModel item, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectdIndex = index;
          _getGoodsList();
        });
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: _selectdIndex == index
                        ? Colors.red
                        : Colors.transparent,
                    width: 2))),
        // width: ScreenUtil().setWidth(150),
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Text(
          item.name,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: _selectdIndex == index ? Colors.red : Colors.black),
        ),
        alignment: Alignment.center,
      ),
    );
  }

  Widget _topCategoryNavListView() {
    return Provide<CategoryProvide>(
      builder: (context, child, categoryProvide) {
        if(categoryProvide.secondCategoryModelList[0].pid != _secondCategoryPid){
          _page = 1;
          _selectdIndex = 0;
          _secondCategoryPid = categoryProvide.secondCategoryModelList[0].pid;
          _categoryList =  categoryProvide.secondCategoryModelList;
          _getGoodsList();
        }
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(ScreenUtil.screenWidth * .8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              
              return _rightInWellItem(
                  categoryProvide.secondCategoryModelList[index], index);
            },
            itemCount: categoryProvide.secondCategoryModelList.length,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(color: Colors.black12, width: 0.5))),
        );
      },
    );
  }

//商品列表
  Widget _goodListWidget() {
    if(_goodList.length==0){
      return Center(child:Text('暂无数据'));
    }
    return Container(
        height: ScreenUtil().setHeight(ScreenUtil.screenHeight - 80),
        child: GridView.count(
          childAspectRatio:.8,
          crossAxisCount:2,
          children: _goodList.map((e) {
            return _goodsItem(e);
          }).toList(),
        ));
  }

  Widget _goodsItem(GoodsModelList item) {
    return Container(
        child: Column(
          children: [
      Container(child:Image.network(item.picUrl,),width:ScreenUtil().setWidth(220),height: ScreenUtil().setHeight(230),),
      Expanded(child: Text('${item.name}',style: TextStyle(fontSize:ScreenUtil().setSp(25)),maxLines: 1,),),
      Expanded(child: Text('￥${item.retailPrice}',style: TextStyle(fontSize:ScreenUtil().setSp(25),color: Colors.red)))
    ]));
  }
}
