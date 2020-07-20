import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:ecommerce_template/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  ScrollController controller = ScrollController();
  bool isRegister = false;
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    print("BACK BUTTON!"); // Do some stuff.
    Provider.of<AllProviders>(context, listen: false).NavBarShow(true);
    Navigator.pop(context);
    return true;
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  final kHintTextStyle = TextStyle(
    color: Colors.black54,
    fontFamily: 'OpenSans',
  );

  final kLabelStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );

  final kBoxDecorationStyle = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  bool _rememberMe = false;

  Widget _buildUserName(Languages lang) {
    return Column(
      crossAxisAlignment: Languages.selectedLanguage == 0
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          lang.translation['username'][Languages.selectedLanguage],
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: nameController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.supervised_user_circle,
                color: Theme.of(context).primaryColor,
              ),
              hintText: lang.translation['usernameEnter']
                  [Languages.selectedLanguage],
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF(Languages lang) {
    return Column(
      crossAxisAlignment: Languages.selectedLanguage == 0
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          lang.translation['emailTitle'][Languages.selectedLanguage],
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Theme.of(context).primaryColor,
              ),
              hintText: lang.translation['enterEmail']
                  [Languages.selectedLanguage],
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF(Languages lang) {
    return Column(
      crossAxisAlignment: Languages.selectedLanguage == 0
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          lang.translation['passwordTitle'][Languages.selectedLanguage],
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Theme.of(context).primaryColor,
              ),
              hintText: lang.translation['passwordTitleEnter']
                  [Languages.selectedLanguage],
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhone(Languages lang) {
    return Column(
      crossAxisAlignment: Languages.selectedLanguage == 0
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          lang.translation['phoneTitle'][Languages.selectedLanguage],
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: phoneController,
           // obscureText: true,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone_android,
                color: Theme.of(context).primaryColor,
              ),
              hintText: lang.translation['phoneTitleEnter']
                  [Languages.selectedLanguage],
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildForgotPasswordBtn(Languages lang) {
  //   return Container(
  //     alignment: Alignment.centerLeft,
  //     child: FlatButton(
  //       onPressed: () => print('Forgot Password Button Pressed'),
  //       padding: EdgeInsets.only(right: 0.0),
  //       child: Text(
  //         'هل نسيت الباسورد',lang.translation['LanguageTitle'][Languages.selectedLanguage],
  //         style: kLabelStyle,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildRememberMeCheckbox(Languages lang) {
    return Container(
      height: 20.0,
      child: Row(
        mainAxisAlignment: Languages.selectedLanguage == 0
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[
          Text(
            lang.translation['rememberMe'][Languages.selectedLanguage],
            style: kLabelStyle,
          ),
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isLoading = false;
  Widget _buildLoginBtn(
      UserProvider uPro, AllProviders allprov, Languages lang) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          setState(() {
            if (isRegister == true) {
              if (nameController.text == "" ||
                  emailController.text == "" ||
                  passwordController.text == "" ||
                  phoneController.text == "") {
                showInSnackBar(lang.translation['pleaseFillAllRecords']
                    [Languages.selectedLanguage]);
              } else if (emailController.text.indexOf("@") == -1) {
                showInSnackBar(lang.translation['pleaseFillEmail']
                    [Languages.selectedLanguage]);
              } else {
                isLoading = true;
                uPro
                    .register(
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                      phoneController.text,
                      context,
                      showInSnackBar,
                      allprov,
                    )
                    .then((value) => isLoading = false);
              }
              //  uPro.register(name, email, password, phone, context, pageController);

            } else {
              if (emailController.text == "" || passwordController.text == "") {
                showInSnackBar(lang.translation['pleaseFillAllRecords']
                    [Languages.selectedLanguage]);
              } else if (emailController.text.indexOf("@") == -1) {
                showInSnackBar(lang.translation['pleaseFillEmail']
                    [Languages.selectedLanguage]);
              } else {
                isLoading = true;
                uPro
                    .login(
                      emailController.text,
                      passwordController.text,
                      context,
                      showInSnackBar,
                      allprov,
                    )
                    .then((value) => isLoading = false);
              }
            }
          });
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: isRegister == false
            ? Container(
                child: isLoading == false
                    ? Text(
                        lang.translation['signinTitle']
                            [Languages.selectedLanguage],
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : CircularProgressIndicator(),
              )
            : Container(
                child: isLoading == false
                    ? Text(
                        lang.translation['registerTitle']
                            [Languages.selectedLanguage],
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : CircularProgressIndicator(),
              ),
      ),
    );
  }

  // Widget _buildSignInWithText() {
  //   return Column(
  //     children: <Widget>[
  //       Text(
  //         '- OR -',
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontWeight: FontWeight.w400,
  //         ),
  //       ),
  //       SizedBox(height: 20.0),
  //       Text(
  //         'Sign in with',
  //         style: kLabelStyle,
  //       ),
  //     ],
  //   );
  // }

  Widget _buildSocialBtn(Function onTap, AssetImage logo, Languages lang) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  // Widget _buildSocialBtnRow() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 30.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[
  //         _buildSocialBtn(
  //           () => print('Login with Facebook'),
  //           AssetImage(
  //             'assets/logos/facebook.jpg',
  //           ),
  //         ),
  //         _buildSocialBtn(
  //           () => print('Login with Google'),
  //           AssetImage(
  //             'assets/logos/google.jpg',
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildSignupBtn(Languages lang) {
    return GestureDetector(
      onTap: () {
        setState(() {
          nameController.text = '';
          emailController.text = '';
          phoneController.text = '';
          passwordController.text = '';

          isRegister = true;
          controller.animateTo(0.0,
              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        });
      },
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: lang.translation['DONThaveAccount']
                [Languages.selectedLanguage],
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          TextSpan(
            text: lang.translation['registerNow'][Languages.selectedLanguage],
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildSignupBtn2(Languages lang) {
    return GestureDetector(
      onTap: () {
        setState(() {
          nameController.text = '';
          emailController.text = '';
          phoneController.text = '';
          passwordController.text = '';
          isRegister = false;
          controller.animateTo(0.0,
              duration: Duration(milliseconds: 300), curve: Curves.easeInBack);
        });
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: lang.translation['allreadyHaveAccount']
                  [Languages.selectedLanguage],
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            TextSpan(
              text: lang.translation['signinTitle'][Languages.selectedLanguage],
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allPro = Provider.of<AllProviders>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final lang = Provider.of<Languages>(context);

    return WillPopScope(
      onWillPop: () {
        allPro.NavBarShow(true);
        return Future.value(true);
      },
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: new AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(0.4),
                        Theme.of(context).primaryColor.withOpacity(0.6),
                        Theme.of(context).primaryColor.withOpacity(0.8),
                        Theme.of(context).primaryColor,
                      ],
                      stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    controller: controller,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        isRegister == false
                            ? Text(
                                lang.translation['signinTitle']
                                    [Languages.selectedLanguage],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(
                                lang.translation['registerTitle']
                                    [Languages.selectedLanguage],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        SizedBox(height: 30.0),
                        isRegister == true ? _buildUserName(lang) : SizedBox(),
                        SizedBox(height: 30.0),
                        _buildEmailTF(lang),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildPasswordTF(lang),
                        SizedBox(height: 30.0),
                        isRegister == true ? _buildPhone(lang) : SizedBox(),
                        // isRegister == false
                        //     ? _buildForgotPasswordBtn()
                        //     : SizedBox(),
                        SizedBox(height: 20.0),
                        _buildRememberMeCheckbox(lang),
                        _buildLoginBtn(userProvider, allPro, lang),
                        //_buildSignInWithText(),
                        // _buildSocialBtnRow(),
                        isRegister == false
                            ? _buildSignupBtn(lang)
                            : _buildSignupBtn2(lang),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
