import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mall_litemall_demo/model/cateory_model.dart';
import 'package:mall_litemall_demo/provide/category_provide.dart';
import 'package:provide/provide.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'provideDemo/category_goodsList.dart';
import 'provideDemo/category_goodsList_2.dart';
import 'provideDemo/left_category_list_view.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int categoryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('分类')), body: _provideWidget());
  }

//provide 实现 状态控制
  Widget _provideWidget() {
    return Container(
        child: Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: LeftCategoryListView(),
        ),
        Provide<CategoryProvide>(builder: (context, child, categoryProvide) {
          return Expanded(
              flex: 8,
              child: CategoryGoodsListWidget());
        })

        // child: CategoryTopListGoodsWidget(),
      ],
    ));
  }

//bloC 实现状态控制
  Widget _bloCWidget() {}

//fish_redux 实现状态控制
  Widget _fish_reduxWidget() {}
}
