import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/states.dart';
import 'package:news/modules/business.dart';
import 'package:news/modules/science.dart';
import 'package:news/modules/sittings.dart';
import 'package:news/modules/sport.dart';
import 'package:news/network/local/cache_helper.dart';
import 'package:news/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(AppInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'business'),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports_basketball),
        label: 'sports'),
    BottomNavigationBarItem(
        icon: Icon(Icons.science),
        label: 'science'),
  ];

  void ChangeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    emit(AppChangeBottomNavBarState());
  }

  List<Widget> Screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];


  List<dynamic> business = [];
  int businessSelected = 0 ;

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': '25115e1120574d2798a5d2158983282c',
        }).then((value) {
      print('Dataaaaaaaaaa' + value.data.toString());
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print('Eroooooor on get data =>' + error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void changeBusinessSelected(index){
    businessSelected = index;
    emit(NewsGetSelectedItemChangeState());
  }


  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'sports',
            'apiKey': '25115e1120574d2798a5d2158983282c',
          }).then((value) {
        print('Dataaaaaaaaaa' + value.data.toString());
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print('Eroooooor on get data =>' + error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }


  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'science',
            'apiKey': '25115e1120574d2798a5d2158983282c',
          }).then((value) {
        print('Dataaaaaaaaaa' + value.data.toString());
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print('Eroooooor on get data =>' + error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  bool darkMode = false;

  void changeTheme({bool fromShared}) {
    if(fromShared !=null){
      darkMode=fromShared;
      emit(AppChangeThemeState());
    }else{
      darkMode = !darkMode;
      CacheHelper.setbool(key: 'darkMode', value: darkMode).then((value) {
        emit(AppChangeThemeState());
      }
      );
    }
  }



  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
      DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q': '$value',
            'apiKey': '25115e1120574d2798a5d2158983282c',
          }).then((value) {
        print('Dataaaaaaaaaa' + value.data.toString());
        search = value.data['articles'];
        emit(NewsGetSearchSuccessState());
      }).catchError((error) {
        print('Eroooooor on get data =>' + error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });

  }

}