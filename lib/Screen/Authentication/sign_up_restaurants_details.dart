import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiffexx_seller/Screen/Authentication/sign_up_bankdetails.dart';

import '../../Helper/AppBtn.dart';
import '../../Helper/Color.dart';
import '../../Helper/ContainerDesing.dart';
import '../../Helper/Session.dart';
import '../../Helper/app_assets.dart';
import '../TermFeed/Privacy_Policy.dart';
import '../TermFeed/Terms_Conditions.dart';
class SignUpRestaurantsDetails extends StatefulWidget {
String ownerName, mobile,email,password,confirmPassword,owneraddress,addressProofImage,lat,long;


   SignUpRestaurantsDetails({Key? key,required this.ownerName,required this.mobile,required this.email,required this.password,required this.confirmPassword,required this.lat,required this.long,
     required this.owneraddress,required this.addressProofImage}) : super(key: key);

  @override
  State<SignUpRestaurantsDetails> createState() => _SignUpRestaurantsDetailsState();
}

class _SignUpRestaurantsDetailsState extends State<SignUpRestaurantsDetails> with TickerProviderStateMixin {
  @override

  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  bool _isNetworkAvail = true;
  bool showPass = false;
  bool showPass1 = false;
  String? _selectedRestaurantType;
  double? lat2;
  double? long2;


  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController fssaiNumberController = TextEditingController();
  TextEditingController aadharNumberController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController panNumberController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController gstNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
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
                       //   maxLength: 10,
                       //    onFieldSubmitted: (v) {
                       //      FocusScope.of(context).requestFocus(passFocus);
                       //    },
                          // keyboardType: TextInputType.number,
                          controller: restaurantNameController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          // focusNode: monoFocus,
                          textInputAction: TextInputAction.next,
                          validator: (value){
                            if (value!.isEmpty) {
                              return  'Restaurant name is required';/*getTranslated(context, "MOB_REQUIRED")!;*/
                            }
                            // else if (confirmPasswordController.text != passwordController.text) {
                            //   return 'Password not match';
                            // }
                            return null;
                          },
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          // validator: (val) => validateField(val!, context),
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
                            hintText: 'Restaurant Name',/*getTranslated(context, "Mobile Number")!,*/
                            hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
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

                          maxLength: 14,
                          // onFieldSubmitted: (v) {
                          //   FocusScope.of(context).requestFocus(passFocus);
                          // },
                          keyboardType: TextInputType.number,
                          controller: fssaiNumberController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          // focusNode: monoFocus,
                          textInputAction: TextInputAction.next,
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: (value) {
                            if(value == null || value.isEmpty)
                              {
                                return 'Enter FSSAI no.';
                              }
                              else if (value.length != 14) {
                                return 'Enter valid FSSAI no. (14 digits)';
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
                            hintText: 'Fssai Number'/*getTranslated(context, "Mobile Number")!*/,
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
                          maxLength: 12,
                          // onFieldSubmitted: (v) {
                          //   FocusScope.of(context).requestFocus(passFocus);
                          // },
                          keyboardType: TextInputType.number,
                          controller: aadharNumberController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          // focusNode: monoFocus,
                          // textInputAction: TextInputAction.next,
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              if (value.length != 12) {
                                return 'Enter valid Aadhar no. (12 digits)';
                              }
                            }
                            return null;
                          },

                          // validator: (value){
                          //   if (value!.isEmpty) {
                          //     return  'Aadhar No. is required';/*getTranslated(context, "MOB_REQUIRED")!;*/
                          //   }
                          //   else if (value.length <11) {
                          //     return 'Enter valid aadhar no.';
                          //   }
                          //   return null;
                          // },
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
                            hintText: 'Aadhar Number'/*getTranslated(context, "Mobile Number")!*/,
                            hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
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
                          controller: gstNameController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          // focusNode: monoFocus,
                          textInputAction: TextInputAction.next,
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          // validator: (val) => validateField(val!, context),
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
                            hintText: 'Gst Name',/*getTranslated(context, "Mobile Number")!,*/
                            hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
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
                          maxLength: 15,
                          // onFieldSubmitted: (v) {
                          //   FocusScope.of(context).requestFocus(passFocus);
                          // },
                          // keyboardType: TextInputType.number,
                          controller: gstNumberController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          // focusNode: monoFocus,
                          textInputAction: TextInputAction.next,
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              if (value.length != 15) {
                                return 'Enter valid Gst no. (15 digits)';
                              }
                            }
                            return null;
                          },
                          // validator: (value){
                          //   if (value!.isEmpty) {
                          //     return  'Gst No. is required';/*getTranslated(context, "MOB_REQUIRED")!;*/
                          //   }
                          //   else if (value.length <11) {
                          //     return 'Enter valid gst no.';
                          //   }
                          //   return null;
                          // },
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
                            hintText: 'Gst Number'/*getTranslated(context, "Mobile Number")!*/,
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
                          textCapitalization: TextCapitalization.characters,
                          maxLength: 10,
                          // onFieldSubmitted: (v) {
                          //   FocusScope.of(context).requestFocus(passFocus);
                          // },
                          // keyboardType: TextInputType.n,
                          controller: panNumberController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          // focusNode: monoFocus,
                          textInputAction: TextInputAction.next,
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          // validator: (value) {
                          //   if (value != null && value.isNotEmpty) {
                          //     if (value.length != 10) {
                          //       return 'Enter valid Pan no. (10 digits)';
                          //     }
                          //   }
                          //   return null;
                          // },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return  'Pan No. is required';
                              }
                              else if (value.length != 10) {
                                return  'Enter valid Pan no. (10 digits)';
                              }
                              // Check if it contains at least one letter and one number
                              else if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value)) {
                                return 'Enter valid Pan no. (e.g. ABCDE1234F)';
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
                            hintText: 'Pan Number'/*getTranslated(context, "Mobile Number")!*/,
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
                          controller: descriptionController,
                          style: TextStyle(
                            color: fontColor,
                            fontWeight: FontWeight.normal,
                          ),
                          // focusNode: monoFocus,
                          textInputAction: TextInputAction.next,
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          // validator: (val) => validateField(val!, context),
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
                              Icons.type_specimen,
                              color: lightBlack2,
                              size: 20,
                            ),
                            hintText: 'Restaurant Description',/*getTranslated(context, "Mobile Number")!,*/
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
                                      lat2 = result.geometry!.location.lat;
                                      long2 = result.geometry!.location.lng;
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
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          // validator: (val) => validateField(val!, context),
                          // onSaved: (String? value) {
                          //   mobile = value;
                          // },
                          validator: (value){
                            if (value!.isEmpty) {
                              return  'Restaurant address is required';/*getTranslated(context, "MOB_REQUIRED")!;*/
                            }
                            // else if (confirmPasswordController.text != passwordController.text) {
                            //   return 'Password not match';
                            // }
                            return null;
                          },
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
                            hintText: 'Restaurant Address',/*getTranslated(context, "Mobile Number")!,*/
                            hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
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
                        child: DropdownButton<String>(
                          hint: Text('       Restaurant Type',style: TextStyle(color: lightBlack2),),
                          style: TextStyle(color:lightBlack2 ),

                          // Hint text when no value is selected
                          value: _selectedRestaurantType, // Currently selected value
                          items: ['Veg', 'Non-Veg','Veg/Non-Veg'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedRestaurantType = newValue; // Update the selected value
                            });
                          },
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

                            child: Center(child: logoImage==null ?  Text('Logo',style: TextStyle(color: lightBlack2,)): Image.file(File(logoImage ?? ""))),

                          ),
                        ),
                      ),

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
                              child:  Text(
                                'Next',
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
                                if(_selectedRestaurantType == null)
                                  Fluttertoast.showToast(msg: 'Please Select Restaurant type');
                                // else if(logoImage==null)
                                //   Fluttertoast.showToast(msg: 'Please Upload Logo');
                                else
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpBankDetails(ownerName: widget.ownerName,confirmPassword: widget.confirmPassword,password: widget.password,email: widget.email,owneraddress: widget.owneraddress, mobile:widget.mobile,addressProofImage: widget.addressProofImage ?? '',
                                  aadharNumber: aadharNumberController.text,fassiNumber: fssaiNumberController.text,gstName: gstNameController.text,gstNumber: gstNumberController.text,panNumber: panNumberController.text,restaurantAddress: addressController.text,restaurantDescription: descriptionController.text,restaurantName: restaurantNameController.text,restaurantType: _selectedRestaurantType ?? "",logoImage: logoImage ?? '',lat: widget.lat,long: widget.long,lat2: lat2.toString(),long2: long2.toString(),)));

                              }
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
          'Business Details'
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


  String? logoImage;
  Future<void> galleryImage() async {
    final picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 80,maxHeight: 400,maxWidth: 400);

    if (image != null) {
      logoImage = image.path;
      print('Image path = $logoImage');
      setState(() {

      });

    }
  }
}
