import 'package:crud/model/useremodels.dart';

class Database {
  static Map<String, dynamic> mymap = {
    "name": "hari",
    "address": "home",
    "institute": "luminar"
  };

  Publicapiresponse userdatamodel = Publicapiresponse.fromJson(mymap);
}
