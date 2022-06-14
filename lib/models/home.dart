import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/shared/components/components.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  var formKey=GlobalKey<FormState>();
  var email =TextEditingController();
  var password =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Login',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w400
        ),),
        SizedBox(
          height: 40.0,
        ),

      defaultTextFormField(
      keyboardType:TextInputType.emailAddress,
      controller: email,
      label: 'Email',
      prefixIcon: Icons.email_outlined,
      validate: (value){
        if(value.isEmpty)
        {
          return 'Email Must not be empty';
        }
        return null;
      },
      ),
        SizedBox(
          height: 25.0,
        ),
        defaultTextFormField(
          keyboardType:TextInputType.visiblePassword,
          controller: password,
          label: 'Email',
          isPassword: true,
          prefixIcon: Icons.lock,
          suffixIcon: Icons.remove_red_eye,
          validate: (value){
            if(value.isEmpty)
            {
              return 'Password Must not be empty';
            }
            return null;
          },
        ),
        SizedBox(
          height: 25.0,
        ),
        defaultButton(
            text: 'Login',
          width: double.infinity,
          backcolor: Colors.blue,
          onPressed:(){
              if(formKey.currentState.validate()){}
          }
        ),

      ],

      ),
    );
  }
}
