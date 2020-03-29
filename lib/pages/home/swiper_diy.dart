import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mall_litemall_demo/model/cateory_model.dart';
import 'package:mall_litemall_demo/utils/navigator_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flui/flui.dart';

//轮播图
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  final String adtitle;
  SwiperDiy({this.swiperDataList, this.adtitle});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: ScreenUtil().setHeight(333),
          width: ScreenUtil().setWidth(750),
          child: Swiper(
            itemBuilder: (context, index) {
              return Image.network(
                '${swiperDataList[index]['url']}',
                fit: BoxFit.fill,
              );
            },
            itemCount: swiperDataList.length,
            pagination: SwiperPagination(), //点
            autoplay: true,
          ),
        ),
        Container(child:ADBanner(
          adPicture: adtitle,
        ))
      ],
    );
  }
}

//导航单元
class TopNavigator extends StatelessWidget {
  const TopNavigator({this.navigatorList});

  final List navigatorList;

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        NavigatorUtils.secondCategory(context, CateoryModel.fromJson(item),[]);
      },
      child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 13),
          child:
              Image.network(item['iconUrl'], width: ScreenUtil().setWidth(50)),
        ),
        Container(
          child: Text(item['name']),
          padding: EdgeInsets.only(top: 8),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(250),
        padding: EdgeInsets.all(10),
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(), //grid禁止滚动
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          crossAxisCount: 4,
          childAspectRatio: 1.3,
          // scrollDirection: Axis.horizontal,
          children: navigatorList.map((item) {
            return _gridViewItemUI(context, item);
          }).toList(),
        ));
  }
}

//广告条
class ADBanner extends StatelessWidget {
  const ADBanner({Key key, this.adPicture}) : super(key: key);

  final String adPicture;

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
    //   child: Container(
    //       height: 60,
    //       width: ScreenUtil.screenWidth,
    //       child: Image.network(
    //         adPicture,
    //         fit: BoxFit.cover,
    //       )),
    // );
    return FLNoticeBar.notice(
      text: adPicture,
      velocity: 0.6,
      loop: true,
      
    );
  }
}

//店长电话
class LeaderPhone extends StatelessWidget {
  const LeaderPhone({Key key, this.leaderImag, this.leaderPhone})
      : super(key: key);

  final String leaderImag; //店长图片
  final String leaderPhone; //店长电话

  //打开网址、拨打电话等。。。
  _launchURL() async {
    // String url = 'https://flutter.cn';
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Stack(textDirection: TextDirection.rtl,
            // fit: StackFit.passthrough,
            children: [
              Image.network(
                leaderImag,
                fit: BoxFit.fitWidth,
                height: ScreenUtil().setHeight(60),
                width: ScreenUtil.screenWidth,
              ),
              Padding(
                  padding: EdgeInsets.all(2),
                  child: Center(
                      child: Text(
                    '店长电话：18591740773 ',
                    style: TextStyle(fontSize: ScreenUtil().setSp(50)),
                  )))
            ]),
      ),
    );
  }
}

//人气推荐
class Recommand extends StatelessWidget {

  final List recommandList;

  const Recommand({Key key, this.recommandList}) : super(key: key);

  //标题
  Widget _titleWidget() {
    
    return Container(
      height: ScreenUtil().setHeight(70),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: .5, color: Colors.black12))),
      child: Text('人气推荐',
          style:
              TextStyle(color: Colors.lime, fontSize: ScreenUtil().setSp(35))),
    );
  }

  Widget _itemUI(index,context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(1000),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                left: BorderSide(width: 0.5, color: Colors.black12),
                bottom: BorderSide(width: 0.5, color: Colors.black12))),
        child: InkWell(
      onTap:(){
        NavigatorUtils.goGoodeDetail(context, recommandList[index]['id']);
      },
      child:Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(recommandList[index]['picUrl']),
              Text(
                '${recommandList[index]['name']}',
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${recommandList[index]['retailPrice']}',
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: ScreenUtil().setSp(32)),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '${recommandList[index]['counterPrice']}',
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: ScreenUtil().setSp(24)),
                    )
                  ])
            ])
    ),
      ),
    );
  }

  //横向列表
  Widget _recommandList() {
    return Container(
      height: ScreenUtil().setHeight(450),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommandList.length,
          itemBuilder: (context, index) {
            return _itemUI(index,context);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(390),
      margin: EdgeInsets.only(top: 10),
      // child: SingleChildScrollView(
      //   physics:NeverScrollableScrollPhysics(),//禁止滑动
      //   child:Column(
      //   children: <Widget>[
      //     _titleWidget(),
      //     _recommandList(),
      //   ],
      // )),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          //Flexible或者Expanded包裹
          Flexible(
            child: _recommandList(),
          )
        ],
      ),
    );
  }
}

//品牌制造商
class BrandListWidget extends StatelessWidget {
  const BrandListWidget({Key key, this.brandList}) : super(key: key);

  final List brandList;

  //标题
  Widget _titleWidget(String title) {
    return Container(
      height: ScreenUtil().setHeight(70),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: .5, color: Colors.black12))),
      child: Text(title,
          style:
              TextStyle(color: Colors.lime, fontSize: ScreenUtil().setSp(35))),
    );
  }

  Widget _brandUI(context, item) {
    return InkWell(
        onTap: () {},
        child: Stack(
          children: <Widget>[
            Image.network(
              item['picUrl'],
              height: 150, //ScreenUtil().setHeight(200),
              width: ScreenUtil.screenWidth / 2,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(item['name'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(28))),
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Text(
                        '${item['floorPrice']}元起',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(24)),
                      ),
                    )
                  ]),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        _titleWidget('品牌制造商直供'),
        Container(
            height: ScreenUtil().setHeight(400),
            padding: EdgeInsets.all(0),
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1.5,
              crossAxisSpacing: 1,
              mainAxisSpacing: 0,
              crossAxisCount: 2,
              children: brandList.map((item) {
                return _brandUI(context, item);
              }).toList(),
            ))
      ]),
    );
  }
}

//分类标题
class CustomTitle extends StatelessWidget {
  final String title;
  final Color color;
  const CustomTitle({Key key, this.title, this.color}) : super(key: key);
  //标题
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(70),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(10, 6, 0, 5),
      decoration: BoxDecoration(
          color: color,
          border: Border(top: BorderSide(width: .5, color: Colors.black12))),
      child: Text(title,
          style:
              TextStyle(color: Colors.lime, fontSize: ScreenUtil().setSp(35))),
    );
  }
}

//周四周一新品推荐and商品
class NewGoldS extends StatelessWidget {
  final List newGoldsList;
  const NewGoldS({Key key, this.newGoldsList}) : super(key: key);

  Widget _newGoldItem(item) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.network(
          item['picUrl'],
          width: ScreenUtil().setWidth(300),
        ),
        Expanded(
            child: Text(
          item['name'],
          style: TextStyle(color: Colors.black),
          maxLines: 2,
        )),
        Expanded(
            child: Text(
          '￥${item['retailPrice']}',
          style: TextStyle(color: Colors.red),
        ))
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomTitle(
          title: '周一周四·新品发布',
          color: Colors.transparent,
        ),
        Container(
          color: Colors.white,
          height: ScreenUtil().setHeight(280 * 3 + 100),
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: newGoldsList.map((e) {
              return InkWell(
                  onTap: () {
                    NavigatorUtils.goGoodeDetail(context,e['id'] );
                  },
                  child: _newGoldItem(e));
            }).toList(),
          ),
        ),
        CustomTitle(
          title: '点击查看更多 >',
          color: Colors.white,
        ),
      ],
    );
  }
}

//专题精选
class TopicListWidget extends StatelessWidget {
  final List topicList;
  const TopicListWidget({Key key, this.topicList}) : super(key: key);

  Widget _topicItem(item) {
    return Container(
      height: ScreenUtil().setHeight(400),
      width: ScreenUtil().setWidth(680),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: Image.network(
          item['picUrl'],
          width: ScreenUtil().setWidth(660),
          height: ScreenUtil().setWidth(300),
          fit: BoxFit.fill,
        )),
        Padding(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                item['title'],
                style: TextStyle(fontSize: ScreenUtil().setSp(30)),
              ),
              Text(
                '￥${item['price']}',
                style: TextStyle(
                    color: Colors.red, fontSize: ScreenUtil().setSp(25)),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(0),
          child: Text(
            item['subtitle'],
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Colors.black45,
              fontSize: ScreenUtil().setSp(23),
            ),
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 10,
        color: Colors.transparent,
      ),
      CustomTitle(title: '专题精选', color: Colors.white),
      Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(400),
        child: ListView.builder(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
          itemCount: topicList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap:(){
                NavigatorUtils.goGoodeDetail(context, topicList[index]['id']);
              },
              child:_topicItem(topicList[index])
            );
          },
        ),
      )
    ]);
  }
}

//人气推荐
class HotGoldList extends StatelessWidget {
  final List hotGoodsList;
  const HotGoldList({Key key, this.hotGoodsList}) : super(key: key);

  Widget hotGoldListItem(item,context) {
    return InkWell(
      onTap:(){
        NavigatorUtils.goGoodeDetail(context, item['id']);
      },
      child:Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(200),
      child: Row(children: [
        Image.network(
          item['picUrl'],
          width: ScreenUtil().setWidth(300),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(item['name'],
                style: TextStyle(
                    color: Colors.black, fontSize: ScreenUtil().setSp(28))),
            Text(item['brief'], style: TextStyle(color: Colors.black54)),
            Text(
              '￥${item['retailPrice']}',
              style: TextStyle(color: Colors.red),
            ),
          ],
        )
      ]),
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(hotGoodsList.length * 210),
        width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomTitle(
            title: '人气推荐',
            color: Colors.transparent,
          ),
          Flexible(
              child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: hotGoodsList.length,
            itemBuilder: (context, index) {
              return hotGoldListItem(hotGoodsList[index],context);
            },
            separatorBuilder: (BuildContext context, int index) {
              return new Divider(
                height: 1.0,
                color: Colors.black12,
              );
            },
          ))
        ]));
  }
}

//商品
class GoodsList extends StatelessWidget {
  final List newGoldsList;
  final String title;
  const GoodsList({Key key, this.newGoldsList, this.title}) : super(key: key);

  Widget _newGoldItem(item) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.network(
          item['picUrl'],
          width: ScreenUtil().setWidth(300),
        ),
        Expanded(
            child: Text(
          item['name'],
          style: TextStyle(color: Colors.black),
          maxLines: 2,
        )),
        Expanded(
            child: Text(
          '￥${item['retailPrice']}',
          style: TextStyle(color: Colors.red),
        ))
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomTitle(
          title: title,
          color: Colors.transparent,
        ),
        Container(
          color: Colors.white,
          height: ScreenUtil().setHeight(280 * newGoldsList.length / 2 + 100),
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: newGoldsList.map((e) {
              return InkWell(
                  onTap: () {
                    NavigatorUtils.goGoodeDetail(context, e['id']);
                  },
                  child: _newGoldItem(e));
            }).toList(),
          ),
        ),
        CustomTitle(
          title: '点击查看更多 >',
          color: Colors.white,
        ),
      ],
    );
  }
}


