import 'package:flutter_app/database/repository/medications_repository.dart';
import 'package:flutter_app/services/url.dart';

import '../request/modals_request.dart';

abstract class RefreshMedications{

  static String urlName = Url.name +  'v1/admin/medicacoes/';

  static Future refresh()async{
    await save();
    await update();
    await delete();
  }

  static Future save()async{
    List medicationsRegistered = await MedicationsRepository.getAllMedicationsRegistered();
    if(medicationsRegistered.isNotEmpty && medicationsRegistered != null)
      await ModalsRequest.post(medicationsRegistered, urlName);
  }

  static Future update()async{
    List medicationsEdited = await MedicationsRepository.getAllMedicationsEdited();
    if(medicationsEdited.isNotEmpty && medicationsEdited != null)
      await ModalsRequest.put(medicationsEdited, urlName);
  }

  static Future delete()async{
    List medicationsRemoved = await MedicationsRepository.getAllMedicationsRemovedToRequest();
    if(medicationsRemoved.isNotEmpty && medicationsRemoved != null)
      await ModalsRequest.delete(medicationsRemoved, urlName);
  }
}