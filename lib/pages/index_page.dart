import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provide/provide.dart';
import 'category/category_page.dart';
import 'shopCar/cart_page.dart';
import 'member/member_page.dart';
import 'home/home_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provide/currentIndex_provide.dart';


class IndexPage extends StatelessWidget {

  final List<Widget> _tabBodies = [
  HomePage(),
  CategoryPage(),
  ShopCarPage(),
  MemberPage(),
];

final List<BottomNavigationBarItem> _bottomTabs = [
  BottomNavigationBarItem(icon:Icon(CupertinoIcons.home),title: Text('首页')),    
  BottomNavigationBarItem(icon:Icon(CupertinoIcons.search),title: Text('分类')),
  BottomNavigationBarItem(icon:Icon(CupertinoIcons.shopping_cart),title: Text('购物车')),
  BottomNavigationBarItem(icon:Icon(CupertinoIcons.profile_circled),title: Text('会员中心')),
];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,width:750,height:1334, allowFontScaling: true);

    return Provide<CurrentIndexProvide>(
      builder: (context, child, currentProvide) {
        int _currnetIndex = Provide.value<CurrentIndexProvide>(context).currentIndex;
        return Scaffold(
      backgroundColor: Color.fromARGB(244, 245, 245, 1),
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,//shifting 
        currentIndex:_currnetIndex,
        items: _bottomTabs,
        onTap: (index) {
          Provide.value<CurrentIndexProvide>(context).changeCurrentIndex(index);
        },
      ),
      // body:_currentPage,
      //保持页面状态
      body:IndexedStack(
        children: _tabBodies,
        index: _currnetIndex,)
    ); 
      }, 
    );
  }
}




// class IndexPage extends StatefulWidget {
//   IndexPage({Key key}) : super(key: key);

//   @override
//   _IndexPageState createState() => _IndexPageState();
// }

// class _IndexPageState extends State<IndexPage> {

// final List<Widget> _tabBodies = [
//   HomePage(),
//   CategoryPage(),
//   ShopCarPage(),
//   MemberPage(),
// ];

// final List<BottomNavigationBarItem> _bottomTabs = [
//   BottomNavigationBarItem(icon:Icon(CupertinoIcons.home),title: Text('首页')),    
//   BottomNavigationBarItem(icon:Icon(CupertinoIcons.search),title: Text('分类')),
//   BottomNavigationBarItem(icon:Icon(CupertinoIcons.shopping_cart),title: Text('购物车')),
//   BottomNavigationBarItem(icon:Icon(CupertinoIcons.profile_circled),title: Text('会员中心')),
// ];

// int _currentIndex = 0;//点击的索引
// var _currentPage;//利用currentIndex得到当前选择的页面，并进行呈现出来。


// @override
//   void initState() {
//     // TODO: implement initState
//     _currentPage = _tabBodies[_currentIndex];
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {

//     //填入设计稿中设备的屏幕尺寸
//     //设置字体大小根据系统的“字体大小”辅助选项来进行缩放,默认为false
//     ScreenUtil.init(context,width:750,height:1334, allowFontScaling: true);
//     // print('设备像素密度:${ScreenUtil.pixelRatio}');
//     // print('设备高度:${ScreenUtil.screenHeight}');
//     // print('设备宽度:${ScreenUtil.screenWidth}');

//     return Scaffold(
//       backgroundColor: Color.fromARGB(244, 245, 245, 1),
//       bottomNavigationBar: BottomNavigationBar(
//         // unselectedItemColor: Colors.redAccent,
//         // selectedItemColor: Colors.lightBlue,
//         type:BottomNavigationBarType.fixed,//shifting 
//         currentIndex:_currentIndex,
//         items: _bottomTabs,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//             _currentPage = _tabBodies[index];
//           });
//         },
//       ),
//       // body:_currentPage,
//       //保持页面状态
//       body:IndexedStack(
//         children: _tabBodies,
//         index: _currentIndex,)
//     );
//   }
// }