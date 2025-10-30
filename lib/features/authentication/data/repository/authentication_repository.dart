import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'package:river_pod/features/authentication/view/subscription_screen.dart';

import '../../login/data/model/login_model.dart';
import '../model/subscription_model.dart';



class AuthenticationRepository{
  final baseUrl = "https://api.restful-api.dev";

  Future<List<SubscriptionPlan>>fetchUser()async{
    final response = await http.get(Uri.parse("$baseUrl/objects"));

    debugPrint(response.statusCode.toString());
    final List<dynamic>data = jsonDecode(response.body);
    debugPrint(data.toString());



    if(response.statusCode == 200){

      return data.map((item)=>SubscriptionPlan.fromJson(item)).toList();
    }else{
      throw Exception("Failed to Load the subscription");
    }

  }


  Future<List<LoginModel>> createAccount ({required String email, required String password,required context}) async {
    var  requestBody = {
      "email": email,
      "password": password

    };
    final response = await http.post(Uri.parse("https://api.mrphrenfix.com/api/v1/auth/login"),body: jsonEncode(requestBody),headers: {"Content-Type":"Application/json"});

    debugPrint(response.statusCode.toString());

    if(response.statusCode == 200){
      debugPrint("Successfully login");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionScreen()));
      final List<dynamic>data = jsonDecode(response.body)['data'];
      return data.map((item)=>LoginModel.fromJson(item)).toList();


    }else{
      throw Exception("Failed to Load the subscription");
    }
  }

}