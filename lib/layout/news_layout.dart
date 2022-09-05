import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/constants/constants.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class NewsHomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=> NewsCubit()..getNews(CATOGERY_BUSINESS),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = NewsCubit.getInstance(context);
          return  Scaffold(
            appBar: AppBar(
             title: Text(
               'News App'
             ),
              actions: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: 10.0
                  ),
                  child: Icon(
                      Icons.search
                  ),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex] ,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
                items: cubit.bottomItems,
                 onTap: (index){
                  cubit.changeIndex(index);
           },
            ),
          );
        },
      ),
    );
  }
}
