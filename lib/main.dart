import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:provide/provide.dart';
import 'provide/count_provide.dart';
import 'provide/category_provide.dart';
import 'provide/currentIndex_provide.dart';
import 'provide/shop_car_provide.dart';
//路由
import 'package:fluro/fluro.dart';
import './routers/routers.dart';
import './routers/application.dart';


void main() {
  // provider 注入顶层依赖
  var counter = Counter();
  var categoryProvide = CategoryProvide();
  var cartProvide = ShopCarProvide();
  var providers = Providers();
  var currentIndexProvide = CurrentIndexProvide();
  
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<CategoryProvide>.value(categoryProvide))
    ..provide(Provider<ShopCarProvide>.value(cartProvide))
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));

  runApp(ProviderNode(child: MyApp(), providers: providers));

  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //1.初始化配置Router
    //-------------------主要代码start
    final router = Router();
    Routes.configureRotes(router);
    Application.router=router;
    //-------------------主要代码end




    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndexPage(),
      onGenerateRoute: Application.router.generator,//2.配置路由
      // localizationsDelegates: [
      //   // 这行是关键
      //   RefreshLocalizations.delegate,
      //   // GlobalWidgetsLocalizations.delegate,
      //   // GlobalMaterialLocalizations.delegate
      // ],
      // supportedLocales: [
      //   const Locale('en'),
      //   const Locale('zh'),
      // ],
      // localeResolutionCallback:
      //     (Locale locale, Iterable<Locale> supportedLocales) {
      //   //print("change language");
      //   return locale;
      // },
    // )
    );
  }
}
