import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mall_litemall_demo/model/cateory_model.dart';
import 'package:mall_litemall_demo/provide/category_provide.dart';
import 'package:mall_litemall_demo/utils/navigator_util.dart';
import 'package:provide/provide.dart';

import '../scond_category.dart';


class CategoryGoodsListWidget extends StatefulWidget {

  CategoryGoodsListWidget({Key key}) : super(key: key);

  @override
  _CategoryGoodsListWidgetState createState() => _CategoryGoodsListWidgetState();
}

class _CategoryGoodsListWidgetState extends State<CategoryGoodsListWidget> {

  

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryProvide>(
      builder: (context, child, categoryProvide) {
        return secondCategoryListView(
          categoryProvide.secondCategoryModelList,
          categoryProvide.selectedFirstCategoryModel);
      },
    );
  }
  

  Widget secondCategoryListView(List<CateoryModel> secondCategoryModelList,CateoryModel selectedFirstCategoryModel){
    return Container(
      height: ScreenUtil.screenHeight,
      width: ScreenUtil.screenWidth * 0.8,
      child:ListView(
        padding: EdgeInsets.all(10),
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(200),
            child: Image.network(
                selectedFirstCategoryModel.picUrl??"",
                fit: BoxFit.fill,),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          Center(child:Text('———— ${selectedFirstCategoryModel.name} ————',style: TextStyle(color:Colors.black45),),),
          Container(
            // color: Colors.red,
            height:(secondCategoryModelList.length/3+(secondCategoryModelList.length%3>0?1:0))*120,
            child:GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: secondCategoryModelList.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 0.85,
                  //垂直单个子Widget之间间距
                  crossAxisSpacing: 20.0),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child:Column(
                  children:[
                    Image.network(secondCategoryModelList[index].picUrl),
                    Expanded(child: Text(secondCategoryModelList[index].name),)
                  ]
                ),
                onTap:(){
                  // Navigator.of(context).push(
                    // MaterialPageRoute(
                    //   builder: (context) {
                    //     return SecondCatrgoryGoodList(
                    //       firstCategoryModel:selectedFirstCategoryModel,
                    //       categoryModelList:secondCategoryModelList,
                    //     );
                    //   },
                    // )
                  // );
                  NavigatorUtils.secondCategory(context, selectedFirstCategoryModel,secondCategoryModelList);

                }
                );
              }),
          )
          
        ],
      )
    );
    
  }

}

