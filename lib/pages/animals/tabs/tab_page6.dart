import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/inputs/select.dart';
import 'package:flutter_app/components/inputs/my_text_field.dart';
import 'package:flutter_app/icons/surca_icons.dart';
import 'package:flutter_app/validates/validate.dart';
import 'package:flutter_app/validates/validator_dates.dart';
import 'package:intl/intl.dart';

class TabPage6 extends StatefulWidget {
  final jsonBloc;
  final coatColor;
  final size;
  final date;
  final breed;

  const TabPage6({Key key, this.jsonBloc, this.coatColor, this.size, this.date, this.breed}) : super(key: key);

  @override
  _TabPage6State createState() => _TabPage6State();
}

class _TabPage6State extends State<TabPage6> with AutomaticKeepAliveClientMixin<TabPage6>{
  DateTime date2;

  TextEditingController controllerCoatColor = TextEditingController();
  String controllerSize;
  DateTime controllerDate;
  TextEditingController controllerBreed = TextEditingController();

  var jsonBloc;

  @override
  void initState() {
    super.initState();
    jsonBloc = widget.jsonBloc;
    controllerCoatColor.text = widget.coatColor;
    controllerBreed.text = widget.breed;
    if(widget.size != null)controllerSize = widget.size;
    else controllerSize = "Médio";
    setSelectValue(controllerSize);
    if(widget.date != null && widget.date != "") {
      controllerDate = DateTime.parse(widget.date);
      Map values = {"title": "dateMicrochip", "value": DateFormat("yyyy-MM-dd").format(controllerDate).toString()};
      onSaved(values);
    }
  }

  void onSaved(values){
    jsonBloc.addValueAnimal(values['title'], values['value']);
  }

  void setSelectValue(String value){
    jsonBloc.addValueAnimal('size', value);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 30, bottom: 10),
                    child: Select(
                      title: "Porte",
                      value: controllerSize,
                      parentAction: setSelectValue,
                      list: ["Mini", "Pequeno",'Médio', "Grande", "Gigante"],
                      padding: EdgeInsets.only(left: 10, right: 10),
                      border: BoxDecoration(
                        border: Border.all(color: Colors.grey,),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
              MyTextField(
                controller: controllerBreed,
                validate: (value) => Validate.validateAll(value,
                    r"^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$",
                    'Caracteres inválidos'),
                icon: Surca.animal,
                hint: "Raça",
                parentAction: onSaved,
                title: 'breed',
              ),
              MyTextField(
                controller: controllerCoatColor,
                validate: (value) => Validate.validateAll(value,
                    r"^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$",
                    'Caracteres inválidos'),
                icon: Icons.color_lens,
                hint: "Cor da pelagem",
                parentAction: onSaved,
                title: 'coatColor',
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: DateTimePickerFormField(
                  validator: ValidateDates.validateDate2,
                  inputType: InputType.date,
                  format: DateFormat("yyyy-MM-dd"),
                  initialValue: controllerDate,
                  initialDate: controllerDate,
                  editable: true,
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
                    Map values = {"title" : "dateMicrochip", "value" : DateFormat("yyyy-MM-dd").format(dt).toString()};
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