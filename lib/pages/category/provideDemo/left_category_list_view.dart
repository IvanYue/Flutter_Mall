import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mall_litemall_demo/model/cateory_model.dart';
import 'package:mall_litemall_demo/provide/category_provide.dart';
import 'package:mall_litemall_demo/service/service_method.dart';
import 'package:provide/provide.dart';

class LeftCategoryListView extends StatefulWidget {
  LeftCategoryListView({Key key}) : super(key: key);

  @override
  _LeftCategoryListViewState createState() => _LeftCategoryListViewState();
}

class _LeftCategoryListViewState extends State<LeftCategoryListView> {

  List<CateoryModel> firstLevelLisCategorys;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFistCategory();
  }

 _getFistCategory() {
     getCategoryFistData(
      (categoryList) {
        setState(() {
          firstLevelLisCategorys = categoryList;
          _selectedIndex = 0;
          _getSecondCategory();
        });
      },
      onFail: (message) {
        // FLToast.showText(text: message);
      },
    );
  }

  //获取二级分类
  void _getSecondCategory()async{
    await getSubCategoryData({'id':firstLevelLisCategorys[_selectedIndex].id}, (secondLevelLis){
      Provide.value<CategoryProvide>(context).getFirstCategoryModel(firstLevelLisCategorys[_selectedIndex]);
      Provide.value<CategoryProvide>(context).getsecondCategoryModelList(secondLevelLis);
    },onFail: (message) {
      // FLToast.showText(text: message);
    },);
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: _getFistCategory(),
      builder: (context, snapshot) {
        return _firstCategoryListWidget();
      },
    );
  }


  Widget _firstCategoryListWidget(){
    return Container(
        decoration: BoxDecoration(
            // color: Colors.black12,
            border: Border(
                top: BorderSide(width: .5, color: Colors.black12),
                right: BorderSide(width: .5, color: Colors.black12))),
        child: ListView.builder(
          itemCount: firstLevelLisCategorys.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: Container(
                decoration: BoxDecoration(
                    color: index == _selectedIndex
                        ? Colors.grey.shade100
                        : Colors.white,
                    border: Border(
                        left: BorderSide(
                            width: 5,
                            color: index == _selectedIndex
                                ? Colors.red
                                : Colors.transparent))),
                width: 100.0,
                height: 50.0,
                alignment: Alignment.center,
                child: Text(
                  firstLevelLisCategorys[index].name,
                  style: TextStyle(
                      color:
                          index == _selectedIndex ? Colors.red : Colors.black,
                      fontSize: ScreenUtil()
                          .setSp(index == _selectedIndex ? 30 : 25)),
                ),
              ),
              onTap: () {
                if (_selectedIndex != index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  _getSecondCategory();
                }
              },
            );
          },
        ));
  }
}
