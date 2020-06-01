import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/home_model.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 首页接口地址： https://www.devio.org/io/flutter_app/json/home_page.json

  List _imageUrls = [
    'https://pic5.40017.cn/i/ori/Q6W9bIdTZC.jpg',
    'https://pic5.40017.cn/i/ori/PuFgN8MYrC.jpg'
  ];

  // 透明度
  double appBarAlpha = 0;
  // 请求结果
  String resultString = "";
  // 初始化页面
  @override
  void initState() {
    super.initState();
    loadData();
  }

  // 打印列表滚动
  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  // 请求数据
  loadData() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        resultString = json.encode(model.config);
      });
    } catch (e) {
      setState(() {
        resultString = json.encode(e.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // 使用Stack 为了自定义appBar
        body: Stack(
      children: <Widget>[
        // 移除顶部padding
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            // 监听滚动事件
            child: NotificationListener(
              // 滚动事件
              onNotification: (scrollNotification) {
                // 滚动，且是列表滚动的时候
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  // 轮播图
                  Container(
                    height: 200,
                    child: Swiper(
                      itemCount: _imageUrls.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(_imageUrls[index],
                            fit: BoxFit.fill);
                      },
                      pagination: SwiperPagination(),
                    ),
                  ),
                  // 占位
                  Container(
                    height: 800,
                    child: ListTile(title: Text(resultString)),
                  )
                ],
              ),
            )),
        // appBar 因为需要使用透明度，引入了Opacity widget
        Opacity(
          opacity: appBarAlpha,
          child: Container(
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('首页'),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
