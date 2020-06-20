import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kotlinproject/global/constant/api_const.dart';
import 'package:kotlinproject/global/constant/color_const.dart';
import 'package:kotlinproject/global/utils/random_widget.dart';
import 'package:kotlinproject/global/utils/widget_helper.dart';
import 'package:kotlinproject/model/sqflite_login_user.dart';
import 'package:kotlinproject/view/fcm_home.dart';
import 'package:kotlinproject/view/fcm_signup.dart';

class FcmLogin extends StatefulWidget {
  @override
  _FcmLoginState createState() => _FcmLoginState();
}

class _FcmLoginState extends State<FcmLogin> {
  final formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  final _dbRef = Firestore.instance;
  TextEditingController mobileNoCont = TextEditingController();
  TextEditingController pwdCont = TextEditingController();
  BuildContext _ctx;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (_context) => _createUi(_context)),
    );
  }

  Widget _createUi(BuildContext context) {
    _ctx = context;
    return Container(
      child: Stack(
        children: <Widget>[
          bgDesign(),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30),
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: getTxtColor(msg:'Log in to your \naccount',
                        txtColor: ColorConst.FCM_APP_COLOR, fontSize :25, fontWeight:FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        edtMobileNoField(mobileNoCont),
                        SizedBox(height: 10),
                        edtPwdField(pwdCont, passwordVisible, pwdVisClick),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                      alignment: Alignment.centerRight,
                      child: getTxtColor(msg:'Forgot Password ? ',txtColor:ColorConst.FCM_APP_COLOR,fontSize :16,fontWeight :FontWeight.bold)),
                  SizedBox(height: 20),
                  _loginBtn(),
                  SizedBox(height: 20),
                  Center(child: getTxtGreyColor(msg:'Dont have an account', fontSize:16, fontWeight:FontWeight.normal)),
                  SizedBox(height: 5),
                  Center(child: GestureDetector(
                      onTap: ()=>navigationPush(context, FcmSignup()),
                      child: getTxtColor(msg:'SIGN UP',txtColor:ColorConst.FCM_APP_COLOR, fontSize:16, fontWeight:FontWeight.bold))),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  pwdVisClick() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  Widget _loginBtn() {
    return ButtonTheme(
      minWidth: double.infinity,
      height: 45,
      child: RaisedButton(
          shape: StadiumBorder(),
          color: ColorConst.FCM_APP_COLOR,
          child: getTxtWhiteColor(msg:'Login', fontSize:15, fontWeight:FontWeight.bold),
          onPressed: () => _submitLogin()),
    );
  }

  _submitLogin() {
    final form = formKey.currentState;
    if (formKey.currentState.validate()) {
      form.save();
      setState(() {
//        isLoading = true;
        checkUser();
      });
    }
  }

  void checkUser() async {
    final snapShot = await _dbRef
        .collection(ApiConst.FIRESTORE_COLL_USERS)
        .document(mobileNoCont.text)
        .get();
    if (snapShot.exists) {
      await _dbRef
          .collection(ApiConst.FIRESTORE_COLL_USERS)
          .document(mobileNoCont.text)
          .get()
          .then((result) {
        var loginInfo = SqfliteLoginUserBean.map(snapShot.data);
        if (loginInfo.password == pwdCont.text) {
          navigationPush(_ctx, FcmHome());
        } else {
          showSnackBar(_ctx, 'Incorrect password please use correct password.');
        }
      }).catchError((err) {
        showSnackBar(_ctx, err);
        print(err);
      });
    } else {
      showSnackBar(_ctx, 'User not exist with this mobile number');
    }
  }

}
