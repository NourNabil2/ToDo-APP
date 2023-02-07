
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/Cubit/cubit.dart';
import 'package:todo/Cubit/state.dart';
import 'package:todo/components/components.dart';
import 'package:todo/components/notifications.dart';
import 'layout/Tasks.dart';
import 'layout/archaive.dart';
import 'layout/done.dart';

class homepage extends StatelessWidget

{

  @override
  var datecontroler2 = TextEditingController() ;
  var textcontroler = TextEditingController();
  var datecontroler = TextEditingController();
  var timecontroler = TextEditingController();
  var sk = GlobalKey<ScaffoldState>();
  var valid = GlobalKey<FormState>();


  List<Widget>bottom=[
    BottomNavigationBar(items: [
      BottomNavigationBarItem(icon: Icon(Icons.backup_table_rounded,color: Colors.deepPurpleAccent,),label: 'Tasks' ,),
      BottomNavigationBarItem(icon: Icon(Icons.checklist_outlined,color: Colors.deepPurpleAccent,),label: 'Done'),
      BottomNavigationBarItem(icon: Icon(Icons.archive_outlined,color: Colors.deepPurpleAccent,),label: 'archaive'),
    ])
  ];

  @override

  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AppCubit()..creatDataBase() ,
      child: BlocConsumer<AppCubit,Appstates>(
        listener: (context, state) {},
        builder: (context, state) {
         AppCubit Cubit = AppCubit.get(context);
          return Scaffold(
            key: sk,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white10,  //Colors.deepPurple,
              leading:  Icon(Icons.today_outlined ,color: Colors.deepPurpleAccent, ),
              title: Center(child:Text('ToDo              ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent,), )),
            ),
            floatingActionButton: FloatingActionButton( backgroundColor: Colors.deepPurpleAccent,onPressed: () {


              if (Cubit.showbottom) {
                sk.currentState?.showBottomSheet((context) => Container( color: Colors.black12, padding: EdgeInsets.all(20.0), child:
                Form(
                  key: valid,
                  child: Column(
                    mainAxisSize:MainAxisSize.min,

                    children: [










                      defaultFormField(
                        valid: (value){
                          if (value.isEmpty)
                          {
                            return ('title must not be empty !!');
                          }
                          return null;
                        },
                        controller: textcontroler ,
                        type: TextInputType.text,
                        lable: 'Title Task',
                        icon: Icons.title,
                        onChange: null,
                        onFieldSubmitted: null,
                        // valid: (String value)
                        // {
                        //   if (value.isEmpty)
                        //     {
                        //       return 'Title must not be empty!!';
                        //     }
                        //   else
                        //     {return null;}
                        // },
                      ),





                      SizedBox(height: 10,),
                      defaultFormField(
                        valid: ( value){
                          if (value.isEmpty)
                          {
                            return ('time must not be empty !!');
                          }
                          return null;
                        },
                        controller: timecontroler ,
                        type: TextInputType.datetime,
                        ontap: () async {  await showTimePicker(context: context, initialTime: TimeOfDay.now() , builder: (context, child) {
                          return Theme(data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(

                            onPrimary: Colors.white,
                            onSurface: Colors.deepPurpleAccent,
                          ),
                          ),
                              child: child!);
                        },  )
                            .then((value)=> timecontroler.text=value!.format(context).toString());




                          },
                        lable: '00:00',
                        icon: Icons.watch_later_outlined,
                        onChange: null,
                        onFieldSubmitted: null,
                      ),







                      SizedBox(height: 10,),
                      defaultFormField(
                        valid: ( value){
                          if (value.isEmpty)
                          {
                            return ('date must not be empty !!');
                          }
                          return null;
                        },
                        controller: datecontroler ,
                        type: TextInputType.text,
                        ontap: () { showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.parse('2050-1-1') , builder: (context, child) {
                          return Theme(data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(
                              onSurface: Colors.deepPurpleAccent
                          )), child: child!);
                        },).then((value) =>
                        datecontroler.text= DateFormat.yMd().format(value!));

                          },
                        lable: 'dd/mm/yyyy',
                        icon: Icons.date_range_outlined,
                        onChange: null,
                        onFieldSubmitted: null,
                      ),

                    ],
                  ),
                ),
                )).closed.then((value) {

                  Cubit.Changeicon(icon: Icons.edit, show: true);


                });

                Cubit.Changeicon(icon: Icons.add, show: false);


              }
              else {

                if (valid.currentState!.validate())
                {

                 NotificationService.showNotification(1, 'TIMEOUT', 'your task is time-out check it now',int.parse(datecontroler.text.split('/')[0]),int.parse(datecontroler.text.split('/')[2]),int.parse(datecontroler.text.split('/')[1]), int.parse(timecontroler.text.split(':')[0]) , int.parse(timecontroler.text.split(':')[1].split(' ')[0]) );

                  Cubit.insertTOdataBase(title: textcontroler.text, time: timecontroler.text, date: datecontroler.text).then((value) {


                    Navigator.pop(context);
                    Cubit.Changeicon(icon: Icons.edit, show: true);

                  } );


                }




              }
            }

                ,child: Icon(Cubit.fabicon,)),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 8,
              selectedItemColor: Colors.deepPurpleAccent,
              onTap: (value) {

                Cubit.changeIndex(value);

              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.backup_table_sharp,color: Colors.deepPurpleAccent ),label: 'Tasks' ,),
                BottomNavigationBarItem(icon: Icon(Icons.checklist_outlined,color: Colors.deepPurpleAccent,),label: 'Done'),
                BottomNavigationBarItem(icon: Icon(Icons.archive_outlined,color: Colors.deepPurpleAccent,),label: 'archaive'),
              ],
              type: BottomNavigationBarType.fixed,
              currentIndex: Cubit.current ,


            ),
            body: state is!AppGetDataLoding ? Cubit.screens[Cubit.current] : CircularProgressIndicator(color: Colors.deepPurpleAccent),
          );
        },
      ),
    );
  }









}

