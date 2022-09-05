import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/constants/constants.dart';
import 'package:news_app/shared/cubit/states.dart';

import '../../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{


  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems =[
    BottomNavigationBarItem(
        icon: Icon(
      Icons.business

      ),
        label:'Business'
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.sports
        ),
        label:'Sports'
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.science
        ),
        label:'Science'
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.settings
        ),
        label:'Settings'
    ),

  ];

  List<Widget> screens =[
    BusinessScreen(),
    SportsScreen(),
    Sciencecreen(),
    SettingsScreen(),
  ];

  List<dynamic> businessNews = [];
  List<dynamic> sportsNews = [];
  List<dynamic> scienceNews = [];

  NewsCubit (): super(NewsInitialState());

  static NewsCubit getInstance (context) => BlocProvider.of(context);

  void changeIndex(int index){
    currentIndex = index;
    if(index ==1)  getNews(CATOGERY_SPORTS);
    else if(index == 2) getNews(CATOGERY_SCIENCE);
    emit(NewsChangeBottomNavBarState());
  }

  void getNews(String category){
    emit(NewsLoadingState());
    DioHelper.getNews(url: URL, query: {
      'country': COUNTRY,
      'category': category,
      'apiKey': APIKEY
    }).then((value)
    {
      setCategoryNewsSuccess(category,value);
    }).catchError((error)
    {
      setCategoryNewsError(category, error);
    });
  }

  void setCategoryNewsSuccess(String category,Response<dynamic> value){
    switch(category){
      case CATOGERY_BUSINESS :
        if(businessNews.length==0)
        businessNews = value.data['articles'];
        emit(NewsGetBusinessSuccessState());
        break;
      case CATOGERY_SPORTS :
        if(sportsNews.length==0)
          sportsNews = value.data['articles'];
        emit(NewsGetSportsSuccessState());
        break;
      case CATOGERY_SCIENCE :
        if(scienceNews.length==0)
          scienceNews = value.data['articles'];
        emit(NewsGetScienceSuccessState());
        break;
    }
  }

  void setCategoryNewsError(String category,String error){
    switch(category){
      case CATOGERY_BUSINESS :
        emit(NewsGetBusinessErrorState(error.toString()));
        break;
      case CATOGERY_SPORTS :
        emit(NewsGetSportsErrorState(error.toString()));
        break;
      case CATOGERY_SCIENCE :
        emit(NewsGetScienceErrorState(error.toString()));
        break;
    }
  }

}