import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiffexx_seller/Screen/Authentication/Login.dart';
import 'package:tiffexx_seller/Screen/Authentication/sign_up_restaurants_details.dart';

import '../../Helper/AppBtn.dart';
import '../../Helper/Color.dart';
import '../../Helper/ContainerDesing.dart';
import '../../Helper/Session.dart';
import '../../Helper/app_assets.dart';
import '../TermFeed/Privacy_Policy.dart';
import '../TermFeed/Terms_Conditions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  @override
  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  bool _isNetworkAvail = true;
  bool showPass = false;
  bool showPass1 = false;


  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    const minLength = 8;
    final hasAlphabet = RegExp(r'[a-zA-Z]');
    final hasNumber = RegExp(r'\d');
    final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters\nlong.';
    }
    if (!hasAlphabet.hasMatch(value)) {
      return 'Password must contain at least one alphabetic\ncharacter.';
    }
    if (!hasNumber.hasMatch(value)) {
      return 'Password must contain at least one number.';
    }
    if (!hasSpecialChar.hasMatch(value)) {
      return 'Password must contain at least one special \ncharacter.';
    }

    return null; // Password is valid
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode? passFocus, monoFocus = FocusNode();
  double? lat;
  double? long;

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top]);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    //   statusBarIconBrightness: Brightness.light,
    // ));
    super.initState();

    buttonController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);

    buttonSqueezeanimation = new Tween(
      begin: width * 0.7,
      end: 50.0,
    ).animate(
      new CurvedAnimation(
        parent: buttonController!,
        curve: new Interval(
          0.0,
          0.150,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _isNetworkAvail
          ? Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: back(),
                ),
                Image.asset(
                  'assets/images/doodle.png',
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                ),
                getLoginContainer(),
                getLogo(),
              ],
            )
          : noInternet(context),
    );
  }

  Widget noInternet(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: kToolbarHeight,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            noIntImage(),
            noIntText(context),
            noIntDec(context),
            AppBtn(
              title: getTranslated(context, 'TRY_AGAIN_INT_LBL'),
              btnAnim: buttonSqueezeanimation,
              btnCntrl: buttonController,
              onBtnSelected: () async {
                _playAnimation();

                Future.delayed(Duration(seconds: 2)).then(
                  (_) async {
                    _isNetworkAvail = await isNetworkAvailable();
                    if (_isNetworkAvail) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => super.widget),
                      );
                    } else {
                      await buttonController!.reverse();
                      setState(
                        () {},
                      );
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  getLoginContainer() {
    return Positioned.directional(
      start: MediaQuery.of(context).size.width * 0.025,
      top: MediaQuery.of(context).size.height * 0.2,
      textDirection: Directionality.of(context),
      child: ClipPath(
        clipper: ContainerClipper(),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom * 0.8,
          ),
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.95,
          color: white,
          child: Form(
            key: _formkey,
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 2,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.10,
                      ),
                      setSignInLabel(),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        padding: EdgeInsets.only(
                          top: 30.0,
                        ),
                        child: TextFormField(
                          // maxLength: 10,
                          // onFieldSubmitted: (v) {
                          //   FocusScope.of(context).requestFocus(passFocus);
                          // },
                          // keyboardType: TextInputType.number,
                          controller: ownerNameController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          focusNode: monoFocus,
                          textInputAction: TextInputAction.next,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly
                          // ],
                          validator: (value) {

                            if (value == null || value.isEmpty) {
                              return 'Owner name is required';
                            }

                            return null;
                          },
                          // onSaved: (String? value) {
                          //   mobile = value;
                          // },
                          decoration: InputDecoration(
                            counterText: "",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primary),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                              color: lightBlack2,
                              size: 20,
                            ),
                            hintText: 'Owner Name',
                            /*getTranslated(context, "Mobile Number")!,*/
                            hintStyle: Theme.of(this.context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                  color: lightBlack2,
                                  fontWeight: FontWeight.normal,
                                ),
                          //  filled: true,
                            fillColor: white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 40,
                              maxHeight: 20,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightBlack2),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        padding: EdgeInsets.only(
                          top: 30.0,
                        ),
                        child: TextFormField(
                          maxLength: 10,
                          // onFieldSubmitted: (v) {
                          //   FocusScope.of(context).requestFocus(passFocus);
                          // },
                          keyboardType: TextInputType.number,
                          controller: mobilenumberController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          // focusNode: monoFocus,
                          textInputAction: TextInputAction.next,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly
                          // ],
                          validator: (val) => validateMob(val!, context),
                          // onSaved: (String? value) {
                          //   mobile = value;
                          // },
                          decoration: InputDecoration(
                            counterText: "",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primary),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            prefixIcon: Icon(
                              Icons.phone_android,
                              color: lightBlack2,
                              size: 20,
                            ),
                            hintText: getTranslated(context, "Mobile Number")!,
                            hintStyle: Theme.of(this.context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                  color: lightBlack2,
                                  fontWeight: FontWeight.normal,
                                ),
                            // filled: true,
                            fillColor: white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 40,
                              maxHeight: 20,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightBlack2),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        padding: EdgeInsets.only(
                          top: 30.0,
                        ),
                        child: TextFormField(
                          // maxLength: 10,
                          // onFieldSubmitted: (v) {
                          //   FocusScope.of(context).requestFocus(passFocus);
                          // },
                          // keyboardType: TextInputType.number,
                          controller: emailController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          // focusNode: monoFocus,
                          textInputAction: TextInputAction.next,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly
                          // ],
                          validator: (value) {
                            final regExp =
                                RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            } else if (!regExp.hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          // onSaved: (String? value) {
                          //   mobile = value;
                          // },
                          decoration: InputDecoration(
                            counterText: "",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primary),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: lightBlack2,
                              size: 20,
                            ),
                            hintText:
                                'Email' /*getTranslated(context, "Mobile Number")!*/,
                            hintStyle: Theme.of(this.context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                  color: lightBlack2,
                                  fontWeight: FontWeight.normal,
                                ),
                            // filled: true,
                            fillColor: white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 40,
                              maxHeight: 20,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightBlack2),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        padding: EdgeInsets.only(
                          top: 30.0,
                        ),
                        child: TextFormField(
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(passFocus);
                          },
                          keyboardType: TextInputType.text,
                          obscureText: showPass == true ? false : true,
                          controller: passwordController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          focusNode: passFocus,
                          textInputAction: TextInputAction.next,
                          validator: (val) =>  validatePassword( val),
                          // onSaved: (String? value) {
                          //   password = value;
                          // },
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primary),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            prefixIcon: SvgPicture.asset(
                              "assets/images/password.svg",
                            ),
                            suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    showPass = !showPass;
                                  });
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => SendOtp(
                                  //       title: getTranslated(context, "FORGOT_PASS_TITLE")!,
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: showPass == true
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off)),
                            hintText: getTranslated(context, "PASSHINT_LBL"),
                            hintStyle: Theme.of(this.context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    color: lightBlack2,
                                    fontWeight: FontWeight.normal),
                            fillColor: white,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            suffixIconConstraints:
                                BoxConstraints(minWidth: 40, maxHeight: 20),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 40, maxHeight: 20),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightBlack2),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        padding: EdgeInsets.only(
                          top: 30.0,
                        ),
                        child: TextFormField(
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(passFocus);
                          },
                          keyboardType: TextInputType.text,
                          obscureText: showPass1 == true ? false : true,
                          controller: confirmPasswordController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          focusNode: passFocus,
                          textInputAction: TextInputAction.next,
                          validator: (value){
                            if (value!.isEmpty) {
                              return  'Field is required';/*getTranslated(context, "MOB_REQUIRED")!;*/
                            }
                            else if (confirmPasswordController.text != passwordController.text) {
                              return 'Password not match';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primary),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            prefixIcon: SvgPicture.asset(
                              "assets/images/password.svg",
                            ),
                            suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    showPass1 = !showPass1;
                                  });
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => SendOtp(
                                  //       title: getTranslated(context, "FORGOT_PASS_TITLE")!,
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: showPass1 == true
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off)),
                            hintText:
                                'Confirm Password' /*getTranslated(context, "PASSHINT_LBL")*/,
                            hintStyle: Theme.of(this.context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    color: lightBlack2,
                                    fontWeight: FontWeight.normal),
                            fillColor: white,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            suffixIconConstraints:
                                BoxConstraints(minWidth: 40, maxHeight: 20),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 40, maxHeight: 20),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightBlack2),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        padding: EdgeInsets.only(
                          top: 30.0,
                        ),
                        child: TextFormField(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlacePicker(
                                  apiKey: Platform.isAndroid
                                      ? "AIzaSyD2sg48wUkfFoOc7B5NK9Udv1U0LrFasus"
                                      : "AIzaSyD2sg48wUkfFoOc7B5NK9Udv1U0LrFasus",
                                  onPlacePicked: (result) {
                                    print(result.formattedAddress);
                                    setState(() {
                                      addressController.text =
                                          result.formattedAddress.toString();
                                      lat = result.geometry!.location.lat;
                                      long = result.geometry!.location.lng;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  initialPosition: LatLng(
                                      22.719568,75.857727),
                                  useCurrentLocation: true,
                                ),
                              ),
                            );

                          },
                          // maxLength: 10,
                          // onFieldSubmitted: (v) {
                          //   FocusScope.of(context).requestFocus(passFocus);
                          // },
                          // keyboardType: TextInputType.number,
                          controller: addressController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          // focusNode: monoFocus,
                          textInputAction: TextInputAction.next,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly
                          // ],
                          validator: (val) => validateField(val!, context),
                          // onSaved: (String? value) {
                          //   mobile = value;
                          // },
                          decoration: InputDecoration(
                            counterText: "",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primary),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            prefixIcon: Icon(
                              Icons.location_on_outlined,
                              color: lightBlack2,
                              size: 20,
                            ),
                            hintText: 'Home Address',
                            /*getTranslated(context, "Mobile Number")!,*/
                            hintStyle: Theme.of(this.context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                  color: lightBlack2,
                                  fontWeight: FontWeight.normal,
                                ),
                            // filled: true,
                            fillColor: white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 40,
                              maxHeight: 20,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightBlack2),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            galleryImage();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: 80,
                            // padding: EdgeInsets.only(
                            //   top: 30.0,
                            //   left: 10,
                            //   right: 10
                            // ),
                            decoration: BoxDecoration(border:Border.all(color: lightBlack2),
                                borderRadius: BorderRadius.circular(7)


                            ),

                            child: Center(child: addressProofIMage==null ?  Text('Address Proof',style: TextStyle(color: lightBlack2,)): Image.file(File(addressProofIMage ?? ""))),

                          ),
                        ),
                      ),


                      Padding(
                        padding: EdgeInsets.only(
                          top: 25,
                        ),
                        child: CupertinoButton(
                          child: Container(
                              width: 100,
                              height: 45,
                              alignment: FractionalOffset.center,
                              decoration: new BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [primary, primary],
                                  stops: [0, 1],
                                ),
                                borderRadius: new BorderRadius.all(
                                  const Radius.circular(
                                    10.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Next',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      color: white,
                                      fontWeight: FontWeight.normal,
                                    ),
                              )),
                          onPressed: () {
                            if(_formkey.currentState!.validate())
                            {
                              if(addressProofIMage==null)
                                Fluttertoast.showToast(msg: 'Upload address proof');
                            else
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SignUpRestaurantsDetails(ownerName: ownerNameController.text,confirmPassword: confirmPasswordController.text,password: passwordController.text,email: emailController.text,owneraddress: addressController.text, mobile: mobilenumberController.text,addressProofImage: addressProofIMage ?? '',lat: lat.toString(),long: long.toString(),)));

                            }

                            // onBtnSelected!();
                          },
                        ),
                      ),

                      // setMobileNo(),
                      // setPass(),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => SendOtp(
                      //           title: getTranslated(
                      //               context, "FORGOT_PASS_TITLE")!,
                      //         ),
                      //       ),
                      //     );
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.only(right: 15, top: 10),
                      //     width: MediaQuery.of(context).size.width,
                      //     alignment: Alignment.centerRight,
                      //     child: Text(
                      //       getTranslated(context, "FORGOT_PASSWORD_LBL")!,
                      //       style: TextStyle(
                      //         color: primary,
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // loginBtn(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("You already have an account? "),
                          InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      termAndPolicyTxt(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkNetwork() async {
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      // getLoginUser();
    } else {
      Future.delayed(Duration(seconds: 2)).then(
        (_) async {
          await buttonController!.reverse();
          setState(
            () {
              _isNetworkAvail = false;
            },
          );
        },
      );
    }
  }

  termAndPolicyTxt() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 30.0,
        left: 25.0,
        right: 25.0,
        top: 10.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            getTranslated(context, "CONTINUE_AGREE_LBL")!,
            style: Theme.of(context).textTheme.caption!.copyWith(
                  color: fontColor,
                  fontWeight: FontWeight.normal,
                ),
          ),
          SizedBox(
            height: 3.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Terms_And_Condition(),
                      ),
                    );
                  },
                  child: Text(
                    getTranslated(context, 'TERMS_SERVICE_LBL')!,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: fontColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.normal),
                  )),
              SizedBox(
                width: 5.0,
              ),
              Text(
                getTranslated(context, "AND_LBL")!,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: fontColor, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                width: 5.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrivacyPolicy(),
                    ),
                  );
                },
                child: Text(
                  getTranslated(context, "PRIVACYPOLICY")!,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: fontColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<Null> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  Widget getLogo() {
    return Positioned(
      left: (MediaQuery.of(context).size.width / 2) - 50,
      top: (MediaQuery.of(context).size.height * 0.2) - 50,
      child: SizedBox(
        width: 100,
        height: 100,
        // child: SvgPicture.asset(
        //   'assets/images/loginlogo.svg',
        // ),
        child: Image.asset(Myassets.login_logo),
      ),
    );
  }

  Widget setSignInLabel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslated(context, 'SIGNUp_LBL')!,
          style: const TextStyle(
            color: primary,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String? addressProofIMage;
  Future<void> galleryImage() async {
    final picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 80,maxHeight: 400,maxWidth: 400);

    if (image != null) {
      addressProofIMage = image.path;
      print('Image path = $addressProofIMage');
      setState(() {

      });

    }
  }
}
