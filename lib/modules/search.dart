import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';
import 'package:news/shared/componantes.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: defaultFormField(
                  validate: (String value){
                    if(value.isEmpty){
                      return'search must not be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  type: TextInputType.text,
                  prefix: Icons.search,
                  controller: searchController,
                  onChange: (value){
                    NewsCubit.get(context).getSearch(value);
                  }
                ),
              ),
              Expanded(
                child:ArticleBulder(list, context,isSearch: true),
              ),
            ],
          ) ,
        );
      },
    );
  }
}
