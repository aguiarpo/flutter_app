import 'dart:async';

import 'dart:convert';

class JsonBloc {
  final jsonController = StreamController();
  JsonProvider jsonProvider = new JsonProvider();

  Stream get getJSON => jsonController.stream;

  String get getValueJSON => json.encode(jsonProvider.values);

  Map get getValue => jsonProvider.values;

  Map get getValueAnimal => jsonProvider.animal;

  void addValue(index, value) {
    jsonProvider.addValue(index, value);
    jsonController.sink.add(jsonProvider
        .values);
  }

  void addValueAnimal(index, value) {
    jsonProvider.addValueAnimal(index, value);
    jsonController.sink.add(jsonProvider
        .animal);
  }

  void dispose() {
    jsonController
        .close();
  }
}

class JsonProvider {
  Map values = {};
  Map animal = {};

  void addValue(index, value){
    values[index] = value;
  }

  void addValueAnimal(index,value){
    animal[index] = value;
  }
}