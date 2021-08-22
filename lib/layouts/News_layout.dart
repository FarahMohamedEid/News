import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';
import 'package:news/modules/search.dart';
import 'package:news/network/remote/dio_helper.dart';
import 'package:news/shared/componantes.dart';

class NewsHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state) {},
      builder: (context,state){

        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News layout'),
            actions: [
              IconButton(icon: Icon(Icons.search),
                  onPressed: (){
                  navigateTo(context, SearchScreen());
                  }),
              IconButton(icon: Icon(Icons.brightness_4),
                  onPressed: (){
                  NewsCubit.get(context).changeTheme();
                  }),
            ],
          ),
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.ChangeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
