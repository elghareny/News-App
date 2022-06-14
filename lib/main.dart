import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:test_app/layout/news_layout/cubit/states.dart';
import 'package:test_app/shared/bloc_observer.dart';
import 'package:test_app/shared/cubit/cubit.dart';
import 'package:test_app/shared/cubit/states.dart';
import 'layout/news_layout/cubit/cubit.dart';
import 'layout/news_layout/news_layout.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  // ignore: unnecessary_statements
  DioHelper.init();
  await CacheHelper.init();

  bool isDark =CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget{

  final bool isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()..getBusinessData()..getSportsData()..getScienceData(),
        ),
        BlocProvider(
          create: (context) =>AppCubit()..changeAppTheme(
            fromShared: isDark,
          ),
        )
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.teal,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backgroundColor: Colors.white,
                elevation: 0.0,
                iconTheme: IconThemeData(
                    color: Colors.teal,
                    size: 5.0
                ),
                titleTextStyle:TextStyle(
                  color: Colors.teal,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w300,
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  elevation: 30.0,
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.teal,
                  type: BottomNavigationBarType.fixed,
                  showUnselectedLabels: false
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('333739'),
              primarySwatch: Colors.teal,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backgroundColor: HexColor('333739'),
                elevation: 0.0,
                iconTheme: IconThemeData(
                    color: Colors.teal,
                    size: 5.0
                ),
                titleTextStyle:TextStyle(
                  color: Colors.teal,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w300,
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  elevation: 30.0,
                  backgroundColor: HexColor('333739'),
                  selectedItemColor: Colors.teal,
                  unselectedItemColor: Colors.grey,
                  type: BottomNavigationBarType.fixed,
                  showUnselectedLabels: false
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),
              ),
            ),
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
          );
        },

      ),
    );
  }
}
