import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_text_field.dart';

class TabPage4 extends StatefulWidget {
  final jsonBloc;
  final validateProfession;
  final validateTelephone1;

  const TabPage4({Key key, this.jsonBloc, this.validateProfession, this.validateTelephone1}) : super(key: key);

  @override
  _TabPage4State createState() => _TabPage4State();
}

class _TabPage4State extends State<TabPage4> with AutomaticKeepAliveClientMixin<TabPage4> {
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
                validate: widget.validateProfession,
                icon: Icons.build,
                hint: "Profissão",
                parentAction: onSaved,
                title: 'profession',
              ),
              MyTextField(
                validate: widget.validateTelephone1,
                icon: Icons.phone,
                hint: "Telefone",
                parentAction: onSaved,
                title: 'telephone1',
              ),
              MyTextField(
                validate: widget.validateTelephone1,
                icon: Icons.phone,
                hint: "Telefone",
                parentAction: onSaved,
                title: 'telephone2',
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