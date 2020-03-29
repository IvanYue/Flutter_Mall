import 'package:flutter/material.dart';
import 'package:mall_litemall_demo/model/cateory_model.dart';
import '../model/category.dart';
import '../model/goods_model.dart';

class CategoryProvide with ChangeNotifier{

  //点击的一级分类model
  CateoryModel selectedFirstCategoryModel;
  //二级分类导航
  List<CateoryModel> secondCategoryModelList;
  
  getsecondCategoryModelList( List<CateoryModel> modelList){
    // CateoryModel all ;
    // all.name = '全部';
    secondCategoryModelList = modelList;
    notifyListeners();
  }

  getFirstCategoryModel(CateoryModel model){
    selectedFirstCategoryModel = model;
    notifyListeners();
  }



}