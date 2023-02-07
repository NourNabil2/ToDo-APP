import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Cubit/cubit.dart';
import 'package:todo/Cubit/state.dart';
import 'package:todo/components/components.dart';

class archaiveScreen extends StatelessWidget {


  Widget build(BuildContext context) {

    if (AppCubit.get(context).archive.length == 0 )
    {
      return Center(
        child: Text('archive!' ,style: TextStyle(fontSize: 40, color: Colors.black26),),
      );
    }
    else
    {
      return BlocConsumer<AppCubit, Appstates>(

        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).archive;

          return ListView.separated(
              itemBuilder: (context, index) => buttomTasks(tasks[index], context),
              separatorBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 20.0,
                    ),
                    child: Container(width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],),
                  ),
              itemCount: tasks.length,
              physics: BouncingScrollPhysics(),
          );
        },

      );
    }



    // return Center(
    //   child: Text('No Tasks yet...', style: TextStyle(fontSize: 40, color: Colors.black26),),
    // );


  }

}
