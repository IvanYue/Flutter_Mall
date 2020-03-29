import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:mall_litemall_demo/Utils/fluro_convert_utils.dart';
import 'package:mall_litemall_demo/model/cateory_model.dart';
import 'package:mall_litemall_demo/model/goods_model.dart';
import 'package:mall_litemall_demo/pages/member/setting_page.dart';
import 'dart:convert' as convert;

//页面
import '../pages/goods/goods_detail_page.dart';
import '../pages/category/scond_category.dart';
import '../pages/member/amap_page.dart';

//商品详情
Handler goodsDetailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
    String goodsId = parameters['goodsId'].first;
    return GoodsDetailInfoPage(goodsId:goodsId);
  },
);

//二级分类商品列表
Handler secondCategoryHandler = Handler(
  handlerFunc: (context, parameters) {
    
    CateoryModel firstCategoryModel = CateoryModel.fromJson(FluroConvertUtil.stringToMap(parameters['firstCategory'].first));

    List secondCategoryJsonList = FluroConvertUtil.stringToList(parameters['scondCategoryList'].first);
    List<CateoryModel> secondCategoryModelList = secondCategoryJsonList.map((e) => CateoryModel.fromJson(e)).toList(); 

    return SecondCatrgoryGoodList(
      firstCategoryModel:firstCategoryModel,
      categoryModelList: secondCategoryModelList,
    );
  },

  
);


Handler mapAndPushPage = Handler(
  handlerFunc: (context, parameters) {
    return SettingPage();
  },
);

Handler ampapage = Handler(
  handlerFunc: (context,parameters){
    return AmApPage();
  }
);
