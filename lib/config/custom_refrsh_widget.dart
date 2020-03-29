import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';



//自定义下拉刷新上拉加载组件
class CustomRefreshWidget extends StatefulWidget {
   RefreshController refreshController; //controller
   Function onRefresh; //刷新
   Function onLoading; //上拉
   Widget childWidget; //widget
  CustomRefreshWidget({
    Key key,
    this.refreshController,
    this.onRefresh,
    this.onLoading,
    this.childWidget}) : super(key: key);

  @override
  _CustomRefreshWidgetState createState() => _CustomRefreshWidgetState();
}

class _CustomRefreshWidgetState extends State<CustomRefreshWidget> {

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("上拉加载");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("加载失败！点击重试！");
            }
            else if(mode == LoadStatus.canLoading){
               body = Text("松手,加载更多!");
            }
            else{
              body = Text("没有更多数据了!");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: widget.refreshController,
        onRefresh: widget.onRefresh,
        onLoading: widget.onLoading,
        child: widget.childWidget,
      )
    ;
  }
}
