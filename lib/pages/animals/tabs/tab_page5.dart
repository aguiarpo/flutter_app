import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/icons/surca_icons.dart';
import 'package:flutter_app/validates/validator_dates.dart';
import 'package:flutter_app/validates/validator_tutor.dart';
import 'package:flutter_app/validates/validator_user_login.dart';
import 'package:intl/intl.dart';

class TabPage5 extends StatefulWidget {
  final jsonBloc;
  final breed;
  final microchip;
  final name;
  final date;

  const TabPage5({Key key, this.jsonBloc, this.breed, this.microchip, this.name, this.date}) : super(key: key);

  @override
  _TabPage5State createState() => _TabPage5State();
}

class _TabPage5State extends State<TabPage5> with AutomaticKeepAliveClientMixin<TabPage5> {
  DateTime date2;

  var jsonBloc;
  TextEditingController controllerBreed = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerMicrochip = TextEditingController();
  DateTime controllerDate;

  @override
  void initState() {
    super.initState();
    jsonBloc = widget.jsonBloc;
    controllerName.text = widget.name;
    controllerBreed.text = widget.breed;
    controllerMicrochip.text = widget.microchip;
    if(widget.date != null)controllerDate = DateTime.parse(widget.date);
    Map values = {"title" : "birthDate", "value" : ""};
    onSaved(values);
  }


  void onSaved(values){
    jsonBloc.addValueAnimal(values['title'], values['value']);
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              MyTextField(
                controller: controllerName,
                validate: ValidateUserLogin.validateCity,
                icon: Icons.person,
                hint: "Nome",
                parentAction: onSaved,
                title: 'name',
              ),
              MyTextField(
                controller: controllerMicrochip,
                validate: ValidateTutor.validateRg,
                icon: Surca.animal,
                hint: "Microchip",
                parentAction: onSaved,
                title: 'microchipNumber',
              ),
              MyTextField(
                controller: controllerBreed,
                validate: ValidateUserLogin.validateCity,
                icon: Surca.animal,
                hint: "Raça",
                parentAction: onSaved,
                title: 'breed',
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: DateTimePickerFormField(
                  validator: (d) => ValidateDates.validateDate2(d),
                  inputType: InputType.date,
                  initialValue: controllerDate,
                  format: DateFormat("yyyy-MM-dd"),
                  initialDate: controllerDate,
                  editable: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 5.0),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      labelText: 'Date de nascimento',
                      hasFloatingPlaceholder: false
                  ),
                  onChanged: (dt) {
                    setState(() => date2 = dt);
                    Map values = {"title" : "birthDate", "value" : DateFormat("yyyy-MM-dd").format(dt).toString()};
                    onSaved(values);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}