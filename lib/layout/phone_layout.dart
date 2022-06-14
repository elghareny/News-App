import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_app/models/home.dart';
import 'package:test_app/models/messenger.dart';
import 'package:test_app/models/profile.dart';
import 'package:test_app/shared/components/components.dart';

class PhoneLayout extends StatefulWidget {

  @override
  _PhoneLayoutState createState() => _PhoneLayoutState();
}

class _PhoneLayoutState extends State<PhoneLayout> {
  Database database;
  TextEditingController name;
  TextEditingController email;
  TextEditingController password;
  TextEditingController passwordConfirm;
  bool isBottomSheetShown=false;
  var scaffoldKey=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();
  IconData floatingActionButton=Icons.edit;
  int currentIndex=0;
  List<String>title=
  [
    'Login',
    'Messenger',
    'Profile'
  ];
  List<Widget>screens=
  [
    home(),
    messenger(),
    profile(),
  ];
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        appBar: AppBar(
          elevation: 3.0,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage('assets/images/mohamed.jpg'),
                //backgroundColor: Colors.red,
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(title[currentIndex],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                ),),
            ],
          ),
          actions: [
            IconButton(
                color: Colors.black,
                icon: Icon(Icons.search),
                onPressed: (){}),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        elevation: 20.0,
        backgroundColor: Colors.black,
        onPressed: () {
          if(isBottomSheetShown)
          {

          }else
            {
              scaffoldKey.currentState.showBottomSheet(
                      (context) =>
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.blue,style: BorderStyle.solid,width: 1.0)
                            ),
                            
                            padding: EdgeInsets.all(20.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultTextFormField(label: 'Name',
                                      validate: (value){},
                                      controller: name,
                                      keyboardType: TextInputType.name,
                                      prefixIcon: Icons.text_fields),

                                  SizedBox(
                                    height: 20.0,
                                  ),

                                  defaultTextFormField(label: 'Email',
                                      validate: (value){},
                                      controller: email,
                                      keyboardType: TextInputType.emailAddress,
                                      prefixIcon: Icons.email_outlined),
                                  SizedBox(
                                    height: 20.0,
                                  ),

                                  defaultTextFormField(label: 'Password',
                                      validate: (value){},
                                      controller: password,
                                      keyboardType: TextInputType.visiblePassword,
                                      prefixIcon: Icons.lock,
                                  isPassword: true,
                                  suffixIcon: Icons.remove_red_eye_outlined),

                                  SizedBox(
                                    height: 20.0,
                                  ),

                                  defaultTextFormField(label: 'Confirm Password',
                                      validate: (value){},
                                      controller: passwordConfirm,
                                      keyboardType: TextInputType.visiblePassword,
                                      prefixIcon: Icons.lock,
                                      isPassword: true,
                                      suffixIcon: Icons.remove_red_eye_outlined),
                                ],
                              ),
                            ),
                          )

              ).closed.then((value)
              {
                Navigator.pop(context);
                isBottomSheetShown=false;
                setState(() {
                  floatingActionButton=Icons.edit;
                });
              });
              isBottomSheetShown=true;
              setState(() {
                floatingActionButton=Icons.add;
              });
            }
        },


          child: Icon(floatingActionButton),

      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            currentIndex=index;
          });
        },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.login),
              label: 'Login'),
          BottomNavigationBarItem(
              icon: Icon(Icons.messenger),
              label: 'Messenger'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_outlined),
              label: 'Profile')
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: screens[currentIndex],
      ),
    );
  }

void createDataBase()async
{
  database = await openDatabase(
      'loginDB',
    version: 1,
    onCreate: (database,version)
    {
        print('database created');
        database.execute('CREATE TABLE login (id INTEGER PRIMARY KEY , email TEXT , password TEXT)').then((value) {
          print('table created');
        }).catchError((error){
          print('table created');
        });
    },
    onOpen: (database){
        print('database opened');
    }

    );
}

}
