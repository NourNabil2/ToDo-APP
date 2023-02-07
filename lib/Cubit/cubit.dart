
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/Cubit/state.dart';

import 'package:todo/layout/Tasks.dart';
import 'package:todo/layout/archaive.dart';
import 'package:todo/layout/done.dart';

import '../components/notifications.dart';



class AppCubit extends Cubit<Appstates> {

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Map> tasks = []; // الداتا بتتخزن هنا
  List<Map> done = []; // الداتا بتتخزن هنا
  List<Map> archive = []; // الداتا بتتخزن هنا

  IconData fabicon = Icons.edit;
  bool showbottom = true;

  var database;

  int current = 0;

  List<Widget>screens = [

    TaskScreen(),
    doneScreen(),
    archaiveScreen(),

  ];

  void changeIndex(int index) {
    current = index;
    emit(AppChangeBottomNavBar());
  }


  void Changeicon({

    required IconData icon,
    required bool show,
  }) {
    showbottom = show;
    fabicon = icon;
    emit(ChangeIcon());
  }


void Noti()
{
  NotificationService noty = NotificationService();
  emit(notification());

}














//////////////////

  void creatDataBase() async
  {
     openDatabase('todo.db', version: 1 ,onCreate: (database, version) async  {
      print('created');
      await database.execute('CREATE TABLE Task (id INTEGER PRIMARY KEY, title TEXT, time TEXT , date TEXT ,status TEXT)');
    },
      onOpen: (database) {

        print('opened');
        getdatabase(database);
      },
    ).then((value) {
database=value;
      emit(AppCreateData());
     });
  }








  Future insertTOdataBase({

    required title,
    required time,
    required date,


  }) async
  {
   return await database.transaction((txn) async  {
       txn.rawInsert(
          'INSERT INTO Task (title,time,date,status)  VALUES("$title","$time","$date","new") ').then((value){

        emit(AppInseartTOData());
         getdatabase(database);
      });
    });

  }







  Future<List<Map>> getdatabase (database) async
  {
    emit(AppGetDataLoding());
    tasks = [];      // الداتا بتتخزن هنا
     done = [];      // الداتا بتتخزن هنا
    archive = [];

  return await database.rawQuery('SELECT * FROM Task').then((value){


          value.forEach((e) {
            if (e['status'] == 'new')
              tasks.add(e);
            else if (e['status'] == 'done')
              done.add(e);
            else
              archive.add(e);
          });

    emit(AppGetData());

  });
        }










  Future updateData(
      {
        required String status,
        required int id,

      }) async
  {
   database.rawUpdate(
        'UPDATE Task SET status = ? WHERE id = ?',
        ['$status', id ],

    ).then((value)
   {
     getdatabase(database);
     emit(AppUpdateData());
   }
   );

  }



  Future DeletdateData(
      {

        required int id,

      }) async
  {
    database.rawDelete(
        'DELETE FROM Task WHERE id = ?', [id],

    ).then((value)
    {
      getdatabase(database);
      emit(AppDeletedateData());
    }
    );

  }

}



