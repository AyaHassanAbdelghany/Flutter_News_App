import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/home/home_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/shared/constants/constants.dart';
import 'package:news_app/shared/cubit/states.dart';

import '../../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{


  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems =[
    const BottomNavigationBarItem(
        icon: Icon(
            Icons.home

        ),
        label:'Home'
    ),
    const BottomNavigationBarItem(
        icon: Icon(
      Icons.business

      ),
        label:'Business'
    ),
    const BottomNavigationBarItem(
        icon: Icon(
            Icons.sports
        ),
        label:'Sports'
    ),
    const BottomNavigationBarItem(
        icon: Icon(
            Icons.science
        ),
        label:'Science'
    ),
  ];

  List<Widget> screens =[
    HomeScreen(),
    BusinessScreen(),
    SportsScreen(),
    Sciencecreen(),
  ];

  List<dynamic> homeNews = [];
  List<dynamic> businessNews = [];
  List<dynamic> sportsNews = [];
  List<dynamic> scienceNews = [];
  List<dynamic> searchNews = [];

  bool isDark = false;

  NewsCubit (): super(NewsInitialState());

  static NewsCubit getInstance (context) => BlocProvider.of(context);

  void changeIndex(int index){
    currentIndex = index;
    if(index ==1) {
      getNews(CATOGERY_BUSINESS);
    } else if(index == 2) {
      getNews(CATOGERY_SPORTS);
    }
    else if(index == 3) {
      getNews(CATOGERY_SCIENCE);
    }
    else{
      getNews(CATOGERY_HOME);
    }
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
      case CATOGERY_HOME :
        if(homeNews.length == 0) {
          homeNews = value.data['articles'];
        }
        emit(NewsGetHomeSuccessState());
        break;
      case CATOGERY_BUSINESS :
        if(businessNews.length == 0) {
          businessNews = value.data['articles'];
        }
        emit(NewsGetBusinessSuccessState());
        break;
      case CATOGERY_SPORTS :
        if(sportsNews.length == 0) {
          sportsNews = value.data['articles'];
        }
        emit(NewsGetSportsSuccessState());
        break;
      case CATOGERY_SCIENCE :
        if(scienceNews.length == 0) {
          scienceNews = value.data['articles'];
        }
        emit(NewsGetScienceSuccessState());
        break;
    }
  }

  void setCategoryNewsError(String category,String error){
    switch(category){
      case CATOGERY_HOME :
        emit(NewsGetHomeErrorState(error.toString()));
        break;
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

  void changeAppThemeMode( bool fromShared){
    if(fromShared){
      isDark = CacheHelper.getData(key: 'isDark') ?? false;
      emit(ChangeThemeModeState());
    }
    else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeThemeModeState());
        changeIndex(currentIndex);
      });
    }
  }

  void getSearchNews(String value){
    emit(NewsLoadingState());
    DioHelper.getNews(url: URL_SEARCH, query: {
      'q': value,
      'apiKey': APIKEY
    }).then((value)
    {
      searchNews = value.data['articles'];
      emit(NewsGetSearchSuccessState());

    }).catchError((error)
    {
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

}