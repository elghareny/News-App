import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/modules/new_app/web_view.dart';

Widget defaultTextFormField({
  bool isPassword =false,
  @required String label,
  Function onTap,
  Function onSubmit,
  Function onChange,
  @required Function validate,
  @required TextEditingController controller,
   TextInputType keyboardType ,
  @required IconData prefixIcon,
  IconData suffixIcon,
})=> TextFormField(
obscureText: isPassword,
onTap: onTap,
onChanged: onChange,
onFieldSubmitted: onSubmit,
validator: validate,
controller: controller,
keyboardType: keyboardType,
decoration: InputDecoration(
  labelStyle:TextStyle(
    color: Colors.black,
    fontSize: 18.0
  ) ,
labelText: label,
prefixIcon: Icon(prefixIcon),
suffixIcon:suffixIcon !=null ?Icon(suffixIcon):null,
focusedBorder: OutlineInputBorder(
  // border: OutlineInputBorder(
  //     borderSide: BorderSide(color: Colors.indigo[400]),
  //     borderRadius: BorderRadius.circular(10.0)),
),
border: OutlineInputBorder(
  borderSide: BorderSide(color: Colors.indigo[400]),
borderRadius: BorderRadius.circular(10.0)),
),
);

Widget defaultButton({
  Color backcolor = Colors.blue,
  double width=double.infinity,
  String text,
  Function onPressed,
}) =>
    Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.only(topLeft:Radius.zero ,bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20.0),topRight: Radius.circular(20.0)),
    color: backcolor,
  ),
  width: width,
  height: 55.0,
  child: MaterialButton(
    child: Text(text,
      style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w400,
          color: Colors.white
      ),
    ),
    onPressed: onPressed,
  ),
);




//////////////////////////////////////   Build Business  ,  Sports  ,  Science   ////////////////////////////////////////////////


Widget buildNews(articles ,context)=>InkWell(
  onTap: ()
  {
    navigateTo(context, webView(articles['url']),);
  },
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        Container(
  
          width: 120.0,
  
          height: 120.0,
  
          decoration: BoxDecoration(
  
              borderRadius: BorderRadius.circular(10.0),
  
              image: DecorationImage(
  
                  image: NetworkImage('${articles['urlToImage']}'),
  
                  fit: BoxFit.cover
  
              )
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20.0,
  
        ),
  
        Expanded(
  
          child: Container(
  
            height: 120.0,
  
            child: Column(
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              children: [
  
                Expanded(
  
                  child: Text('${articles['title']}',
  
                    maxLines: 3,
  
                    overflow: TextOverflow.ellipsis,
  
                    style: Theme.of(context).textTheme.bodyText1,
  
                  ),
  
                ),
  
                SizedBox(
  
                  height: 10.0,
  
                ),
  
                Text('${articles['publishedAt']}',
  
                  style: TextStyle(
  
                    fontSize: 15.0,
  
                    fontWeight: FontWeight.w400,
  
                    color: Colors.grey,
  
                  ),
  
                ),
  
              ],
  
            ),
  
          ),
  
        )
  
      ],
  
    ),
  
  ),
);


////////////////////////////////////   list of news    ////////////////////////////////////////////////////////


Widget listNews (list ,context , {isSearch = false})=>ConditionalBuilder(
  condition: list.length>0,
  builder: (context)=>ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index)=>buildNews(list[index],context),
      separatorBuilder: (context,index)=>Padding(
        padding: const EdgeInsets.only(top: 5.0,left: 20.0,right: 20.0,bottom: 5.0),
        child: Container(
          height: 1.0,
          color: Colors.teal[100],
        ),
      ),
      itemCount: list.length),
  fallback: (context) => isSearch ? Container() :  Center(child: CircularProgressIndicator()),);



//////////////////////////////   navigator   //////////////////////////////////////////

void navigateTo(context,widget)=>Navigator.push(context,
    MaterialPageRoute(builder: (context) =>widget),);