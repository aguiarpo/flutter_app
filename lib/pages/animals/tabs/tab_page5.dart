import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/inputs/my_text_field.dart';
import 'package:flutter_app/components/inputs/select.dart';
import 'package:flutter_app/icons/surca_icons.dart';
import 'package:flutter_app/validates/validate.dart';
import 'package:flutter_app/validates/validator_dates.dart';
import 'package:intl/intl.dart';

class TabPage5 extends StatefulWidget {
  final jsonBloc;
  final microchip;
  final name;
  final date;
  final species;

  const TabPage5({Key key, this.jsonBloc, this.microchip, this.name, this.date, this.species}) : super(key: key);

  @override
  _TabPage5State createState() => _TabPage5State();
}

class _TabPage5State extends State<TabPage5> with AutomaticKeepAliveClientMixin<TabPage5> {
  DateTime date2;

  var jsonBloc;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerMicrochip = TextEditingController();
  DateTime controllerDate;
  String controllerSpecies;

  @override
  void initState() {
    super.initState();
    jsonBloc = widget.jsonBloc;
    controllerName.text = widget.name;
    controllerMicrochip.text = widget.microchip;
    if(widget.species != null) controllerSpecies = widget.species;
    else controllerSpecies = "Gato";
    setSelectValue(controllerSpecies);
    if(widget.date != null && widget.date != "") {
      controllerDate = DateTime.parse(widget.date);
      Map values = {"title": "birthDate", "value":  DateFormat("yyyy-MM-dd").format(controllerDate).toString()};
      onSaved(values);
    }
  }


  void onSaved(values){
    jsonBloc.addValueAnimal(values['title'], values['value']);
  }

  void setSelectValue(String value){
    jsonBloc.addValueAnimal('species', value);
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Select(
                  title: "Espécie",
                  value: controllerSpecies,
                  parentAction: setSelectValue,
                  list: ["Gato", "Cachorro", "Outro"],
                  padding: EdgeInsets.only(left: 10, right: 10),
                  border: BoxDecoration(
                    border: Border.all(color: Colors.grey,),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              MyTextField(
                controller: controllerName,
                validate: (value) => Validate.validateAll(value,
                    r"^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$",
                    'Caracteres inválidos'),
                icon: Icons.person,
                hint: "Nome do animal",
                parentAction: onSaved,
                title: 'name',
              ),
              MyTextField(
                controller: controllerMicrochip,
                validate: (value) => Validate.validateAll(value,
                    r"^([0-9.\-]+)*$", 'Caracteres inválidos'),
                icon: Surca.animal,
                hint: "Microchip",
                parentAction: onSaved,
                title: 'microchipNumber',
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: DateTimePickerFormField(
                  validator: ValidateDates.validateDate2,
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