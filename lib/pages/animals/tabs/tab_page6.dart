import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/icons/surca_icons.dart';
import 'package:intl/intl.dart';

class TabPage6 extends StatefulWidget {
  final jsonBloc;
  final validateSpecies;
  final validateCoatColor;
  final validateSize;

  const TabPage6({Key key, this.jsonBloc, this.validateSpecies, this.validateCoatColor, this.validateSize}) : super(key: key);

  @override
  _TabPage6State createState() => _TabPage6State();
}

class _TabPage6State extends State<TabPage6> with AutomaticKeepAliveClientMixin<TabPage6>{
  DateTime date2;


  var jsonBloc;

  @override
  void initState() {
    super.initState();
    jsonBloc = widget.jsonBloc;
    Map values = {"title" : "dateMicrochip", "value" : ""};
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
                validate: widget.validateSpecies,
                icon: Surca.animal,
                hint: "Espécie",
                parentAction: onSaved,
                title: 'species',
              ),
              MyTextField(
                validate: widget.validateCoatColor,
                icon: Icons.color_lens,
                hint: "Cor da pelagem",
                parentAction: onSaved,
                title: 'coatColor',
              ),
              MyTextField(
                validate: widget.validateSize,
                icon: Icons.arrow_upward,
                hint: "Porte",
                parentAction: onSaved,
                title: 'sizeCm',
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
                      labelText: 'Date da microchipagem',
                      hasFloatingPlaceholder: false
                  ),
                  onChanged: (dt) {
                    setState(() => date2 = dt);
                    Map values = {"title" : "dateMicrochip", "value" : dt.toString()};
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