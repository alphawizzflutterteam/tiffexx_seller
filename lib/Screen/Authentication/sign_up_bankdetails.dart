import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiffexx_seller/Screen/Authentication/Login.dart';

import '../../Helper/AppBtn.dart';
import '../../Helper/Color.dart';
import '../../Helper/Constant.dart';
import '../../Helper/ContainerDesing.dart';
import '../../Helper/Session.dart';
import '../../Helper/app_assets.dart';
import '../TermFeed/Privacy_Policy.dart';
import '../TermFeed/Terms_Conditions.dart';
class SignUpBankDetails extends StatefulWidget {
  String ownerName, mobile,email,password,confirmPassword,owneraddress,addressProofImage,
  restaurantName,fassiNumber,aadharNumber,gstName,gstNumber,panNumber,restaurantDescription,restaurantAddress,restaurantType,logoImage,lat,long,lat2,long2
  ;
   SignUpBankDetails({Key? key,required this.ownerName,required this.mobile,required this.email,required this.password,required this.confirmPassword,required this.owneraddress,required this.addressProofImage,
     required this.aadharNumber,required this.fassiNumber,required this.gstName,required this.gstNumber,required this.panNumber,required this.restaurantAddress,required this.restaurantDescription,required this.restaurantName,
     required this.lat,required this.long,required this.lat2,required this.long2,
  required this.restaurantType,required this.logoImage

   }) : super(key: key);

  @override
  State<SignUpBankDetails> createState() => _SignUpBankDetailsState();
}

class _SignUpBankDetailsState extends State<SignUpBankDetails> with TickerProviderStateMixin {
  @override

  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  bool _isNetworkAvail = true;
  bool showPass = false;
  bool showPass1 = false;
  String? _selectedAccountType; // The selected account type, initially null

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController confirmAccountNumberController = TextEditingController();
  TextEditingController bankCodeController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController panNumberController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  // TextEditingController addressController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController confirmPasswordController = TextEditingController();
  FocusNode? passFocus, monoFocus = FocusNode();

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

    return  Scaffold(
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
                          keyboardType: TextInputType.number,
                          controller: accountNumberController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          // focusNode: monoFocus,
                          textInputAction: TextInputAction.next,
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: (value){
                            if (value!.isEmpty) {
                              return  'Account No. is required';/*getTranslated(context, "MOB_REQUIRED")!;*/
                            }
                            else if (value.length < 5) {
                              return 'Enter valid account no.';
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
                              Icons.credit_card,
                              color: lightBlack2,
                              size: 20,
                            ),
                            hintText: 'Account Number'/*getTranslated(context, "Mobile Number")!*/,
                            hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                              color: lightBlack2,
                              fontWeight: FontWeight.normal,
                            ),
                            filled: true,
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
                          keyboardType: TextInputType.number,
                          controller: confirmAccountNumberController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          // focusNode: monoFocus,
                          textInputAction: TextInputAction.next,
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: (value){
                            if (value!.isEmpty) {
                              return  'Confirm Account No. is required';/*getTranslated(context, "MOB_REQUIRED")!;*/
                            }
                            else if (confirmAccountNumberController.text != accountNumberController.text) {
                              return 'Account no. not match';
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
                              Icons.credit_card,
                              color: lightBlack2,
                              size: 20,
                            ),
                            hintText: 'Confirm Account Number'/*getTranslated(context, "Mobile Number")!*/,
                            hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                              color: lightBlack2,
                              fontWeight: FontWeight.normal,
                            ),
                            filled: true,
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
                          controller: accountNameController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          // focusNode: monoFocus,
                          textInputAction: TextInputAction.next,
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                              Icons.person,
                              color: lightBlack2,
                              size: 20,
                            ),
                            hintText: 'Account Holder Name',/*getTranslated(context, "Mobile Number")!,*/
                            hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                              color: lightBlack2,
                              fontWeight: FontWeight.normal,
                            ),
                            filled: true,
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
                          keyboardType: TextInputType.number,
                          controller: bankCodeController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          // focusNode: monoFocus,
                          textInputAction: TextInputAction.next,
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: (value){
                            if (value!.isEmpty) {
                              return  'Bank Code is required';/*getTranslated(context, "MOB_REQUIRED")!;*/
                            }
                            else if (value.length <5) {
                              return 'Enter valid aadhar no.';
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
                              Icons.credit_card,
                              color: lightBlack2,
                              size: 20,
                            ),
                            hintText: 'Bank Code'/*getTranslated(context, "Mobile Number")!*/,
                            hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                              color: lightBlack2,
                              fontWeight: FontWeight.normal,
                            ),
                            filled: true,
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
                          controller: ifscCodeController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          // focusNode: monoFocus,
                          textInputAction: TextInputAction.next,
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator:  (value){
                            if (value!.isEmpty) {
                              return  'Ifsc Code is required';/*getTranslated(context, "MOB_REQUIRED")!;*/
                            }
                            else if (value.length <5) {
                              return 'Enter valid ifsc code';
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
                              Icons.food_bank,
                              color: lightBlack2,
                              size: 20,
                            ),
                            hintText: 'Ifsc Code',/*getTranslated(context, "Mobile Number")!,*/
                            hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                              color: lightBlack2,
                              fontWeight: FontWeight.normal,
                            ),
                            filled: true,
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
                          controller: bankNameController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          // focusNode: monoFocus,
                          textInputAction: TextInputAction.next,
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                              Icons.food_bank,
                              color: lightBlack2,
                              size: 20,
                            ),
                            hintText: 'Bank Name',/*getTranslated(context, "Mobile Number")!,*/
                            hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                              color: lightBlack2,
                              fontWeight: FontWeight.normal,
                            ),
                            filled: true,
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
                          controller: branchNameController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          // focusNode: monoFocus,
                          textInputAction: TextInputAction.next,
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                              Icons.add_location,
                              color: lightBlack2,
                              size: 20,
                            ),
                            hintText: 'Branch',/*getTranslated(context, "Mobile Number")!,*/
                            hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                              color: lightBlack2,
                              fontWeight: FontWeight.normal,
                            ),
                            filled: true,
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
                        child: DropdownButton<String>(
                          hint: Text('Select Account Type',),
                          style: TextStyle(color:lightBlack2 ),

                          // Hint text when no value is selected
                          value: _selectedAccountType, // Currently selected value
                          items: ['Saving', 'Current'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedAccountType = newValue; // Update the selected value
                            });
                          },
                        ),
                      ),







                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: InkWell(
                      //     onTap: (){
                      //       galleryImage();
                      //     },
                      //     child: Container(
                      //       width: MediaQuery.of(context).size.width * 0.85,
                      //       height: 80,
                      //       // padding: EdgeInsets.only(
                      //       //   top: 30.0,
                      //       //   left: 10,
                      //       //   right: 10
                      //       // ),
                      //       decoration: BoxDecoration(border:Border.all(color: lightBlack2),
                      //           borderRadius: BorderRadius.circular(7)
                      //
                      //
                      //       ),
                      //
                      //       child: Center(child: invoicePath==null ?  Text('Logo',style: TextStyle(color: lightBlack2,)): Image.file(File(invoicePath ?? ""))),
                      //
                      //     ),
                      //   ),
                      // ),

                      // Container(
                      //   width: MediaQuery.of(context).size.width * 0.85,
                      //   padding: EdgeInsets.only(
                      //     top: 30.0,
                      //   ),
                      //   child: TextFormField(
                      //     maxLength: 10,
                      //     onFieldSubmitted: (v) {
                      //       FocusScope.of(context).requestFocus(passFocus);
                      //     },
                      //     keyboardType: TextInputType.number,
                      //     controller: panNumberController,
                      //     style: TextStyle(
                      //       color: fontColor,
                      //       fontWeight: FontWeight.normal,
                      //     ),
                      //     focusNode: monoFocus,
                      //     textInputAction: TextInputAction.next,
                      //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      //     validator: (value){
                      //       if (value!.isEmpty) {
                      //         return  'Pan No. is required';/*getTranslated(context, "MOB_REQUIRED")!;*/
                      //       }
                      //
                      //       return null;
                      //     },
                      //     // onSaved: (String? value) {
                      //     //   mobile = value;
                      //     // },
                      //     decoration: InputDecoration(
                      //       counterText: "",
                      //       focusedBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(color: primary),
                      //         borderRadius: BorderRadius.circular(7.0),
                      //       ),
                      //       prefixIcon: Icon(
                      //         Icons.numbers,
                      //         color: lightBlack2,
                      //         size: 20,
                      //       ),
                      //       hintText: 'Pan Number'/*getTranslated(context, "Mobile Number")!*/,
                      //       hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                      //         color: lightBlack2,
                      //         fontWeight: FontWeight.normal,
                      //       ),
                      //       filled: true,
                      //       fillColor: white,
                      //       contentPadding: EdgeInsets.symmetric(
                      //         horizontal: 10,
                      //         vertical: 5,
                      //       ),
                      //       prefixIconConstraints: BoxConstraints(
                      //         minWidth: 40,
                      //         maxHeight: 20,
                      //       ),
                      //       enabledBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(color: lightBlack2),
                      //         borderRadius: BorderRadius.circular(7.0),
                      //       ),
                      //     ),
                      //   ),
                      // ),



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

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text("Don't hava an account? "),
                      //     InkWell(
                      //         onTap: (){
                      //
                      //         },
                      //         child: Text("Sign Up",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                      //   ],
                      // ),

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
                              child:   isLoading ? Center(child: CircularProgressIndicator(color: Colors.white,))  :  Text(
                                'Sign Up',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                  color: white,
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                          ),
                          onPressed: () {

                            if(_formkey.currentState!.validate())
                              {
                                print('kkkkkkkkkk');
                                if(_selectedAccountType==null)
                                  {
                                    print('kkkkkkkkkk2222');
                                    Fluttertoast.showToast(msg: 'Please Select Account Type');
                                  }
                                else
                                  {
                                    print('kkkkkkkkkk33333333');
                                    signUpSeller();
                                  }
                              }
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpBankDetails()));
                            // onBtnSelected!();
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
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
          'Bank Details'
          /* getTranslated(context, 'SIGNUp_LBL')!*/,
          style: const TextStyle(
            color: primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  String? invoicePath;
  Future<void> galleryImage() async {
    final picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      invoicePath = image.path;
      print('Image path = $invoicePath');
      setState(() {

      });

    }
  }
  bool isLoading = false;
  signUpSeller()async{
    isLoading =true;
    setState(() {

    });

    print("updates add on api worikngg");
    // var headers = {
    //   'Cookie': 'ci_session=2a1db53a991ef210a3d9bb520ce95ba387710edf'
    // };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}register'));
    request.fields.addAll({
      'name': widget.ownerName,
      'mobile': widget.mobile,
      'email': widget.email,
      'password': widget.password,
      'confirm_password': widget.confirmPassword,
      'address': widget.owneraddress,
      'store_name': widget.restaurantName,
      'tax_name': widget.gstName,
      'tax_number': widget.gstNumber,
      'fssai_number': widget.fassiNumber,
      'aadhar_number': widget.aadharNumber,
      'pan_number': widget.panNumber,
      'lat':widget.lat,
      'lang':widget.long,
      'lat2':widget.lat2,
      'lang2':widget.long2,
      'restaurant_description': widget.restaurantDescription,
      'restaurant_address': widget.restaurantAddress,
      'restaurant_type': widget.restaurantType,
      'account_no': accountNumberController.text,
      'confirm_account_no': confirmAccountNumberController.text,
      'account_holder_name': accountNameController.text,
      'banke_code': bankCodeController.text,
      'ifsc_code': ifscCodeController.text,
      'banke_name': bankNameController.text,
      'branch': branchNameController.text,
      'account_type': _selectedAccountType ?? '',

    });
    request.files.add(await http.MultipartFile.fromPath('store_logo', widget.logoImage));
    request.files.add(await http.MultipartFile.fromPath('address_proof', widget.addressProofImage));
    print("Aaddd onn parametyeer ${request.fields}");
    print("Aaddd onn parametyeer ${request.files}");
    // if(addonImageList.length != 0){
    //   print("addon list here now ${addonImageList[0]}");
    //   for(var i=0;i<addonImageList.length;i++){
    //     addonImageList == null ? addonImageList.length == 0 :  request.files.add(await http.MultipartFile.fromPath('addon_images[]', addonImageList[i]));
    //   }
    // }
    // print("checking parameters are here ${request.fields} and ${request.files}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      print('-----------------${finalResult}');
      setState(() {
        var snackBar = SnackBar(
          content: Text('${jsonResponse['message']}'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
      if(jsonResponse['error'] == false)
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
        }
      // Navigator.pop(context);
    }
    else {
      print(response.reasonPhrase);
    }

    isLoading=false;
    setState(() {

    });
  }

}
