import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/shared/cubit/states.dart';
import 'package:test_app/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context)=>BlocProvider.of(context);


  bool isDark =false;

  void changeAppTheme ({bool fromShared})
  {
    if(fromShared != null)
    {
      isDark=fromShared;
      emit(AppThemeState());
    }else
      {
        isDark = !isDark;
        CacheHelper.putData(key:'isDark',value: isDark ).then((value)
        {
          emit(AppThemeState());
        });
      }

  }


}

