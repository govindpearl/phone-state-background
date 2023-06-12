import 'package:flutter/material.dart';


class AddressDialog extends StatefulWidget {
  @override
  _AddressDialogState createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 400, // Update the width value to your desired width
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Govind',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text("Would you recommend him/her for below qualities ?", textAlign: TextAlign.center,),

                SizedBox(height: 20),

                //Text("Add Review",textAlign: TextAlign.start,),
                TextField(
                  minLines: 8,
                  maxLines: 10,

                  textInputAction: TextInputAction.newline,

                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: 'Write a review',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Color(0xffE8E8E8),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap:  () {},
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
