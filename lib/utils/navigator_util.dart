import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mall_litemall_demo/model/cateory_model.dart';
import 'package:mall_litemall_demo/model/goods_model.dart';
import '../routers/application.dart';
import '../routers/routers.dart';
import '../utils/fluro_convert_utils.dart';
import 'string_util.dart';



class NavigatorUtils {
  //商品详情
  static goGoodeDetail(BuildContext context,int goodsId) {
    Application.router.navigateTo(context, Routes.goodsDetailPage + '?goodsId=${goodsId}',
        transition: TransitionType.inFromRight, replace: false);
  }
  
  //二级分类，商品列表
  static secondCategory(BuildContext context,CateoryModel firstCategoryModel,List<CateoryModel> secondModelList){
    String catoryJson = FluroConvertUtil.objecttToString(firstCategoryModel).toString();
    String secondJson = FluroConvertUtil.objecttToString(secondModelList).toString();
    // // List secondList = secondModelList.map((e) => e.toJson()).toList();
    // // String secondJson = FluroConvertUtil.fluroCnParamsDecode(secondList.toString());
    Application.router.navigateTo(context, 
    Routes.secondCategoryGoodList +'?firstCategory=${catoryJson}&scondCategoryList=${secondJson}',
    transition: TransitionType.inFromRight);
  }



  //地图。推送继承
  static mapAndPushPage(BuildContext context){
    Application.router.navigateTo(context, Routes.settingPage,transition: TransitionType.inFromRight);
  }

  static amapPage(BuildContext context){
    Application.router.navigateTo(context, Routes.amapPage,transition: TransitionType.inFromBottom);
  }
}


