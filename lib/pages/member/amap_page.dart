import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:amap_core_fluttify/amap_core_fluttify.dart';
import 'package:permission_handler/permission_handler.dart';

class AmApPage extends StatefulWidget {
  @override
  _AmApPageState createState() => _AmApPageState();
}

class _AmApPageState extends State<AmApPage> {
  AmapController _controller ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('高德地图测试'),
      ),
      body: AmapView(
              mapType: MapType.Satellite,
              // showZoomControl: false,
              maskDelay: Duration(milliseconds: 500),
              onMapCreated: (controller) async {
                // requestPermission是权限请求方法, 需要你自己实现 
        // 如果不知道怎么处理, 可以参考example工程的实现, example过程依赖了`permission_handler`插件.
        if (await requestPermission()) {
          await controller.showMyLocation(MyLocationOption(
                      show: true,
                    ));
        }
              },
            ),
    );
  }


  Future<bool> requestPermission() async {
  final permissions =
      await PermissionHandler().requestPermissions([PermissionGroup.location]);

  if (permissions[PermissionGroup.location] == PermissionStatus.granted) {
    return true;
  } else {
    print('需要定位权限!');
    return false;
  }
}

}

