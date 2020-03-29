import 'package:flutter/material.dart';

/**
 * Provide状态管理步骤
 * 1.写对应状态管理的文件 provide/count_provide.dart
 * 2.main.dart 的 main()方法中顶层注入
 * 3.对应class中获取状态
 */


class Counter with ChangeNotifier{
  int value = 0;
  increment(){
    value++;
    notifyListeners();//通知刷新
  }
}