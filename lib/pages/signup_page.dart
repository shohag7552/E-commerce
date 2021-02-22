import 'package:e_commerce/pages/products_page.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: eBackgroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: height * 0.15,
            ),
            Center(
              child: Text(
                'Sign Up',
                style: TextStyle(
                    color: eWhiteColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 28),
              ),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: eTextFieldDecoration,
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: eTextFieldDecoration.copyWith(
                    hintText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: eWhiteColor,
                      size: 18,
                    )),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: eTextFieldDecoration.copyWith(
                    hintText: 'Confirm Password',
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: eWhiteColor,
                      size: 18,
                    )),
              ),
            ),
            SizedBox(
              height: height * 0.06,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 50,
                width: width,
                decoration: BoxDecoration(
                  color: eButtonColor,
                ),
                child: FlatButton(
                  child: Text(
                    'SING UP',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductsPage(),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: height * 0.06,
            ),
            Center(
              child: Text(
                'Having An Account? Sign In',
                style: TextStyle(color: eWhiteColor, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
