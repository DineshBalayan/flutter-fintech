// @dart=2.10
import 'package:bank_sathi/Model/response/InsuranceProfile.dart';
import 'package:bank_sathi/Model/response/add_existing_loan_response.dart';
import 'package:bank_sathi/Model/response/add_lead_info_response.dart';
import 'package:bank_sathi/Model/response/app_pl_profile_response.dart';
import 'package:bank_sathi/Model/response/credit_card_list.dart';
import 'package:bank_sathi/Model/response/credit_card_profile.dart';
import 'package:bank_sathi/Model/response/personal_loan_profile.dart';

class AddLeadArguments {
  int leadCategoryId;
  AddLeadInfoData addLeadInfoData;
  LeadIdData leadIdData;
  CardData cardData;
  PLData plData;
  KIData kiData;
  Income income;
  String mobileNo;
  String city_name;
  String state_name;
  String earning;
  String employer;
  bool isCard = false;
  bool isEditing = false;

  // Uploads uploads;
  List<BankCards> cardsresponse;
}
