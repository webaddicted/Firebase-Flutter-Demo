import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kotlinproject/global/constant/color_const.dart';
import 'package:kotlinproject/global/constant/string_const.dart';
import 'package:kotlinproject/global/utils/random_widget.dart';
import 'package:kotlinproject/global/utils/widget_helper.dart';
import 'package:kotlinproject/model/fcm_home_bean.dart';
import 'package:kotlinproject/view/full_image.dart';

class FcmHome extends StatefulWidget {
  @override
  _FcmHomeState createState() => _FcmHomeState();
}

class _FcmHomeState extends State<FcmHome> {
  List<FcmHomeBean> fcmCatBean = List();
  var _fcmDb = FirebaseDatabase.instance.reference();
  BuildContext _ctx;

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWithBackBtn(
          ctx: context,
          title: StringConst.HOME_TITLE,
          bgColor: ColorConst.FCM_APP_COLOR),
      body: Builder(builder: (_context) => _createUi(_context)),
    );
  }

  Widget _createUi(BuildContext context) {
    _ctx = context;
    return Container(
      child: Stack(
        children: <Widget>[bgDesign(), showView()],
      ),
    );
  }

  void getCategory() async {
    _fcmDb.child('Category').once().then((DataSnapshot snapshot) {
      print('object  :  ' + snapshot.value.toString());
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        fcmCatBean.add(FcmHomeBean.map(values));
      });
      setState(() {});
    }).catchError((onError) {
      print('object   :   ' + onError);
    });
  }

  showView() {
    if (fcmCatBean.length == 0) {
      return _buildProgressIndicator();
    } else {
      return StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: fcmCatBean.length,
        itemBuilder: (BuildContext context, int index) =>
            fmHomeRow(fcmCatBean[index], index),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      );
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new CircularProgressIndicator(),
      ),
    );
  }

  Widget fmHomeRow(FcmHomeBean fcmCatBean, int index) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            if (fcmCatBean.image != null)
              navigationPush(context, FullImage(fcmCatBean.image, null));
          },
          child: loadCircleImg(fcmCatBean.image, 0, index % 2 == 0 ? 180 : 130),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: getTxtBlackCenterColor(
              msg: fcmCatBean.name, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
