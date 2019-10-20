import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/colors.dart';
import 'package:intl/intl.dart';


import 'login.dart';

class ConfigPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ConfigPageState();
  }
}

class _ConfigPageState extends State<ConfigPage> {
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ColorsUsed.greenDarkColor, //change your color here
        ),
        title: Text("Configurações", style: TextStyle(
          fontFamily: 'Roboto', fontWeight: FontWeight.w400,
          color: ColorsUsed.greenDarkColor,
        ),
        ),
        backgroundColor: ColorsUsed.mainColor,
      ),
      body: Builder(
          builder: (context) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text("Configurações", style: TextStyle(color: ColorsUsed.greenDarkColor, fontSize: 30)),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                        child: Divider(
                          height: 60,
                          color: ColorsUsed.terciaryColor,
                        )
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/editCont');
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10),
                        width: MediaQuery.of(context).size.width - 80,
                        decoration: BoxDecoration(
                          color:  ColorsUsed.terciaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text("Editar Conta", style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: DateTimePickerFormField(
                        inputType: InputType.time,
                        controller: _typeAheadController,
                        format: DateFormat("h:mm a"),
                        initialDate: DateTime(2019, 1, 1),
                        editable: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 5.0),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            labelText: 'Date de nascimento',
                        ),
                        initialTime: TimeOfDay(hour: 12, minute: 0),
                        onChanged: (dt) {
                          setState((){
                            if(dt == null) _typeAheadController.selection;
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()
                            ),
                            ModalRoute.withName("/")
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
                        width: MediaQuery.of(context).size.width - 80,
                        decoration: BoxDecoration(
                          color:  ColorsUsed.terciaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text("Sair", style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
