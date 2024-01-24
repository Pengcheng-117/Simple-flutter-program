import 'package:flutter/material.dart';

// node view
class NodeView extends StatefulWidget {
  Map node;
  NodeView(this.node, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NodeViewState();
  }
}

class NodeViewState extends State<NodeView> {
  Map? threeNode;
  @override
  void initState() {
    super.initState();
    threeNode = widget.node;
  }

  @override
  Widget build(BuildContext context) {
    List options = threeNode!["options"];
    return Scaffold(
      backgroundColor: Color(0xffd7b516),
      appBar: AppBar(
        title: Text(
          "Question Game ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: threeNode!["id"] != 1
            ? IconButton(
                onPressed: () {
                  setState(() {
                    threeNode = threeNode!["parent"];
                  });
                },
                icon: Icon(Icons.arrow_back_ios))
            : Container(),
        backgroundColor: Color(0xffd7b516),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              threeNode!["question"],
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...options.map((e) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          e["parent"] = threeNode;
                          // set three node
                          threeNode = e;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(color: Color(0xffe15834)),
                        padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                        child: Text(
                          e["name"].toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ))
              ],
            ),
            SizedBox(height: 20),
            Image.network(
              threeNode!["image"],
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black, width: 2))),
              child: Text(
                "Introduce",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            Text(
              threeNode!["description"],
              style: TextStyle(color: Colors.black, fontSize: 13),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black, width: 2))),
              child: Text(
                "View Quantity",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            Text(
              threeNode!["viewCount"].toString(),
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
      ),
    ); //end of scaffold
  }
}
