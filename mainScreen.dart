// import 'package:audio_playere_tet/onlinevideo.dart';
import 'package:flutter/material.dart';
import 'localaudio.dart' as la;
// import 'localvideo.dart' as lv;
import 'onlineaudio.dart' as oa;
import 'onlinevideo.dart' as ov;

class MyTabs extends StatefulWidget {
  @override
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();

    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Pages"),
            backgroundColor: Colors.deepOrange,
            bottom: new TabBar(controller: controller, tabs: <Tab>[
              new Tab(icon: new Icon(Icons.arrow_forward)),
              new Tab(icon: new Icon(Icons.arrow_downward)),
              new Tab(icon: new Icon(Icons.arrow_forward)),
              // new Tab(icon: new Icon(Icons.arrow_downward)),
            ])),
        body: new TabBarView(controller: controller, children: <Widget>[
          new oa.AudioNetwork(),
          new ov.VideoExample(),
          new la.HomePage()
        ]));
  }
}
