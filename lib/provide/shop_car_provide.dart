import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mall_litemall_demo/model/cart_goods_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopCarProvide with ChangeNotifier {
  String carString = '';
  List<CartGoodsModel> carGoodLists = [];
  bool isAllSeleted = false;

  int totalGoodsCount = 0;
  int selectedCount = 0;//选择的总数
  double selectedMoney = 0.0;//总价钱

  //加
  savegood(id, name, count, price, imag) async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    carString = prefer.getString('cartInfo');
    var temp = carString == null ? [] : json.decode(carString.toString());
    List<Map> tempList = (temp as List).cast();
    var isHave = false;
    int ival = 0;

    tempList.forEach((element) {
      if (element['id'] == id) {
        tempList[ival]['count'] = (int.parse(element['count']) + 1).toString();
        isHave = true;
      }
      ival++;
    });
    if (!isHave) {
      tempList.add({
        'id': id,
        'name': name,
        'price': price,
        'imag': imag,
        'count': count,
        'selected': 0
      });
    }
    carString = json.encode(tempList).toString();
    prefer.setString('cartInfo', carString);
    // print(carString);
    notifyListeners();
    getCartGoods();
  }

  //获取
  getCartGoods() async {
    carGoodLists = [];
    SharedPreferences prefer = await SharedPreferences.getInstance();
    carString = prefer.getString('cartInfo');
    if (carString != null) {
      List<Map> goods = (json.decode(carString.toString()) as List).cast();
      bool _isall = goods.length==0?false:true;
      goods.forEach((element) {
        element['selected'] = element['selected'] == 'true';
        carGoodLists.add(CartGoodsModel.fromJson(element));
        
        if (element['selected'] is bool) {
          if (element['selected']== false) {
            _isall = false;
          }
        }else{
          if (element['selected'] == null || element['selected'] != 'true' || element['selected']==false) {
            _isall = false;
          }
        }
        
      });
      isAllSeleted = _isall;
    } else {
      carGoodLists = [];
      isAllSeleted = false;
    }
    settlement();
    notifyListeners();
    
  }

  getIsAllSelected()async{
    SharedPreferences prefer = await SharedPreferences.getInstance();
    carString = prefer.getString('cartInfo');
    if (carString != null) {
      List<Map> goods = (json.decode(carString.toString()) as List).cast();
      bool _isall = true;
      goods.forEach((element) {
        element['selected'] = element['selected'] == 'true';
        carGoodLists.add(CartGoodsModel.fromJson(element));
        
        if (element['selected'] is bool) {
          if (element['selected']== false) {
            _isall = false;
          }
        }else{
          if (element['selected'] == null || element['selected'] != 'true' || element['selected']==false) {
            _isall = false;
          }
        }
        
      });
      return _isall;
    } else {
      return false;
    }
    return false;
    
    notifyListeners();
  }

  //单个商品删除
  removeOne(id, bool all) async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    carString = prefer.getString('cartInfo');

    var temp = carString == null ? [] : json.decode(carString.toString());
    List<Map> tempList = (temp as List).cast();
    if (all) {
      
      // int index = tempList.indexWhere((element) => element['id'] == id);
      // tempList.removeAt(index);
      //删除单个全部商品
      List<int>  removeIdList =[];
      int val = 0;
      tempList.forEach((element) {
          if (element['selected'] is bool) {
          if (element['selected']== true) {
            removeIdList.insert(0,val);
          }
        }else{
          if (element['selected'] == null || element['selected'] != 'true' || element['selected']==false) {

          }else{
              removeIdList.insert(0,val);
          }
        }
        val++;
      });

      removeIdList.forEach((element) {
        tempList.removeAt(element);
      });


    } else {
      int ival = 0;
      List<int> removeIndex = [];
      tempList.forEach((element) {
        if (element['id'] == id) {
          if (int.parse(element['count']) > 1) {
            String count = tempList[ival]['count'] =
                (int.parse(element['count']) - 1).toString();
          } else {
            removeIndex.add(ival);
          }
        }
        ival++;
      });
      removeIndex.forEach((element) {
        tempList.removeAt(element);
      });
      removeIndex = [];
    }

    carString = json.encode(tempList).toString();
    prefer.setString('cartInfo', carString);
    getCartGoods();
    notifyListeners();
  }


  //删除全部购物车商品
  removeAllGoods() async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    prefer.remove('cartInfo');
    notifyListeners();
  }

  //单选，全选
  selectdGoods(id, bool all) async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    carString = prefer.getString('cartInfo');
    var temp = carString == null ? [] : json.decode(carString.toString());
    List<Map> tempList = (temp as List).cast();
    int ival = 0;
    bool _isAllSeleted = true;//有没有全选
    tempList.forEach((element) {
      if (all) {
        if (isAllSeleted) {//全部取消
          tempList[ival]['selected'] = false.toString();
          _isAllSeleted = false;
        }else{//全选
          tempList[ival]['selected'] = true.toString();
        }
      } else {
        if (element['id'] == id) {
          if (element['selected'] == null || element['selected'] != 'true') {
            tempList[ival]['selected'] = true.toString();
          } else {
            tempList[ival]['selected'] = false.toString();
            _isAllSeleted = false;
          }
        }else{
          if (element['selected'] == null || element['selected'] != 'true') {
            _isAllSeleted = false;
          } 
        }
      }
      ival++;
    });
    isAllSeleted = _isAllSeleted;
    carString = json.encode(tempList).toString();
    prefer.setString('cartInfo', carString);
    getCartGoods();
    notifyListeners();
  }


//结算
settlement()async{

    selectedCount =0;
    selectedMoney = 0.0;
    totalGoodsCount = 0;
    carGoodLists.forEach((element) { 
      if (element.selected) {
        selectedCount += int.parse(element.count);
        selectedMoney += int.parse(element.count) * element.price;
      }
      totalGoodsCount += int.parse(element.count);
    });
    notifyListeners();
}


}
