import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mall_litemall_demo/model/cateory_model.dart';
import 'package:mall_litemall_demo/model/goods_detail_Info_model.dart';
import 'package:mall_litemall_demo/utils/fluro_convert_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api.dart';
import 'dart:async';

import 'api/http_util.dart';//二次封装http请求
import '../model/goods_model.dart';

//首页
Future getHomePageContent() async{
   
  try {
      print('开始获取数据....');
      Response response ;
      Dio dio = Dio();
      dio.options.contentType="application/x-www-form-urlencoded";
      response = await dio.get(Api.HOME_URL);
      
      if(response.statusCode == 200){
        saveHotGoodsList(response.data);//购物车推荐使用
        return response.data;
      }else{
      Fluttertoast.showToast(msg: '服务器异常',gravity: ToastGravity.CENTER);
      }
    } catch (e) {
      return print('ERROR:======>${e}');
    }
    
}

void saveHotGoodsList(data)async{
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   List hotGoodsList = data['data']['hotGoodsList'];
   sharedPreferences.setString('hotGoodsList',FluroConvertUtil.objecttToString(hotGoodsList));
   List newGoodsList = data['data']['newGoodsList'];
   sharedPreferences.setString('newGoodsList',FluroConvertUtil.objecttToString(newGoodsList));
   List topicList = data['data']['topicList'];
   sharedPreferences.setString('topicList',FluroConvertUtil.objecttToString(topicList));
}



//使用二次封装的Dio请求

typedef OnSuccessList<T>(List<T> banners);

typedef OnFail(String message);

typedef OnSuccess<T>(T successData);

//分类一级列表
Future getCategoryFistData(OnSuccessList onSuccessList,{OnFail onFail}) async{
  try {
      var response = await HttpUtil.instance.get(Api.HOME_FIRST_CATEGORY);
      if (response['errno'] == 0) {//成功
        // json转model
        CategoryListModel  cateoryList = CategoryListModel.fromJson(response["data"]) ;
        // responseList = cateoryList.map((json)=>CateoryModel.fromJson(json)).toList();
        onSuccessList(cateoryList.itemList);
      }else{
        onFail(response['msg']);
      }
  } catch (e) {
      onFail('后端接口出现异常，请检测代码和服务器情况.........');
  }
}

//分类二级列表
Future getSubCategoryData(
  Map<String,dynamic> parameters,
  OnSuccessList onSuccessList,
  {OnFail onFail})async{
      try {
        var responseList = [];
        var response = await HttpUtil.instance.get(Api.HOME_SECOND_CATEGORY,parameters: parameters);
        if (response['errno']==0) {
          //json转Model
          List  cateoryList = response["data"];
          responseList = cateoryList.map((json){
            return CateoryModel.fromJson(json);
          }).toList();
          onSuccessList(responseList);
        }else{
          onFail(response['msg']);
        }
      } catch (e) {
        onFail('后端接口出现异常，请检测代码和服务器情况.........');
      }
  }

//分类标题
Future getCatrgoryTitle(
  int categoryId,
  OnSuccessList onSuccessList,
  {OnFail onFail})async{
  try {
    var response = await HttpUtil.instance.get(Api.CATEGORY_LIST,parameters: {'id':categoryId});
    if (response['errno'] == 0){
      onSuccessList(response['data'].map((json)=>CateoryModel.fromJson(json)).toList());
    }else{
      onFail('暂无数据');
    }
  } catch (e) {
    onFail('后端接口出现异常，请检测代码和服务器情况.........');
  }
}


Future getCatrgoryGoodsList(
  
  int secondCategoryId,int page,
  OnSuccessList onSuccessList,
  {OnFail onFail})async{
  
  try {
    var response = await HttpUtil.instance.get(Api.GOODS_LIST_URL,parameters: {'categoryId':secondCategoryId,'page':page,'limit':100});

    if (response['errno'] == 0){
      List itemList = response['data']['list'];
      onSuccessList(itemList.map((json)=>GoodsModelList.fromJson(json)).toList());
    }else{
      Fluttertoast.showToast(msg: '暂无数据',gravity: ToastGravity.CENTER);
      onFail('暂无数据');
    }

  } catch (e) {
    onFail('后端接口出现异常，请检测代码和服务器情况.........');
    Fluttertoast.showToast(msg: '后端接口出现异常，请检测代码和服务器情况.........',gravity: ToastGravity.CENTER);

  }
  
}

//商品详情
Future getGoodsDetail(int goodId,OnSuccess onSuccess,{OnFail onFail})async{
  try {
    var response = await HttpUtil.instance.get(Api.GOODS_DETAILS_URL,parameters:{'id':goodId});
    if (response['errno'] == 0){
      onSuccess(GoodsDetailModel.fromJson(response['data']));
    }else{
      onFail('暂无数据');
    }
  } catch (e) {
    onFail('后端接口出现异常，请检测代码和服务器情况.........');
  }
}