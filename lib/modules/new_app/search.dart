import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/layout/news_layout/cubit/cubit.dart';
import 'package:test_app/layout/news_layout/cubit/states.dart';
import 'package:test_app/shared/components/components.dart';
import 'package:test_app/shared/cubit/states.dart';

class Search extends StatelessWidget
{
  var searchController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {  },
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextFormField(
                  controller: searchController,
                  label: 'Search',
                  prefixIcon: Icons.search,
                  validate: (String value)
                  {
                    if(value.isEmpty)
                    {
                      return 'search must not be empty ';
                    }
                    return null;
                  },
                  onChange: (value)
                  {
                    NewsCubit.get(context).getSearchData(value);
                  },
                ),
              ),
              Expanded(child: listNews(list,context , isSearch: true)),
            ],
          ),
        );
      },

    );
  }
}
