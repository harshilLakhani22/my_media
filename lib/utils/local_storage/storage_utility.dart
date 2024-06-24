import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

class MLocalStorage {
  final GetStorage _storage = GetStorage('UserCacheBox');

  GetStorage get storage => _storage;

  Future<void> init()  async {
   await GetStorage.init();
  }

   static const String tokenKey = 'token';
   static const String userDataKey = 'userData';

   removeUserData(){
     removeData(tokenKey);
     removeData(userDataKey);
   }

   setToken(String? value) {
    saveData<String?>(tokenKey, value);
  }

    String? getToken() {
    return readData<String?>(tokenKey);
  }

  setUserData(dynamic value) {
    saveData(userDataKey, jsonEncode(value));
  }

  keepUserSignIn(){
     saveData("isLoggedIn", "true");
     // storage.write("isLoggedIn", "true");
  }

  checkUserSignIn(){
     return readData("isLoggedIn") ?? "false";
     // return storage.read("isLoggedIn") ?? "false";
  }

   dynamic getUserData() {
     debugPrint("UserData Fetching from Local");
     var userData = readData(userDataKey);
     debugPrint("Fetched UserData: $userData");
     if (userData != null) {
       return jsonDecode(userData);
     }
     debugPrint("getUserData() gives null");
     return null;
  }

  // Generic method to save data
   Future<void> saveData<T>(String key, T value) async {
    await storage.write(key, value);
  }

  // Generic method to read data
   T? readData<T>(String key) {
    return storage.read<T>(key);
  }

  // Generic method to remove data
   Future<void> removeData(String key) async {
    await storage.remove(key);
  }

}
