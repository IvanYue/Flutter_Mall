import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mall_litemall_demo/model/goods_detail_Info_model.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mall_litemall_demo/utils/navigator_util.dart';

//详情
class GoodsBannerWidget extends StatefulWidget {
  double offset;
  GoodsDetailInfo goodsInfo;
  GoodsBannerWidget({Key key, this.goodsInfo, this.offset}) : super(key: key);

  @override
  _GoodsBannerWidgetState createState() => _GoodsBannerWidgetState();
}

class _GoodsBannerWidgetState extends State<GoodsBannerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Swiper(
        itemCount: widget.goodsInfo.gallery.length,
        itemBuilder: (context, index) {
          return Container(
              padding: EdgeInsets.only(top: -widget.offset),
              height: ScreenUtil().setHeight(620 - widget.offset),
              child: InkWell(
                          child:Image.network(
                widget.goodsInfo.gallery[index],
                fit: BoxFit.fill,
              ),onTap: () {
                  //         Navigator.of(context).push(new MaterialPageRoute(
                  //           builder: (context) {
                  //         return ImageshowWidget(imageNet:widget.goodsInfo.gallery[index]);
                  //         },
                  // fullscreenDialog: true));
                        },
                        )
              );
        },
        pagination: SwiperPagination(), //点
        autoplay: true,
      ),
    );
  }
}

//评价
class CustomCommandWidget extends StatelessWidget {


  final GoodsDetailCommentData itemModel;
  const CustomCommandWidget({Key key,this.itemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade200))),
        margin: EdgeInsets.only(left: 10),
        padding: EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.network(
                          itemModel.picList[0],
                          width: ScreenUtil().setWidth(60),
                          height: ScreenUtil().setHeight(60),
                          fit: BoxFit.fill,
                        ),
                        SizedBox(width: 10),
                        Text('${itemModel.nickname}')
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                    Text(itemModel.addTime)
                  ]),
              SizedBox(height: 10),
              Text(itemModel.content),
              SizedBox(height: 10),
              Container(
                height: ScreenUtil().setHeight(750 / 4 - 35.0 / 4),
                width: ScreenUtil.screenWidth,
                child: ListView.builder(
                  // padding: EdgeInsets.all(10),
                  scrollDirection: Axis.horizontal,
                  itemCount: itemModel.picList.length,
                  itemBuilder: (context, row) {
                    return Container(
                        padding: EdgeInsets.only(right: 10, bottom: 10),
                        child: InkWell(
                          child:Image.network(
                          itemModel.picList[row],
                          fit: BoxFit.fill,
                          width: ScreenUtil().setWidth(750 / 4 - 35.0 / 4),
                          height: ScreenUtil().setWidth(750 / 4 - 35.0 / 4),
                        ),onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) {
                          return ImageshowWidget(imageNet:itemModel.picList[row]);
                          },
                  fullscreenDialog: true));
                        },
                        ));
                  },
                ),
              )
            ]));
  
  }
}

class ImageshowWidget extends StatelessWidget {
  final String imageNet ;
  ImageshowWidget({Key key,this.imageNet});
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 1),
      body: new InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: new Container(
          color: Color.fromRGBO(0, 0, 0, 1),
          alignment: Alignment.center,
          child: new Hero(
            tag: "image",
            child: Image.network(
              imageNet,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
            ))
        ),
      ),
    );
  }
}

//推荐商品
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
      ],
    );
  }
}


