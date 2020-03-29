import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_handler.dart';
import 'application.dart';

class Routes{
  static String root = '/';
  static String  goodsDetailPage = '/detail'; 
  static String secondCategoryGoodList = '/secondCategoryGoodsList';
  static String settingPage = '/setting';
  static void configureRotes(Router router){
    router.notFoundHandler = Handler(
      handlerFunc: (context, parameters) {
        print('找不到对应路由页面');
      },
    );
    //详情页面配置
    router.define(goodsDetailPage, handler: goodsDetailsHandler);
    //二级分类商品列表
    router.define(secondCategoryGoodList, handler: secondCategoryHandler);

    //继承地图、推送
    router.define(settingPage, handler: mapAndPushPage);
  }
}

