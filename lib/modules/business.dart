
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';
import 'package:news/shared/componantes.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
    listener: (context, state) {},
    builder: (context, state) {
    var list = NewsCubit.get(context).business;
    return ScreenTypeLayout(
        mobile: ArticleBuilder(list,context),
        desktop: Row(
          children: [
            Expanded(child: ArticleBuilder(list,context)),
            if(list.length>0)
            Expanded(
              child: Container(
                height: double.infinity,
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '${list[NewsCubit.get(context).businessSelected]['description']}',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      breakpoints: ScreenBreakpoints(
        desktop: 650,
        watch: 300,
        tablet:600 ,
      ),
    );
    },
    );
  }
}
