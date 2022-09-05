import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class Sciencecreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context ,state) {},
      builder:(context , state) {
        var list = NewsCubit.getInstance(context).scienceNews;
        return  buildConditionalNews(list);
      } ,
    );
  }
}
