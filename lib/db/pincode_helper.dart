import 'dart:async';

import 'package:bank_sathi/db/db_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinCodeHelper {
  RxBool _isInit = false.obs;

  bool get isInit => _isInit.value;

  set isInit(val) => _isInit.value = val;

  final _pinCodeList = <PinCodeRow>[].obs;

  List<PinCodeRow> get pinCodeList => _pinCodeList.value;

  set pinCodeList(val) => _pinCodeList.value = val;

  final _stateList = <StateRow>[].obs;

  List<StateRow> get stateList => _stateList.value;

  set stateList(val) => _stateList.value = val;

  final _cityList = <CityRow>[].obs;

  List<CityRow> get cityList => _cityList.value;

  set cityList(val) => _cityList.value = val;

  final _selectedState = StateRow().obs;

  StateRow? get selectedState =>
      _selectedState.value.id == null ? null : _selectedState.value;

  set selectedState(val) => _selectedState.value = val;

  final _selectedCity = CityRow().obs;

  CityRow? get selectedCity =>
      _selectedCity.value.id == null ? null : _selectedCity.value;

  set selectedCity(val) => _selectedCity.value = val;

  DBController dbController = Get.find();

  TextEditingController pinCodeController = TextEditingController();

  Future<void> init({int? pinCodeId}) async {
    if (pinCodeId == null) {
      stateList = await dbController.getAllState();
      selectedState = stateList.first;
      cityList = await dbController.getCitiesByState(selectedState!.id!);
      selectedCity = cityList.first;
    } else {
      PinCodeRow pinCode = await dbController.getPinCodesById(pinCodeId);
      pinCodeController.text = pinCode.pincode.toString();
      CityRow city = await dbController.getCityByCityId(pinCode.city_id!);
      stateList = await dbController.getAllState();
      cityList = await dbController.getCitiesByState(city.state_id!);
      selectedCity = cityList.firstWhere((element) {
        print("element.city_name : " + element.city_name!);
        print("city.city_name : " + city.city_name!);
        return element.id == city.id;
      });
      selectedState = stateList
          .firstWhere((element) => element.id == selectedCity!.state_id);
      print("Done");
    }
    isInit = true;
    return;
  }

  FutureOr<List<PinCodeRow>> getSuggestions(String char) async {
    if (char.length < 3) return <PinCodeRow>[];
    return dbController.getPinCodes(char);
  }
  FutureOr<StateRow> getStatebyStateId(int state_id) async {
    return await dbController.getStateById(state_id);
  }

  setSelectedState(int stateId) {
    selectedState = stateList.firstWhere((element) => element.id == stateId);
  }

  setSelectedCity(int cityId) {
    selectedCity = cityList.firstWhere((element) => element.id == cityId);
  }

  Future<void> updateCityList() async {
    cityList = await dbController.getCitiesByState(selectedState!.id!);
    selectedCity = cityList.first;
    return;
  }

  void dispose() {
    pinCodeController.dispose();
  }

  void onPinCodeSubmit(PinCodeRow pinCode) async {
    pinCodeController.text = pinCode.pincode.toString();
    CityRow city = await dbController.getCityByCityId(pinCode.city_id!);
    selectedState =
        stateList.firstWhere((element) => element.id == city.state_id);
    cityList = await dbController.getCitiesByState(selectedState!.id!);
    selectedCity = cityList.firstWhere((element) => element.id == city.id);
  }

  Future<int> isValidPinCode() async {
    List<PinCodeRow> pinCodes = await getSuggestions(pinCodeController.text);
    if(pinCodes.length != 1){
      selectedCity=-1;
      selectedState=-1;
      return  -1;
    }else{
      selectedCity = await dbController.getCityByCityId(pinCodes.first.city_id!);
      selectedState = await getStatebyStateId(selectedCity!.state_id!);
      return pinCodes.first.id!;
    }
  }

  PinCodeHelper();
}
