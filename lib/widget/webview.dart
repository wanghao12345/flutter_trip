import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView({
    Key key, 
    this.url, 
    this.statusBarColor, 
    this.title, 
    this.hideAppBar, 
    this.backForbid
  });

  @override
  _WebView createState() => _WebView();
}

class _WebView extends State<WebView> {

  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;

  @override
  void initState() {
    super.initState();
    webviewReference.close();
    // 监听url变化
    _onUrlChanged = webviewReference.onUrlChanged.listen((String url) {
      
    });
    // 状态监听
    _onStateChanged = webviewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          break;
        default:
          break;  
      }
    });

    // 错误监听
    _onHttpError = webviewReference.onHttpError.listen((WebViewHttpError error) {
      print(error);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
  }


  @override
  Widget build(BuildContext context) {

    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;

    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Color(int.parse('0xff' + statusBarColorStr)), backButtonColor),
          Expanded(
            child: WebviewScaffold(
              url: widget.url,
              withZoom: true,
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(
                color: Colors.white,
                child: Center(
                  child: Text('waiting...'),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    // appBar 隐藏状态下
    if (widget.hideAppBar??false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    // appBar  非隐藏状态下
    return Container(
      // 充满整个组件
      child: FractionallySizedBox(
        widthFactor: 1, // 宽度撑满
        child: Stack(
          children: <Widget>[
            // 左侧操作按钮
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title??'',
                  style: TextStyle(
                    color: backButtonColor,
                    fontSize: 20
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}