import 'package:flutter_app/database/repository/incidents_repository.dart';
import 'package:flutter_app/services/url.dart';

import '../request/modals_request.dart';

abstract class RefreshIncidents{

  static String urlName = Url.name + 'v1/admin/incidentes/';

  static Future refresh()async{
    await save();
    await update();
    await delete();
  }

  static Future save()async{
    List incidentsRegistered = await IncidentsRepository.getAllIncidentsRegistered();
    if(incidentsRegistered.isNotEmpty && incidentsRegistered != null)
      await ModalsRequest.post(incidentsRegistered, urlName);
  }

  static Future update()async{
    List incidentsEdited = await IncidentsRepository.getAllIncidentsEdited();
    if(incidentsEdited.isNotEmpty && incidentsEdited != null)
      await ModalsRequest.put(incidentsEdited, urlName);
  }

  static Future delete()async{
    List incidentsRemoved = await IncidentsRepository.getAllIncidentsRemovedToRequest();
    if(incidentsRemoved.isNotEmpty && incidentsRemoved != null)
      await ModalsRequest.delete(incidentsRemoved, urlName);
  }
}