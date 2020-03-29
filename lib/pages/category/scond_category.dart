import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mall_litemall_demo/provide/category_provide.dart';
import 'package:mall_litemall_demo/utils/navigator_util.dart';
import 'package:mall_litemall_demo/widget/loading_dialog.dart';
import 'package:provide/provide.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../model/cateory_model.dart';
import '../../service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/goods_model.dart';
import '../../config/custom_refrsh_widget.dart';

class SecondCatrgoryGoodList extends StatefulWidget {
  List<CateoryModel> categoryModelList=[];
  CateoryModel firstCategoryModel;

  SecondCatrgoryGoodList(
      {Key key, this.firstCategoryModel, this.categoryModelList})
      : super(key: key);

  @override
  _SecondCatrgoryGoodListState createState() => _SecondCatrgoryGoodListState();
}

class _SecondCatrgoryGoodListState extends State<SecondCatrgoryGoodList> {
  int _selectedIndex = 0;
  List<GoodsModelList> _goodList = [];
  List<CateoryModel> _secondCategoryModelList=[];
  int _page = 1;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    // if (widget.categoryModelList==null||widget.categoryModelList.length==0) {
    //   _getSecondCategory();
    // }else{
    //   widget.categoryModelList = _secondCategoryModelList;
    //   _getGoodsList();
    // }
    _getSecondCategory();
  }

    //获取二级分类
  void _getSecondCategory()async{
    await getSubCategoryData({'id':widget.firstCategoryModel.id}, (secondLevelLis){
      setState(() {
        _secondCategoryModelList = secondLevelLis;
      });
      _getGoodsList();
    },onFail: (message) {
      // FLToast.showText(text: message);
    },);
  }


  void _getGoodsList() {
    getCatrgoryGoodsList(
      _secondCategoryModelList[_selectedIndex].id,
      _page,
      ( onSuccessList) {
        setState(() {
          List<GoodsModelList> goods =  onSuccessList;
          _goodList.addAll(goods);
        });
        _refreshController.refreshCompleted();
        _refreshController.loadComplete();
      },
      onFail: (message) {
        _refreshController.refreshCompleted();
        _refreshController.loadComplete();
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.firstCategoryModel.name),
      ),
      body: Column(children: <Widget>[
        _topCategoryWidget(),
        Expanded(
            child: CustomRefreshWidget(
          childWidget: _goodListWidget(),
          refreshController: _refreshController,
          onRefresh: () {
            setState(() {
              _page = 1;
            });
            _goodList = [];
            _getGoodsList();
          },
          onLoading: () {
            setState(() {
              _page++;
            });
            _getGoodsList();
          },
        )),
      ]),
      
    );
  }

  Widget _topCategoryWidget() {
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(70),
      width: ScreenUtil().setWidth(100 * _secondCategoryModelList.length),
      child: ListView.builder(
          padding: EdgeInsets.only(top: 2),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: _secondCategoryModelList.length,
          itemBuilder: (context, index) {
            return InkWell(
                child: Container(
                  width: ScreenUtil().setWidth(150),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: index == _selectedIndex
                                  ? Colors.red
                                  : Colors.transparent,
                              width: 2))),
                  child: Center(
                      child: Text(
                    '${_secondCategoryModelList[index].name}',
                    style: TextStyle(),
                    textAlign: TextAlign.center,
                  )),
                ),
                onTap: () {
                  setState(() {
                    if(_selectedIndex != index){
                       _selectedIndex = index;
                       _goodList = [];
                      _getGoodsList();
                    }
                  });
                });
          }),
    );
  }

  Widget _goodListWidget() {
    return Container(
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: Colors.grey.shade100, width: 2))),
        child: getListGoods());
  }

  Widget getListGoods() {
    // if (_goodList.length == 0) {
    //   return Center(child: LoadingDialog());
    // }
    return GridView.count(
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        scrollDirection: Axis.vertical,
        crossAxisCount: 2,
        children: _goodList.map((e) => _goodsItem(e)).toList());
  }

  Widget _goodsItem(GoodsModelList item) {
    return InkWell(
        // color: Colors.white,
        // height: ScreenUtil().setHeight(300),
        child: Column(
          children: [
          Container(
            height: ScreenUtil().setHeight(230),
            child: Image.network(
              item.picUrl,
              width: ScreenUtil().setWidth(280),
            ),
          ),
          Expanded(
            child: Text('${item.name}'),
          ),
          Flexible(child: Text('${item.retailPrice}'))
        ]),
        onTap: () {
          NavigatorUtils.goGoodeDetail(context, item.id);
        },);
  }


}
