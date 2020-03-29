import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mall_litemall_demo/pages/member/user_Info_widget.dart';

class MemberPage extends StatefulWidget {
  MemberPage({Key key}) : super(key: key);

  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white, size: 20),
          onPressed: () {
            
            
          },),
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
        children: <Widget>[
          _topHeader(),
          _orderTitle('我的订单',Icons.list,10),
          _orderType(),
          _orderTitle('领取优惠券',Icons.card_giftcard,10),
          _orderTitle('地址管理',Icons.gps_fixed,1),
          _orderTitle('关于我们',Icons.sentiment_very_satisfied,1),
          _orderTitle('客服电话',Icons.phone,10),
          _orderTitle('常见问题',Icons.question_answer,0.5),

          // _orderTitle('地图',Icons.map,20),
          // _orderTitle('推送',Icons.mobile_screen_share,0.5),
        ],
      ),
    );
  }

  Widget _topHeader() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      // color: Colors.pinkAccent,
      child: Column(children: [
        Container(
          // margin: EdgeInsets.only(top:30),
          child: ClipOval(child: Image.asset("static/gsy_cat.png",width: 150,)),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text('测试账号'),
        )
      ]),
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

  Widget _orderType(){
    return Container(
      margin: EdgeInsets.only(top:5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top:20),
      color: Colors.white,
      child: Row(
        children:[
          _orderTypeItem('待付款',Icons.party_mode),
          _orderTypeItem('待发货',Icons.query_builder),
          _orderTypeItem('待收货',Icons.directions_car),
          _orderTypeItem('待评价',Icons.content_paste),
        ]
      ),
    );
  }


  Widget _orderTypeItem(String title,IconData icon){
    return Container(
            width:ScreenUtil().setWidth(187),
            child: Column(
              children:[
                Icon(icon,size:30,color: Colors.lightBlue,),
                SizedBox(height:5),
                Text(title)
              ]
            ),
          );
  }
}
