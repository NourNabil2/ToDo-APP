import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/Cubit/cubit.dart';
import 'package:todo/components/notifications.dart';
import 'package:todo/home.dart';

Widget defaultFormField (
{

  @required controller,
  required TextInputType type ,
  required String lable,
  required IconData icon ,
 required onChange,
 required onFieldSubmitted ,
  required  valid ,
   ontap  ,
})=> Container(


  color: Colors.white,

  child:   TextFormField(

    style: TextStyle(color: Colors.black),

  validator: valid,

  cursorColor: Colors.deepPurpleAccent,


  controller: controller,

  keyboardType: type ,


  onFieldSubmitted: onFieldSubmitted ,

  onChanged: onChange ,

  onTap: ontap ,

  decoration:

  InputDecoration(
focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple , width: 1.5)),
  prefixIcon: Icon( icon ,  color: Colors.black,) ,

  hintText: lable,
 border: OutlineInputBorder(),
) ,


  ),
);


Widget buttomTasks(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  background: buildSwipeActionLeft(),
  secondaryBackground: buildSwipeActionRight(),
  child:
  Padding(

      padding: const EdgeInsets.all(15),

      child: Row(

        children: [

          CircleAvatar( radius: 35.0 , backgroundColor: Colors.deepPurpleAccent[200] ,  child:  Text('${model['time']}' ,style: TextStyle(color: Colors.white),),),

          SizedBox(width: 20.0,),

          Expanded(

            child: Column(

              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text('${model['title']}' , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black , fontSize: 20 ),),

                Text('${model['date']}' ,style: TextStyle (color: Colors.grey[500]),),

              ],),

          ),

          SizedBox(width: 20.0,),





          IconButton(onPressed: ()

          {

            AppCubit.get(context).updateData(status: 'done', id: model['id'] );

          }



          , icon: Icon(CupertinoIcons.checkmark_alt , color: Colors.black45, semanticLabel: 'done', )),

          SizedBox(width: 8.0,),





  //         IconButton(onPressed:()
  //
  //         {
  //
  //           AppCubit.get(context).updateData(status: 'archive', id: model['id'] );
  //
  // } ,
  //
  //
  //
  //
  //
  //             icon: Icon(Icons.archive_outlined , color:Colors.black45 ,)),

        ],

      ),

    ),

  onDismissed: (direction) {

switch (direction)
{
  case DismissDirection.startToEnd:
    AppCubit.get(context).DeletdateData(id: model['id']);
    NotificationService.CanceleNotification( 1 );
    break;
  case DismissDirection.endToStart:
    AppCubit.get(context).updateData(status: 'archive', id: model['id'] );
    break;


}



  },


);


Widget buildSwipeActionLeft( )
{


  return Container(alignment: Alignment.centerLeft, color: Colors.redAccent, padding: EdgeInsets.symmetric(horizontal: 20 ),child: Icon(CupertinoIcons.delete, color: Colors.white,),);

}

Widget buildSwipeActionRight()
{
  return Container(alignment: Alignment.centerRight, color: Colors.green, padding: EdgeInsets.symmetric(horizontal: 20 ),child: Icon(Icons.archive, color: Colors.white,),);
}
