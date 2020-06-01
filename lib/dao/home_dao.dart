
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_trip/model/home_model.dart';

const HOME_URL = 'https://www.devio.org/io/flutter_app/json/home_page.json';

// 首页大接口
class HomeDao{
  static Future<HomeModel> fetch() async {
    // 发起http请求
    final response = await http.get(HOME_URL);
    // 判断是否请求成功
    if (response.statusCode == 200) {
      // 处理中文乱码
      Utf8Decoder utf8decoder = Utf8Decoder();
      // 解码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      // 请求失败，抛出异常
      throw Exception('Failed to load home_page.json');
    }
  }
}