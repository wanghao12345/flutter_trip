import 'package:flutter/cupertino.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';

class GridNav extends StatelessWidget{

  // 引入GridNavModel
  final GridNavModel gridNavModel;
  final String name;

  const GridNav({Key key, @required this.gridNavModel, this.name = "wanghao"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(name);
  }


}