import 'package:bank_sathi/Model/DemoListModel.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:get/get.dart';

import '../translations/string_keys.dart';

List<DemoListModel> getLeadCategories() {
  List<DemoListModel> list = <DemoListModel>[];
  DemoListModel l = DemoListModel(
      picAsset: 'assets/images/ic_loan.svg', title: loan.tr, type: 1);
  DemoListModel ins = DemoListModel(
      picAsset: 'assets/images/ic_insurance.svg', title: insurance.tr, type: 2);
  DemoListModel cc = DemoListModel(
      picAsset: 'assets/images/ic_credit_card.svg',
      title: credit_card.tr,
      type: 3);
  list.add(l);
  // list.add(ins);
  list.add(cc);
  return list;
}

List<DemoListModel> getInsuranceCategories() {
  return [
    DemoListModel(
        picAsset: 'assets/images/ic_use_vehicle_loan.svg',
        title: 'Health Insurance',
        type: 7),
    DemoListModel(
        picAsset: 'assets/images/ic_life_insurance.svg',
        title: 'Life Insurance',
        type: 8),
    DemoListModel(
        picAsset: 'assets/images/ic_car_insurance.svg',
        title: 'Vehicle Insurance',
        type: 9),
    DemoListModel(
        picAsset: 'assets/images/ic_term_insurance.svg',
        title: 'Term Insurance',
        type: 10),
    DemoListModel(
        picAsset: 'assets/images/ic_covid_insurance.svg',
        title: 'Covid-19 Insurance',
        type: 11),
  ];
}

List<DemoListModel> getYears() {
  List<DemoListModel> list = <DemoListModel>[];
  int count = 2020;
  for (int i = 0; i < 20; i++) {
    DemoListModel a1 = DemoListModel(
      title: count.toString(),
    );
    list.add(a1);
    count--;
  }
  return list;
}

List<DemoListModel> getPLFeatures() {
  return [
    DemoListModel(
        picAsset: 'assets/images/new_images/loan.svg',
        title: 'Commission',
        variant: 'Upto 4%'),
    DemoListModel(
        picAsset: 'assets/images/new_images/profile_image/bank.svg',
        title: 'Verified',
        variant: 'Banks'),
    DemoListModel(
        picAsset: 'assets/images/new_images/commission.svg',
        title: 'Affordable',
        variant: 'Interesr Rates'),
    DemoListModel(
        picAsset: 'assets/images/new_images/online.svg',
        title: 'Online',
        variant: 'Process'),
  ];
}

List<DemoListModel> getKIFeatures() {
  return [
    DemoListModel(
        picAsset: 'assets/images/new_images/insurance/covid.svg',
        title: 'Covid-19',
        variant: 'Cover'),
    DemoListModel(
        picAsset: 'assets/images/new_images/insurance/criticle.svg',
        title: 'Critical',
        variant: 'Illness Policy'),
    DemoListModel(
        picAsset: 'assets/images/new_images/insurance/low.svg',
        title: 'Minimum',
        variant: 'Premium'),
    DemoListModel(
        picAsset: 'assets/images/new_images/insurance/online.svg',
        title: '100% Digital',
        variant: 'Process'),
  ];
}
