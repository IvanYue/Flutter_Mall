import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mall_litemall_demo/model/goods_detail_Info_model.dart';
import 'package:mall_litemall_demo/provide/currentIndex_provide.dart';
import 'package:mall_litemall_demo/provide/shop_car_provide.dart';
import 'package:mall_litemall_demo/widget/loading_dialog.dart';
import 'package:provide/provide.dart';
import '../../service/service_method.dart';
import 'goods_detail_widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class GoodsDetailInfoPage extends StatefulWidget {
  String goodsId;
  GoodsDetailInfoPage({Key key, this.goodsId}) : super(key: key);
  @override
  GoodsDetailInfoPageState createState() => new GoodsDetailInfoPageState();
}

class GoodsDetailInfoPageState extends State<GoodsDetailInfoPage> {
  GoodsDetailModel _goodsDetailModel;
  AutoScrollController _controller;
  List<String> _tabsTitles = ['商品', '评价', '详情', '推荐'];

  double _opacity = 0;
  int _selectedIndex = 0;
  double _offset = 0.0;

  void _getGoodsDetailInfoData() {
    getGoodsDetail(
      int.parse(widget.goodsId),
      (onSuccess) {
        setState(() {
          _goodsDetailModel = onSuccess;
        });
      },
      onFail: (message) {},
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.horizontal);
    _getGoodsDetailInfoData();

    // print(ScreenUtil().setHeight(893)); //打印滚动位置

    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      if (_controller.offset >= 0 &&
          _controller.offset <= ScreenUtil().setHeight(400)) {
        double opacity = _controller.offset / ScreenUtil().setHeight(400);
        if (opacity <= _controller.offset) {
          setState(() {
            _opacity = opacity;
          });
        }
      } else if (_controller.offset < 0) {
        setState(() {
          _offset = _controller.offset;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasData = _goodsDetailModel != null;
    if (!hasData) {
      return LoadingDialog();
    }
    List<double> scrollerToOffsetList = [0.0];
    List<Widget> sliverListChildren = [
      _infoWidget(GoodsDetailInfo.fromJson(_goodsDetailModel.info),
          GoodsDetailBrand.fromJson(_goodsDetailModel.brand)),
      _selectedGoods(_goodsDetailModel.specificationList),
    ];
    GoodsDetailComment commentModel =
        GoodsDetailComment.fromJson(_goodsDetailModel.comment);
    List<GoodsDetailCommentData> commandList = commentModel.data;
    if (commandList.length > 0) {
      sliverListChildren.add(_commandWidget());
      sliverListChildren.addAll(commandList.map((e) {
        return CustomCommandWidget(
          itemModel: e,
        );
      }).toList());
      scrollerToOffsetList.add(ScreenUtil().setHeight(620));
    }
    if (_goodsDetailModel.attribute.length > 0) {
      scrollerToOffsetList.add(ScreenUtil().setHeight(920));
      sliverListChildren.add(_goodsParameters());
    }
    sliverListChildren.addAll([
      Html(data: _goodsDetailModel.info['detail']),
      _goodsAboutQuestion(),
      SizedBox(height: ScreenUtil().setHeight(80))
    ]);

    return Scaffold(
        body: Stack(children: [
      CustomScrollView(
          physics: ClampingScrollPhysics(),
          controller: _controller,
          slivers: <Widget>[
            SliverAppBar(
              title: Container(
                width: ScreenUtil().setWidth(300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _tabsTitles.map((e) {
                    return Container(
                        padding: EdgeInsets.only(bottom: 3, top: 3),
                        //  margin: EdgeInsets.only(bottom:10),
                        child: InkWell(
                          child: Text(
                            '${e}',
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, _opacity),
                                fontSize: ScreenUtil().setSp(28)),
                          ),
                          onTap: () {
                            // for (var i = 0; i < _tabsTitles.length; i++) {
                            //   if (e == _tabsTitles[i]) {
                            //     if (scrollerToOffsetList!=null) {
                            //       _controller.animateTo(scrollerToOffsetList[i], duration: Duration(), curve: Curves.ease);
                            //     }
                            //   }
                            // }
                          },
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2,
                                    color: (_selectedIndex !=
                                            _tabsTitles.indexWhere(
                                                (element) => (element == e)))
                                        ? Colors.transparent
                                        : Color.fromRGBO(
                                            255, 0, 0, _opacity)))));
                  }).toList(),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: GoodsBannerWidget(
                    goodsInfo: GoodsDetailInfo.fromJson(_goodsDetailModel.info),
                    offset: _offset,
                  )),
              expandedHeight: ScreenUtil().setHeight(550) - _offset,
              floating: false,
              pinned: true,
              snap: false,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return sliverListChildren[index];
                },
                childCount: sliverListChildren.length,
              ),
            ),
          ]),
      Positioned(
        child: _bottomWidget(),
        left: 0,
        right: 0,
        bottom: 0,
        height: ScreenUtil().setHeight(80),
      ),
    ]));
  }

//详情介绍
  Widget _infoWidget(GoodsDetailInfo goodsInfo, GoodsDetailBrand goodsBrand) {
    final _boder = BorderSide(width: 1, color: Colors.orange);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(//名称
                      children: <Widget>[
                    Text(
                      goodsInfo.name,
                      style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                      maxLines: 2,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      goodsInfo.brief,
                      maxLines: 2,
                    )
                  ]),
                  Container(
                    //分享
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                color: Colors.grey.shade200, width: 1))),
                    child: InkWell(
                      child: Column(
                        children: <Widget>[Icon(Icons.share), Text('  分享  ')],
                      ),
                      onTap: () {
                        print('分享');
                      },
                    ),
                  )
                ])),
        Container(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: [
                    Text(
                      '￥${goodsInfo.retailPrice}',
                      style: TextStyle(
                          color: Colors.red, fontSize: ScreenUtil().setSp(36)),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '￥${goodsInfo.counterPrice}',
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey),
                    ),
                  ]),
                  Text('销量: ${goodsInfo.sortOrder} ${goodsInfo.unit}')
                ])),
        Container(
            // height: 30,
            margin: EdgeInsets.all(goodsBrand.name != null ? 10 : 0),
            padding: EdgeInsets.all(goodsBrand.name != null ? 3 : 0),
            // color: Colors.white,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1,
                    color: goodsBrand.name != null
                        ? Colors.orange
                        : Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            child: goodsBrand.name != null
                ? Text(
                    '  ${goodsBrand.name} >> ',
                    style: TextStyle(color: Colors.orange),
                    textAlign: TextAlign.center,
                  )
                : null),
        Container(
            height: 1,
            margin: EdgeInsets.only(left: 10),
            color: Colors.grey.shade200),
      ],
    );
  }

//选择标准
  Widget _selectedGoods(List<GoodsDetailSpecificationList> specificationList) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 5))),
        padding: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(specificationList.first.name,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(32),
                  )),
              Icon(Icons.chevron_right),
            ],
          ),
        ]));
  }

//商品参数
  Widget _goodsParameters() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.grey.shade200),
              bottom: BorderSide(color: Colors.grey.shade200))),
      padding: EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          ' 商品参数',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(38),
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 5),
        Column(
            children: _goodsDetailModel.attribute
                .map((GoodsDetailAttribute attribute) {
          return Container(
            padding: EdgeInsets.all(5),
            color: Colors.grey.shade200,
            margin: EdgeInsets.all(5),
            child: Row(
              children: [
                Container(
                  width: ScreenUtil().setWidth(120),
                  child: Text(
                    '${attribute.attribute}',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
                Expanded(child: Text('${attribute.value}'))
              ],
            ),
          );
        }).toList())
      ]),
    );
  }

//常见问题
  Widget _goodsAboutQuestion() {
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: Column(children: [
        Text('— 常见问题 —', style: TextStyle(fontSize: ScreenUtil().setSp(38))),
        Column(
          children: _goodsDetailModel.issue.map((GoodsDetailIssue issue) {
            return Column(children: [
              Row(children: [
                Text('•',
                    style: TextStyle(
                        color: Colors.red, fontSize: ScreenUtil().setSp(40))),
                Text('${issue.question}', style: TextStyle(color: Colors.black))
              ]),
              Text('${issue.answer}', style: TextStyle(color: Colors.grey))
            ]);
          }).toList(),
        )
      ]),
    );
  }

//评价头部
  Widget _commandWidget() {
    GoodsDetailComment commentModel =
        GoodsDetailComment.fromJson(_goodsDetailModel.comment);
    List<GoodsDetailCommentData> commandList = commentModel.data;

    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200))),
      padding: EdgeInsets.all(10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                Text('评价(${commentModel.count})',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: ScreenUtil().setSp(30))),
                Row(
                  children: <Widget>[
                    Text('查看全部',
                        style: TextStyle(fontSize: ScreenUtil().setSp(30))),
                    Icon(Icons.chevron_right)
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ]),
    );
  }

//加入购物车，
  Widget _bottomWidget() {
    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(100),
      child: Row(
        children: [
          Stack(children: [
            InkWell(
                //购物车
                onTap: () {
                  Provide.value<CurrentIndexProvide>(context)
                      .changeCurrentIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                    width: ScreenUtil().setWidth(110),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.shopping_cart,
                      size: 25,
                      color: Colors.red,
                    ))),
            Provide<ShopCarProvide>(
              builder: (context,child,value){
                int goodsCount = Provide.value<ShopCarProvide>(context).totalGoodsCount;
                return Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding:EdgeInsets.fromLTRB(3, 1, 3, 1),
                    decoration: BoxDecoration(
                      color:Colors.red,
                      border:Border.all(width: 1,color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child:Text('$goodsCount',
                    style: TextStyle(color:Colors.white,fontSize: ScreenUtil().setSp(20)),)
                  ),
                );
              }
              )
          ]),
          InkWell(
            child: Container(
              color: Colors.orange.shade400,
              width: ScreenUtil().setWidth(320),
              alignment: Alignment.center,
              child: Text('加入购物车', style: TextStyle(color: Colors.white)),
            ),
            onTap: () async {
              GoodsDetailInfo info =
                  GoodsDetailInfo.fromJson(_goodsDetailModel.info);
              await Provide.value<ShopCarProvide>(context).savegood(
                  info.id, info.name, '1', info.retailPrice, info.picUrl);
              // Fluttertoast.showToast(msg: "加入成功", gravity: ToastGravity.CENTER);
            },
          ),
          InkWell(
              child: Container(
            color: Colors.red.shade400,
            width: ScreenUtil().setWidth(320),
            alignment: Alignment.center,
            child: Text(
              '立即购买',
              style: TextStyle(color: Colors.white),
            ),
          )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }
}
