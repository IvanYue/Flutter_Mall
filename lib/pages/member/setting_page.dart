import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mall_litemall_demo/pages/member/user_Info_widget.dart';
import 'package:mall_litemall_demo/utils/navigator_util.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.settings, color: Colors.white, size: 20),
        //   ),
        // ],
        title: Text('demo集合'),
      ),
      body: ListView(
        children:[
          Container(
            margin: EdgeInsets.only(top:20),
            decoration: BoxDecoration(
                color:Colors.white,
                border: Border(bottom:BorderSide(width: 1,color:Colors.black12))
            ),
            // height: ScreenUtil().setHeight(150),
            child: ListTile(
              onLongPress: (){
                  NavigatorUtils.amapPage(context);
              },
              leading: Icon(Icons.map,color: Colors.lightBlue,),
              title: Text('高德地图'),
              // subtitle: Text(title),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          _orderTitle('推送',Icons.mobile_screen_share,0.5),
        ]
      ),
      );
  }

  //我的订单标题
  Widget _orderTitle(String title,IconData icon,double top){
    return Container(
      margin: EdgeInsets.only(top:top),
      decoration: BoxDecoration(
        color:Colors.white,
        border: Border(bottom:BorderSide(width: 1,color:Colors.black12))
      ),
      // height: ScreenUtil().setHeight(150),
      child: ListTile(
        leading: Icon(icon,color: Colors.lightBlue,),
        title: Text(title),
        // subtitle: Text(title),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }

}