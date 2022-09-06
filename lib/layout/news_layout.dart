import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){
        },
        builder: (context,state){
          var cubit = NewsCubit.getInstance(context);
          return  Scaffold(
            appBar: AppBar(
             title: const Text(
               'News App'
             ),
              actions: [
                IconButton(
                    onPressed: ()
                    {
                      navigatTo(context, SearchScreen());
                    },
                    icon: Icon(Icons.search)
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      end: 10.0
                  ),
                  child: IconButton(
                      onPressed: (){
                        cubit.changeAppThemeMode(false);
                      },
                      icon: const Icon(
                          Icons.brightness_4_outlined,
                      )
                  )
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
      );
  }
}
