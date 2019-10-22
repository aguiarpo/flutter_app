import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/icons/surca_icons.dart';
import 'package:intl/intl.dart';

class TabPage5 extends StatefulWidget {
  @override
  _TabPage5State createState() => _TabPage5State();
}

class _TabPage5State extends State<TabPage5> {
  DateTime date2;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              MyTextField(
                icon: Icons.person,
                hint: "Nome",
              ),
              MyTextField(
                icon: Surca.animal,
                hint: "Microchip",
              ),
              MyTextField(
                icon: Surca.animal,
                hint: "Raça",
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
                    print('Selected date: $date2');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}