import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mall_litemall_demo/model/cart_goods_model.dart';
import 'package:mall_litemall_demo/model/goods_model.dart';
import 'package:mall_litemall_demo/provide/shop_car_provide.dart';
import 'package:mall_litemall_demo/utils/fluro_convert_utils.dart';
import 'package:mall_litemall_demo/utils/navigator_util.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/swiper_diy.dart';

class ShopCarPage extends StatefulWidget {
  ShopCarPage({Key key}) : super(key: key);

  @override
  _ShopCarPageState createState() => _ShopCarPageState();
}

class _ShopCarPageState extends State<ShopCarPage> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provide.value<ShopCarProvide>(context).getCartGoods(),
        builder: (context, snapshot) {
          return Provide<ShopCarProvide>(
            builder: (context, child, value) {
             return Scaffold(
                  appBar: AppBar(
                    title: Text('购物车'),
                    actions: <Widget>[
                      MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          if (Provide.value<ShopCarProvide>(context).selectedCount>0) {
                            //删除
                            Provide.value<ShopCarProvide>(context).removeOne('', true);
                          }
                        },
                        child: Text(
                          Provide.value<ShopCarProvide>(context).selectedCount>0
                              ? '删除'
                              : '',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(28)),
                        ),
                      )
                    ],
                  ),
                  body: value.carGoodLists.length>0
                ?_cartIsHaveGoods(value)
              :_noDataWidget(),
                  );
               
            },
          );
        });
  }

//购物车有数据
  Widget _cartIsHaveGoods(ShopCarProvide value){
    return Stack(children:[
                    ListView.builder(
                    itemBuilder: (context, index) {
                      return _goodListItem(value.carGoodLists[index]);
                    },
                    itemCount: value.carGoodLists.length,
                  ),
                  Positioned(
                    child: _positionedWidget(),
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: ScreenUtil().setHeight(80),)
                  ]
                    
                  );
  }
//结算View
  Widget _positionedWidget() {
    return Container(
      decoration: BoxDecoration(
        boxShadow:[
          BoxShadow(color: Colors.white,
                          offset: Offset(2.0, 3.0),
                          spreadRadius:2.0)
        ]
      ),
      padding: EdgeInsets.all(5),
      // color: Colors.white,
      height: ScreenUtil().setHeight(80),
      width: ScreenUtil().setWidth(750),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children:[
              OutlineButton.icon(
            highlightedBorderColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            borderSide: BorderSide(color: Colors.transparent),
            icon: Icon(Icons.check_circle_outline,color:
              Provide.value<ShopCarProvide>(context).isAllSeleted
              ?Colors.red:Colors.grey
              ),
            label: Text('全选'),
            onPressed: () {
              Provide.value<ShopCarProvide>(context)
                              .selectdGoods('', true);
            },
            ),
            Center(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[
                SizedBox(height:5),
                RichText(
                  text:TextSpan(
                    style:TextStyle(color:Colors.black),
                    children:[
                      TextSpan(text:'合计:'),
                      TextSpan(text:'￥${Provide.value<ShopCarProvide>(context).selectedMoney}',style: TextStyle(color:Colors.red))
                    ]
                  )
                  ),
                Text('满68元免运费',style:TextStyle(fontSize: ScreenUtil().setSp(20),color:Colors.black87),)
              ]
            ),
            )
            ]
          ),
            Container(
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10.0),
                  color: Colors.red.shade700,

                ),
                // width: ScreenUtil().setWidth(150),
                height: ScreenUtil().setHeight(60),
                child:MaterialButton(
              onPressed: (){

              },
            child:Text('结算(${Provide.value<ShopCarProvide>(context).selectedCount})',textAlign: TextAlign.right,style: TextStyle(color:Colors.white),))
              )
            
        ],
      ),
    );
  }
//goodItem
  Widget _goodListItem(CartGoodsModel model) {
    return InkWell(
        onTap: () {
          NavigatorUtils.goGoodeDetail(context, model.id);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
          width: ScreenUtil.screenWidth,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  width: ScreenUtil().setWidth(80),
                  height: ScreenUtil().setWidth(80),
                  child: model.selected != true
                      ? Icon(Icons.check_circle, color: Colors.grey)
                      : Icon(Icons.check_circle, color: Colors.red),
                ),
                onTap: () {
                  //单选
                  Provide.value<ShopCarProvide>(context)
                    ..selectdGoods(model.id, false);
                },
              ),
              Image.network(
                model.imag,
                width: ScreenUtil().setWidth(200),
              ),
              Expanded(
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Container(
                      //名称
                      padding: EdgeInsets.only(right: 10),
                      width: ScreenUtil().setWidth(540),
                      child: Text(
                        model.name,
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      //价格
                      width: ScreenUtil().setWidth(200),
                      child: Text(
                        '${model.price}',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    Container(
                        //添加
                        // padding:EdgeInsets.only(
                        //     top: ScreenUtil().setWidth(30)),
                        // width: ScreenUtil().setWidth(550),
                        child: Container(
                            width: ScreenUtil().setWidth(220),
                            color: Colors.grey.shade100,
                            height: ScreenUtil().setHeight(50),
                            margin: EdgeInsets.only(right: 15),
                            alignment: Alignment.center,
                            child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      size: 15,
                                    ),
                                    onPressed: () {
                                      Provide.value<ShopCarProvide>(context)
                                        ..removeOne(model.id, false);
                                    },
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                      color: Colors.grey.shade400,
                                    )),
                                    child: Text(
                                      '${model.count}',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                  Expanded(
                                      child: IconButton(
                                    icon: Icon(Icons.add, size: 15),
                                    onPressed: () {
                                      Provide.value<ShopCarProvide>(context)
                                        ..savegood(
                                            model.id,
                                            model.name,
                                            model.count,
                                            model.price,
                                            model.imag);
                                    },
                                  ))
                                ]))),
                  ]))
            ],
          ),
        ));
  }

//购物车没有数据
Widget _noDataWidget(){

  List hotGoodsList = [];
  List newGoodsList =[];
  List topicList =[];
  Future  getHotNewData()async{
    SharedPreferences prefer = await SharedPreferences.getInstance();
    String hotGoodsListString = prefer.getString('hotGoodsList');
    String newGoodsListString = prefer.getString('newGoodsList');
    String topicListString = prefer.getString('topicList');
    if (hotGoodsListString !=null&&hotGoodsListString.length!=0) {
      hotGoodsList = FluroConvertUtil.stringToList(hotGoodsListString);
    }
    if (newGoodsListString!=null&&newGoodsListString.length!=0) {
      newGoodsList = FluroConvertUtil.stringToList(newGoodsListString);
    }
    if (topicListString!=null&&topicListString.length!=0) {
      topicList = FluroConvertUtil.stringToList(topicListString);
    }
  }

  return Center(
    child: FutureBuilder(
      future:getHotNewData(),
      builder: (context, snapshot) {
        return SingleChildScrollView(child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width:ScreenUtil.screenWidth,
              height:ScreenUtil().setHeight(150),
              child: Center(child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text('您还没有添加中意的物品'),
                  Text('为您推荐以下好物品'),
                ]
              )),
            ),
            HotGoldList(hotGoodsList: hotGoodsList,),
            Recommand(recommandList: hotGoodsList),
            NewGoldS(newGoldsList: newGoodsList),
            HotGoldList(hotGoodsList: hotGoodsList,),
            TopicListWidget(topicList: topicList,),
          ],
        ));
      },
    ),
  );
}

}
