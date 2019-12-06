import 'package:flutter_app/database/repository/city_repository.dart';
import 'package:flutter_app/database/repository/neighborhood_repository.dart';
import 'package:flutter_app/database/repository/state_repository.dart';
import 'package:flutter_app/models/city.dart';
import 'package:flutter_app/models/neighborhood.dart';
import 'package:flutter_app/models/state.dart';

abstract class AddressDb{
  static Future<Neighborhood> saveAddress(Neighborhood neighborhoodTutor) async {
    State stateTutor = neighborhoodTutor.city.state;
    City cityTutor = neighborhoodTutor.city;
    State state = await StateRepository.getByName(stateTutor.name);
    if(state == null){
      State savedState = await StateRepository.saveState(stateTutor);
      cityTutor.stateId = savedState.id;
      City savedCity = await CityRepository.saveCity(cityTutor);
      neighborhoodTutor.cityId = savedCity.id;
      return await NeighborhoodRepository.saveNeighborhood(neighborhoodTutor);
    }else{
      City city = await CityRepository.getByNameAndStateName(cityTutor.name, stateTutor.name);
      if(city == null){
        cityTutor.stateId = state.id;
        City savedCity = await CityRepository.saveCity(cityTutor);
        neighborhoodTutor.cityId = savedCity.id;
        return await NeighborhoodRepository.saveNeighborhood(neighborhoodTutor);
      }else{
        Neighborhood neighborhood = await NeighborhoodRepository.getByNameAndCityNameAndStateName(
            neighborhoodTutor.name, cityTutor.name, stateTutor.name);
        if(neighborhood == null){
          neighborhoodTutor.cityId = city.id;
          return await NeighborhoodRepository.saveNeighborhood(neighborhoodTutor);
        }else{
          return neighborhood;
        }
      }
    }
  }
}