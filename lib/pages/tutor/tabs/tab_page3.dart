import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_text_field.dart';

class TabPage3 extends StatefulWidget {
  final jsonBloc;
  final validateStreet;
  final validateNumber;
  final validateComplement;

  const TabPage3({Key key, this.jsonBloc, this.validateStreet, this.validateNumber, this.validateComplement}) : super(key: key);

  @override
  _TabPage3State createState() => _TabPage3State();
}

class _TabPage3State extends State<TabPage3> with AutomaticKeepAliveClientMixin<TabPage3> {

  var jsonBloc;

  @override
  void initState() {
    super.initState();
    jsonBloc = widget.jsonBloc;
  }

  void onSaved(values)  {
    jsonBloc.addValue(values['title'], values['value']);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              MyTextField(
                  validate: widget.validateStreet,
                  icon: Icons.location_city,
                  hint: "Rua",
                  parentAction: onSaved,
                  title: 'street'
              ),
              MyTextField(
                type: TextInputType.number,
                validate: widget.validateNumber,
                parentAction: onSaved,
                title: 'number',
                icon: Icons.mode_edit,
                hint: "Número",
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: TextFormField(
                  validator: widget.validateComplement,
                  onSaved: (value){
                    Map values = {"title" : "complement", "value" : value.trim()};
                    onSaved(values);
                  },
                  maxLines: 5,
                  style: new TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    hintText: "Complemento",
                  ),
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