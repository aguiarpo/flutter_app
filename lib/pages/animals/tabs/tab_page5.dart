import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/icons/surca_icons.dart';
import 'package:intl/intl.dart';

class TabPage5 extends StatefulWidget {
  final jsonBloc;
  final validateName;
  final validateMicrochip;
  final validateBreed;

  const TabPage5({Key key, this.jsonBloc, this.validateName, this.validateMicrochip, this.validateBreed}) : super(key: key);

  @override
  _TabPage5State createState() => _TabPage5State();
}

class _TabPage5State extends State<TabPage5> with AutomaticKeepAliveClientMixin<TabPage5> {
  DateTime date2;

  var jsonBloc;

  @override
  void initState() {
    super.initState();
    jsonBloc = widget.jsonBloc;
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
                validate: widget.validateName,
                icon: Icons.person,
                hint: "Nome",
                parentAction: onSaved,
                title: 'name',
              ),
              MyTextField(
                validate: widget.validateMicrochip,
                icon: Surca.animal,
                hint: "Microchip",
                parentAction: onSaved,
                title: 'microchipNumber',
              ),
              MyTextField(
                validate: widget.validateBreed,
                icon: Surca.animal,
                hint: "Raça",
                parentAction: onSaved,
                title: 'breed',
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: DateTimePickerFormField(
                  inputType: InputType.date,
                  format: DateFormat("yyyy-MM-dd"),
                  initialDate: DateTime(2019, 1, 1),
                  editable: false,
                  resetIcon: null,
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
                    Map values = {"title" : "birthDate", "value" : dt.toString()};
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