import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,State){},
      builder: (context,state){
        var list = NewsCubit.getInstance(context).searchNews;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defultTextFormField
                  (
                    controller: searchController,
                    type: TextInputType.text,
                    label: 'Search',
                    prefix: Icons.search,
                    functionValidator:(value)
                    {
                      if(value.isEmpty) {
                        return 'Search must not be empty';
                      }
                      return null;
                    },
                    functionOnChange: (value){
                      NewsCubit.getInstance(context).getSearchNews(value);
                    }
                ),
              ),
              Expanded(child: buildConditionalNews(list))
            ],
          )
        );
      },
    );
  }
}
