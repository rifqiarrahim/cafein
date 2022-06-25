import 'dart:convert';

import 'package:http/http.dart' as http;

//import 'package:travelbuddies_mobile/models/add_plan_request_model.dart';
//import 'package:travelbuddies_mobile/models/add_plan_response_model.dart';
import 'package:wisata_bandung/model/cafe_response_model.dart';

import '../model/Review_Response_Model.dart';
/*import 'package:travelbuddies_mobile/models/edit_user_request_model.dart';
import 'package:travelbuddies_mobile/models/login_request_model.dart';
import 'package:travelbuddies_mobile/models/login_response_model.dart';
import 'package:travelbuddies_mobile/models/plan_response.dart';
import 'package:travelbuddies_mobile/models/register_request_model.dart';
import 'package:travelbuddies_mobile/models/register_response_model.dart';
import 'package:travelbuddies_mobile/models/user_response_model.dart';
import 'package:travelbuddies_mobile/services/shared_services.dart';*/

class APIService {
  static var client = http.Client();

  static Future<List<CafeResponseModel>> getCafes() async {

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http('10.0.2.2:8000', '/api/cafe/');

    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    print(response.body);

    //Shared Services
    return cafeResponseJson(response.body);
    // }
  }
  static Future<List<ReviewResponseModel>> getReview(int id) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http('10.0.2.2:8000', '/api/review/${id.toString()}');

    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    print(response.body);

    //Shared Services
    return reviewResponseModelJson(response.body);
    // }
  }
}