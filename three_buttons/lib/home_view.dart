import 'package:flutter/material.dart';
import 'package:untitled1/DBUtil.dart';
import 'package:untitled1/node_view.dart';

// home view
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeViewState();
  }
}

class HomeViewState extends State<HomeView> {
  // tree root node
  Map? tree;
  List allNode = [];
  @override
  void initState() {
    super.initState();
    query();
  }

  void query() async {
    // query node data
    var res = await DBUtil.search();
    allNode = res;
    // deal node
    // create a tree
    for (var i = 0; i < res.length; i++) {
      var m = res[i];
      m["options"] = getChildren(m["id"]);
      if (m["pid"] == 0) {
        tree = m;
      }
    }

    setState(() {});
  }

  // get node children
  List getChildren(int? pid) {
    var l = [];
    for (var i = 0; i < allNode.length; i++) {
      Map node = allNode[i];
      if (pid == node["pid"]) {
        l.add(node);
      }
    }
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd7b516),
      body: tree != null ? NodeView(tree!) : Container(),
    ); //end of scaffold
  }
}
