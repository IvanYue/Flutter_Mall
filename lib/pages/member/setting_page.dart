import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mall_litemall_demo/pages/member/user_Info_widget.dart';

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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white, size: 20),
          ),
        ],
        title: Text('我的'),
        leading: IconButton(
          icon: Icon(
            Icons.message,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
      body: ListView(
        children:[
          _orderTitle('地图',Icons.map,20),
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