import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) :super(key:key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left:10,top:15),
          child:const Text('Deal of the day',style: TextStyle(fontSize: 20),)
        ),
        Image.network('https://images.unsplash.com/photo-1616423641454-caa695af6a0f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8YW1hem9uJTIwcHJvZHVjdHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
        height:235,
        fit:BoxFit.fitHeight),
        Container(
          padding:const EdgeInsets.only(left:15),
          alignment: Alignment.topLeft,
          child:const Text('\$999.0'),
          style:TextStyle(fontSize: 18)),
        Container(
          alignment: Alignment.topLeft,
          padding:const EdgeInsets.only(left:15,top: 5,right:14),
          child: const Text('Dhruv',maxLines: 2,overflow: TextOverflow.ellipsis,),
        )
      ],
    );
  }
}
