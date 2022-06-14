
// base url : https://newsapi.org/
// method : v2/everything?
// query : q=tesla&from=2021-08-08&sortBy=publishedAt&apiKey=7acea61b3fde40948a5419a9a08cb060


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/layout/news_layout/cubit/cubit.dart';
import 'package:test_app/layout/news_layout/cubit/states.dart';
import 'package:test_app/modules/new_app/search.dart';
import 'package:test_app/shared/components/components.dart';
import 'package:test_app/shared/cubit/cubit.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: ( context, state) {},
      builder: ( context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(icon: Icon(Icons.search),
                  onPressed: ()
                  {
                    navigateTo(context,Search());
                  }),
              IconButton(icon: Icon(Icons.brightness_4_outlined),
                  onPressed: ()
                  {
                    AppCubit.get(context).changeAppTheme();
                  }),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
            onTap: (index)
            {
              cubit.changeBottomNavBar(index);
            },

          ),
        );
      },
    );
  }
}
