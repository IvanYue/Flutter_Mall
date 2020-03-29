import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mall_litemall_demo/service/service_method.dart';
import 'swiper_diy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';


import '../../utils/navigator_util.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {});
    _refreshController.loadComplete();
  }

  String homePageContent = '正在读取数据';
  // int page = 1;
  List<Map> hotListMap;
  @override //保存页面状态
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('111111');
    // _getHotGoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: FutureBuilder(
        //异步请求再渲染不用setState
        future: getHomePageContent(), //异步方法
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var _data = snapshot.data['data'];
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("上拉加载");
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("加载失败！点击重试！");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("松手,加载更多!");
                  } else {
                    body = Text("没有更多数据了!");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView(
                children: <Widget>[
                  SwiperDiy(
                    swiperDataList: _data['banner'],
                    adtitle: _data['brandList'][1]['desc'],
                  ),
                  TopNavigator(navigatorList: _data['channel']),
                  Recommand(recommandList: _data['hotGoodsList']),
                  BrandListWidget(
                    brandList: _data['brandList'],
                  ),
                  NewGoldS(newGoldsList: _data['newGoodsList']),
                  HotGoldList(
                    hotGoodsList: _data['hotGoodsList'],
                  ),
                  TopicListWidget(
                    topicList: _data['topicList'],
                  ),
                  GoodsList(
                    newGoldsList: _data['floorGoodsList'][0]['goodsList'],
                    title: _data['floorGoodsList'][0]['name'],
                  ),
                  GoodsList(
                    newGoldsList: _data['floorGoodsList'][1]['goodsList'],
                    title: _data['floorGoodsList'][0]['name'],
                  ),
                  GoodsList(
                    newGoldsList: _data['floorGoodsList'][2]['goodsList'],
                    title: _data['floorGoodsList'][0]['name'],
                  ),
                  GoodsList(
                    newGoldsList: _data['floorGoodsList'][3]['goodsList'],
                    title: _data['floorGoodsList'][0]['name'],
                  ),
                  _hotGoods(_data['floorGoodsList']),
                ],
              ),
            );
          } else {
            return Center(
                child: Text('加载中...',
                    style: TextStyle(
                        fontSize: ScreenUtil()
                            .setSp(18, allowFontScalingSelf: false))));
          }
        },
      ),
    );
  }

  Widget _wrapListItem(list) {
    List allGoods = [];
    for (Map goods in list) {
      for (Map item in goods['goodsList']) {
        allGoods.add(item);
      }
    }
    if (allGoods.length != 0) {
      List<Widget> listWidget = allGoods.map((val) {
        return InkWell(
          onTap: () {

            NavigatorUtils.goGoodeDetail(context, val['id']);
            // TransitionType transitionType = TransitionType.native;
            // String url = '/detail?goodModel=${val.toString()}';
            // //跳转
            // Application.router.navigateTo(
            //   context, 
            //   url,
            //   transition: TransitionType.native);
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(bottom: 3),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(val['picUrl'],
                      width: ScreenUtil().setWidth(370)),
                  Text(val['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.pink,
                          fontSize: ScreenUtil().setSp(26))),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('￥${val['retailPrice']}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(26))),
                        Text('￥${val['counterPrice']}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: ScreenUtil().setSp(20),
                                decoration: TextDecoration.lineThrough))
                      ])
                ]),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2, //列
        children: listWidget,
      );
    } else {
      return Text(' ');
    }
  }

  Widget _hotGoods(list) {
    return Container(
      child: Column(children: [
        CustomTitle(
          title: '火爆专区',
          color: Colors.transparent,
        ),
        _wrapListItem(list)
      ]),
    );
  }
}
