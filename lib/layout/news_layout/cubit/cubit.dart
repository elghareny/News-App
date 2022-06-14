import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/layout/news_layout/cubit/states.dart';
import 'package:test_app/modules/new_app/business.dart';
import 'package:test_app/modules/new_app/science.dart';
import 'package:test_app/modules/new_app/sports.dart';
import 'package:test_app/shared/cubit/states.dart';
import 'package:test_app/shared/network/local/cache_helper.dart';
import 'package:test_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);


  //////////////////////////////   BottomNavigationBar   ///////////////////////////

  int currentIndex = 0;
  List<BottomNavigationBarItem>bottomItems =
  [
    BottomNavigationBarItem(
        label: 'Business',
        icon: Icon(Icons.business_center_sharp)
    ),
    BottomNavigationBarItem(
        label: 'Sports',
        icon: Icon(Icons.sports_esports)
    ),
    BottomNavigationBarItem(
        label: 'Science',
        icon: Icon(Icons.science)
    ),
  ];

  void changeBottomNavBar(index) {
    currentIndex = index;
    getBusinessData();
     if (index == 1)
      getSportsData();
      if (index == 2)
      getScienceData();
    emit(NewsBottomNavBarState());
  }

  List<Widget>screens =
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen()
  ];


  /////////////////////////////  get business data //////////////////////////////////////////////


  List<dynamic> business = [];

  void getBusinessData() {
    emit(GETBusinessLoadingState());

    if (business.length == 0) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country': 'eg',
            'category': 'business',
            'apiKey': '7acea61b3fde40948a5419a9a08cb060',
          }).then((value) {
        business = value.data['articles'];
        print(business[0]['title']);
        emit(GETBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GETBusinessErrorState());
      });
    } else {
      emit(GETBusinessSuccessState());
    }
  }


////////////////////////////   get sports data    //////////////////////////////////////////////


  List<dynamic> sports = [];

  void getSportsData() {
    emit(GETSportsLoadingState());

    if (sports.length == 0) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country': 'eg',
            'category': 'sports',
            'apiKey': '7acea61b3fde40948a5419a9a08cb060',
          }).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(GETSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GETSportsErrorState());
      });
    } else {
      emit(GETSportsSuccessState());
    }
  }


////////////////////////////   get science data    //////////////////////////////////////////////


  List<dynamic> science = [];

  void getScienceData() {
    emit(GETScienceLoadingState());

    if (science.length == 0) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country': 'eg',
            'category': 'science',
            'apiKey': '7acea61b3fde40948a5419a9a08cb060',
          }).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(GETScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GETScienceErrorState());
      });
    } else {
      emit(GETScienceSuccessState());
    }
  }


////////////////////////////   get science data    //////////////////////////////////////////////


  List<dynamic> search = [];

  void getSearchData(String value) {
    emit(GETSearchLoadingState());
    search = [];
    DioHelper.getData(
        url: 'v2/everything',
        query:
        {
          'q': '$value',
          'apiKey': '7acea61b3fde40948a5419a9a08cb060',
        }).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(GETSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GETSearchErrorState());
    });
  }


}