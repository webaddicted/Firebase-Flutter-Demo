import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kotlinproject/global/constant/assets_const.dart';
import 'package:kotlinproject/global/constant/color_const.dart';
import 'package:kotlinproject/global/utils/random_widget.dart';
import 'package:kotlinproject/global/utils/validation_helper.dart';
import 'package:kotlinproject/global/utils/widget_helper.dart';
import 'package:kotlinproject/view/fcm_home.dart';
import 'package:kotlinproject/view/fcm_signup.dart';
import 'package:pinput/pin_put/pin_put.dart';

class FcmOtpVerify extends StatefulWidget {
  String mobileNo;

  FcmOtpVerify(this.mobileNo);

  @override
  _FcmOtpVerifyState createState() => _FcmOtpVerifyState(mobileNo);
}

class _FcmOtpVerifyState extends State<FcmOtpVerify> {
  final formKey = GlobalKey<FormState>();
  static BuildContext _ctx;
  static final _fcmAuth = FirebaseAuth.instance;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String mobileNo;
  static String verifId;

  _FcmOtpVerifyState(this.mobileNo);

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: ColorConst.FCM_APP_COLOR),
      borderRadius: BorderRadius.circular(5),
    );
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  getTxtGreyColor(
                      msg: 'Verify Account',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: 150, child: Image.asset(AssetsConst.OTP_IMG)),
                  SizedBox(height: 20),
                  getTxtBlackColor(
                      msg: 'Verification Code',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  SizedBox(height: 20),
                  getTxtGreyCenterColor(
                      msg:
                          'OTP has been sent to your mobile\nnumber please verify',
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                  Form(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 40, bottom: 30),
                      child: PinPut(
                        fieldsCount: 6,
                        validator: ValidationHelper.validateOtp,
                        onSubmit: (String pin) => showSnackBar(_ctx, pin),
                        focusNode: _pinPutFocusNode,
                        controller: _pinPutController,
                        submittedFieldDecoration: _pinPutDecoration.copyWith(
                            borderRadius: BorderRadius.circular(5)),
                        selectedFieldDecoration: _pinPutDecoration,
                        followingFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: ColorConst.FCM_APP_COLOR,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () => navigationPush(context, FcmSignup()),
                      child: getTxtColor(
                          msg: 'Resend OTP',
                          txtColor: ColorConst.FCM_APP_COLOR,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  _verifyBtn(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _verifyBtn() {
    return ButtonTheme(
      minWidth: double.infinity,
      height: 45,
      child: RaisedButton(
          shape: StadiumBorder(),
          color: ColorConst.FCM_APP_COLOR,
          child: getTxtWhiteColor(
              msg: 'Verify', fontSize: 15, fontWeight: FontWeight.bold),
          onPressed: () => _submitVerify()),
    );
  }

  _submitVerify() {
//    final form = formKey.currentState;
//    if (formKey.currentState.validate()) {
//      form.save();
//      setState(() {
//      });
//    }
    if (_pinPutController.text.length == 6)
      _signInWithPhoneNumber();
    else
      showSnackBar(_ctx, 'Please enter all OTP code');
  }

  void _signInWithPhoneNumber() async {
    var _authCredential = await PhoneAuthProvider.getCredential(
        verificationId: verifId, smsCode: _pinPutController.text);
    _fcmAuth.signInWithCredential(_authCredential).then((value) async {
      navigationPush(_ctx, FcmHome());
//      showSnackBar(_ctx, 'Success   :  ' + value.toString());
    }).catchError((error) {
      showSnackBar(_ctx, 'Something has gone wrong, please try later');
    });
  }

  void checkUser() {
    _fcmAuth
        .verifyPhoneNumber(
            phoneNumber: '+91' + mobileNo,
            timeout: Duration(seconds: 60),
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
        .then((value) {
      print('Code sent');
    }).catchError((error) {
      print(error.toString());
    });
  }

  PhoneCodeSent codeSent =
      (String verificationId, [int forceResendingToken]) async {
    verifId = verificationId;
    showSnackBar(_ctx, 'OTP sent successfully');
    print("\nEnter the code sent to ");
  };

  final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (String verificationId) {
    verifId = verificationId;
    showSnackBar(_ctx, "Auto retrieval time out");
  };

  final PhoneVerificationFailed verificationFailed =
      (AuthException authException) {
    print('${authException.message}');
    if (authException.message.contains('not authorized'))
      showSnackBar(_ctx, 'App not authroized');
    else if (authException.message.contains('Network'))
      showSnackBar(_ctx, 'Please check your internet connection and try again');
    else
      showSnackBar(
          _ctx,
          'Something has gone wrong, please try later ' +
              authException.message);
  };

  PhoneVerificationCompleted verificationCompleted = (AuthCredential auth) {
    _fcmAuth.signInWithCredential(auth).then((AuthResult value) {
      if (value.user != null) {
        navigationPush(_ctx, FcmHome());
        print('Authentication successful');
      } else {
        showSnackBar(_ctx, 'Invalid code/invalid authentication');
      }
    }).catchError((error) {
      print('Something has gone wrong, please try later $error');
    });
  };

}
