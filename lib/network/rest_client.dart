import 'dart:async';
import 'dart:io';
import 'package:bank_sathi/Model/request/MPinRequest.dart';
import 'package:bank_sathi/Model/request/add_customer_request.dart';
import 'package:bank_sathi/Model/request/add_existing_loan_request.dart';
import 'package:bank_sathi/Model/request/add_income_detail_request.dart';
import 'package:bank_sathi/Model/request/addcreditcardrequest.dart';
import 'package:bank_sathi/Model/request/check_update_request.dart';
import 'package:bank_sathi/Model/request/fcm_token_request.dart';
import 'package:bank_sathi/Model/request/kotal_insurance_nominee_request.dart';
import 'package:bank_sathi/Model/request/lead_personal_info_request.dart';
import 'package:bank_sathi/Model/request/login_request.dart';
import 'package:bank_sathi/Model/request/my_leads_request.dart';
import 'package:bank_sathi/Model/request/pan_varify_request.dart';
import 'package:bank_sathi/Model/request/pl_card_eligibility_request.dart';
import 'package:bank_sathi/Model/request/save_personal_detail_request.dart';
import 'package:bank_sathi/Model/request/update_account_request.dart';
import 'package:bank_sathi/Model/response/CaptchaResponse.dart';
import 'package:bank_sathi/Model/response/CustomerQueryResponse.dart';
import 'package:bank_sathi/Model/response/GetMyLeadsResponse.dart';
import 'package:bank_sathi/Model/response/InsuranceProfile.dart';
import 'package:bank_sathi/Model/response/LeadDetailResponse.dart';
import 'package:bank_sathi/Model/response/LeaderBoardResponse.dart';
import 'package:bank_sathi/Model/response/PincodeVerifyResponse.dart';
import 'package:bank_sathi/Model/response/ProductDetailResponse.dart';
import 'package:bank_sathi/Model/response/ProductUrl.dart';
import 'package:bank_sathi/Model/response/SocialCardsListResponse.dart';
import 'package:bank_sathi/Model/response/SupportQueryListResponse.dart';
import 'package:bank_sathi/Model/response/add_existing_loan_response.dart';
import 'package:bank_sathi/Model/response/base_response.dart';
import 'package:bank_sathi/Model/response/company_response.dart';
import 'package:bank_sathi/Model/response/credit_card_list.dart';
import 'package:bank_sathi/Model/response/credit_card_profile.dart';
import 'package:bank_sathi/Model/response/down_time_response.dart';
import 'package:bank_sathi/Model/response/get_dropdown_data_response.dart';
import 'package:bank_sathi/Model/response/get_faqs_response.dart';
import 'package:bank_sathi/Model/response/get_knowledge_response.dart';
import 'package:bank_sathi/Model/response/get_my_team_response.dart';
import 'package:bank_sathi/Model/response/get_section_help_response.dart';
import 'package:bank_sathi/Model/response/get_training_video_response.dart';
import 'package:bank_sathi/Model/response/get_user_response.dart';
import 'package:bank_sathi/Model/response/kotak_member_detail_response.dart';
import 'package:bank_sathi/Model/response/kotak_personal_info_response.dart';
import 'package:bank_sathi/Model/response/lead_transaction_response.dart';
import 'package:bank_sathi/Model/response/login_response.dart';
import 'package:bank_sathi/Model/response/login_verification_response.dart';
import 'package:bank_sathi/Model/response/notification_response.dart';
import 'package:bank_sathi/Model/response/parent_product_detail_response.dart';
import 'package:bank_sathi/Model/response/personal_loan_profile.dart';
import 'package:bank_sathi/Model/response/query_detail_response.dart';
import 'package:bank_sathi/Model/response/referral_transactions_response.dart';
import 'package:bank_sathi/Model/response/support_types.dart';
import 'package:bank_sathi/Model/response/tds_response.dart';
import 'package:bank_sathi/Model/response/withdrawal_transactions_response.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/model/faq_model.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/model/training_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';

import 'header_interceptor.dart';
import 'logging_interceptor.dart';

part 'rest_client.g.dart';

//flutter pub run build_runner build --delete-conflicting-outputs

@RestApi()
abstract class RestClient {
  static _RestClient? _restClient;

  static const String DEV_URL = "https://dev.banksathi.com/api";
  // static const String CRM_URL = "https://crm.banksathi.com/api";
  static const String CRM_URL = "https://dev.banksathi.com/api";

  factory RestClient() {
    if (_restClient == null) {
      Dio dio = Dio();
      BaseOptions options = BaseOptions(
          receiveTimeout: 100000, connectTimeout: 100000, sendTimeout: 300000);
      dio.options = options;
      if (!kReleaseMode) {
        dio.interceptors.add(LoggingInterceptors());
      }
      dio.interceptors.add(HeaderInterceptors(dio));
      _restClient = _RestClient(dio, baseUrl: kDebugMode ? DEV_URL : CRM_URL);
    }
    return _restClient!;
  }

  @POST('/besath_loginb')
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @POST('/besath_loginb')
  Future<LoginVerificationResponse> verifyLogin(
      @Body() LoginRequest loginRequest);

  @POST('/besath_true_loginb')
  Future<LoginVerificationResponse> trueLogin(
      @Body() LoginRequest loginRequest);

  @GET('/besath_getdropdownsb')
  Future<GetDropDownDataResponse> getDropDowns();

  @GET('/besath_getuserb')
  Future<GetUserResponse> getUser(@Query('user_id') int id);

  @GET('/v2/besath_dashboardb')
  Future<GetUserResponse> dashboardApi(
      @Query('user_id') int id, @Query('date_time') String date);

  @POST('/besath_update_accountb')
  Future<LoginVerificationResponse> updateAccount(
      @Body() UpdateAccountRequest updateAccountRequest);

  @POST('/besath_personal_detailsb')
  Future<BaseResponse> personalDetails(
      @Body() SavePersonalDetailsRequest savePersonalDetailsRequest);

  @POST('/besath_bank_detailsb')
  Future<BaseResponse> bankDetails(@Part(value: 'user_id') String user_id,
      {@Part(value: 'bank_id') String? bank_id,
      @Part(value: 'name_on_bank') String? name_on_bank,
      @Part(value: 'account_no') String? account_no,
      @Part(value: 'ifsc_code') String? ifsc_code,
      @Part(value: 'uploads') String? uploads,
      @Part(value: 'upload_doc') File? file});

  @POST('/besath_kyc_updateb')
  Future<BaseResponse> kycDetails(@Query('user_id') String? user_id,
      {@Query('pan_no') String? pan_no,
      @Query('gst_no') String? gst_no,
      @Query('adhar_no') String? adhar_no});

  @POST('/besath_pro_detailsb')
  Future<BaseResponse> proDetails(
      {@Query("did_sell") String? did_sell,
      @Query("office_space") String? office_space,
      @Query("pos_income_id") String? pos_income_id,
      @Query("pos_licence") String? pos_licence,
      @Query("total_bus_anum") String? total_bus_anum,
      @Query("total_fn_month") String? total_fn_month,
      @Query("total_fn_yr") String? total_fn_yr,
      @Query("user_id") String? user_id});

  @POST('/besath_profile_picb')
  Future<BaseResponse> profilePic(@Part(value: 'user_id') String user_id,
      {@Part(value: 'profile_photo') File? photoFile});

  @POST('/besath_search_companiesb')
  Future<CompanyResponse> searchCompanies(@Query("q") String? search,
      {@CancelRequest() CancelToken? cancelToken});

/*besath_myteamb*/
  @GET('/v2/besath_myteamb')
  Future<GetMyTeamResponse> myTeam(
      @Query("user_id") int user_id,
      @Query("is_active") int? is_active,
      @Query("active_user") int? active_user,
      @Query("inactive_user") int? inactive_user,
      @Query("page") int page,
      @Query("user_code") String user_code,
      @Query("fromDate") String fromDate,
      @Query("toDate") String toDate,
      @Query("topEarner") int topEarner,
      @Query("recentAdded") int recentAdded);

  /*  @POST('/v1/besath_myleads_v2b')
  Future<GetMyLeadsResponse> myLeads(
      @Query("product_id") int? user_id, @Body() MyLeadsRequest request);
  */

  @POST('/v2/besath_myleads_b')
  Future<GetMyLeadsResponse> myLeads(
      @Query("product_id") int? user_id, @Body() MyLeadsRequest request);

  @POST('/v2/besath_lead_detail_b')
  Future<LeadDetailResponse> leadsDetail(@Body() MyLeadsRequest request);

  @POST('/v1/besath_lead_boardb')
  Future<LeaderBoardResponse> leaderBoard(@Body() MyLeadsRequest request);

  @POST('/v1/besath_lead_commentb')
  Future<BaseResponse> leadsComment(@Body() MyLeadsRequest request);

  @POST('/{path}')
  Future<AddExistingLoanResponse> addPLIsLoan(
      @Body() AddExistingLoanRequest addExistingLoanRequest,
      @Path('path') String path);

  @POST('/{path}')
  Future<AddExistingLoanResponse> addIncomeDetail(
      @Body() AddIncomeDetailRequest addIncomeDetailRequest,
      @Path('path') String path);

  @POST('/besath_checkupdateb')
  Future<BaseResponse> checkUpdate(
      @Body() CheckUpdateRequest checkupdaterequest);

  @POST('/besath_fcm_toknb')
  Future<BaseResponse> fcmToken(@Body() FcmTokenRequest fcmTokenRequest);

  @GET('/v1/besath_social_cardb')
  Future<SocialCardsListResponse> socialCards();

  @GET('/besath_getnotib')
  Future<NotificationResponse> getNotifications();

  @GET('/besath_get_knowledge_videosb')
  Future<GetKnowledgeResponse> getKnowledgeVideo();

  @GET('/besath_get_support_type_listb')
  Future<SupportTypeResponse> getSupportTypes();

  @POST('/besath_add_support_requestb')
  Future<CustomerQueryResponse> addSupportRequest(
      @Body() AddCustomerRequest req);

  @GET('/besath_get_support_listb')
  Future<SupportQueryListResponse> getSupportList(@Query('user_id') int id);

  @POST('/besath_get_covid_ins_otpb')
  Future<BaseResponse> kotakHealthOTP(@Query('mobile_no') String mobileNo);

  @POST('/v1/besath_verify_otp_covid_insb')
  Future<InsuranceProfile> kotakInsVerifyOTP(@Body() LoginRequest loginRequest);

  @POST('/v1/besath_verify_otp_plb')
  Future<PersonalLoanProfile> PLVerifyOTP(@Body() LoginRequest loginRequest);

  @POST('/besath_covid_personal_infob')
  Future<KotakPersonalInfoResponse> kotakHealthPersonalInfo(
      @Body() LeadPersonalInfoRequest leadPersonalInfoRequest);

  @POST('/besath_covid_members_detailsb')
  Future<KotakMemberDetailResponse> kotakHealthMemberDetail(
      @Body() KotakMemberDetail kotakMemberDetail);

  @POST('/besath_covid_add_nomineeb')
  Future<BaseResponse> kotakHealthNomineeDetail(
      @Body() KotakInsuranceNomineeRequest kotakInsuranceNomineeRequest);

  @POST('/besath_add_cardb')
  Future<BaseResponse> addCreditCardid(@Body() AddCreditCardRequest req);

  /* @POST('/v2/besath_pan_verifyb')
  Future<BaseResponse> panCardVerify(@Body() PanVerifyRequest req);
*/

  @POST('/v2/besath_pan_verifyb')
  Future<BaseResponse> panCardVerify(@Body() PanVerifyRequest req);

  @POST('/besath_check_pincode_elegibilityb')
  Future<PincodeVerifyResponse> pinCodeVerify(@Body() PanVerifyRequest req);

  @POST('/v1/besath_verify_otp_cardb')
  Future<CrediCardProfile> verifyOtpCard(@Body() LoginRequest req);

  @POST('/v3/besath_product_detailb')
  Future<ProductDetailResponse> productDetail(
      @Query('product_id') String product_id, @Query('user_id') int user_id);

  @POST('/v3/besath_gat_prodact_url')
  Future<ProductUrl> productUrl(@Query('product_id') String product_id,
      @Query('advisor_code') String user_id);

  @POST('/v3/besath_tren_compb')
  Future<BaseResponse> trainingComplete(
      @Query('product_id') String product_id, @Query('user_id') int user_id);

  @POST('/v1/besath_check_eligibilityb')
  Future<CreditCardsList> checkCardEligibity(
      @Body() PL_CardEligibilityRequest req);

  @POST('/v1/besath_addpl_detailsb')
  Future<BaseResponse> addPLDetail(@Body() PL_CardEligibilityRequest req);

  @POST('/v2/besath_parent_product_detailb')
  Future<ParentProductDetailResponse> getParentProductDetail(
      @Query('product_id') String productId);

  @GET('/besath_faq_listb')
  Future<GetFAQsResponse> getAppFaqs();

  @GET('/get_help_list')
  Future<FaqModel> getHelpFaqs();

  @GET('/get_help_for_products')
  Future<FaqModel> getHelpForProducts();

  @GET('/get_help_for_Training')
  Future<TrainingModel> getHelpForTraining();

  @GET('/besath_get_support_viewb')
  Future<QueryDetailResponse> getQueryDetail(
      @Query('user_id') String user_id, @Query('support_id') int support_id);

  @GET('/besath_add_support_commentb')
  Future<QueryDetailResponse> addQueryComment(@Query('user_id') String user_id,
      @Query('support_id') int support_id, @Query('comment') String comment);

  @POST('/v3/besath_paytm_payoutb')
  Future<BaseResponse> withdrawRequest(
      @Query('user_id') String user_id, @Query('mobile_no') String mobile_no);

  @POST('/v3/besath_paytm_payout_bankb')
  Future<BaseResponse> withdrawRequestBank(@Query('user_id') String user_id);

  @POST('/v1/besath_validate_bank_accountb')
  Future<BaseResponse> verifyBankAccount(
      @Query('user_id') String user_id,
      @Query('account_no') String account_no,
      @Query('name_on_bank') String name_on_bank,
      @Query('ifsc_code') String ifsc_code,
      @Query('bank_id') String bank_id);

  @POST('/v1/besath_getpaytm_otpb')
  Future<BaseResponse> getPaytmOtp(@Body() LoginRequest loginRequest);

  @POST('/v1/besath_verify_otp_paytmdb')
  Future<LoginVerificationResponse> verifyPaytmOtp(
      @Body() LoginRequest loginRequest);

  @POST('/v1/besath_getCaptcha')
  Future<CaptchaResponse> getCaptcha();

  @POST('/v1/besath_getNewCaptcha')
  Future<CaptchaResponse> getNewCaptcha(
    @Query('uuid') String uuid,
  );

  /* @POST('/v1/besath_enter_adhar')
  Future<BaseResponse> getAdharOTP(
    @Query('user_id') int user_id,
    @Query('adhar') String adhar,
  );*/
  @POST('/v2/besath_enter_adhar')
  Future<BaseResponse> getAdharOTP(
    @Query('user_id') int user_id,
    @Query('aadhar_no') String adhar,
  );

/*
  @POST('/v1/besath_enter_otp')
  Future<BaseResponse> verifyAdharOTP(
    @Query('user_id') int user_id,
    @Query('adhar') String adhar,
    @Query('otp') String otp,
  );

*/

  @POST('/v2/besath_enter_otp')
  Future<BaseResponse> verifyAdharOTP(
    @Query('user_id') int user_id,
    @Query('request_id') String request_id,
    @Query('otp') String otp,
  );

  @GET('/v2/besath_dow_timeb')
  Future<DownTimeResponse> downTimeCheck();

  @POST('/v2/besath_referral_transaction')
  Future<ReferralTransactionResponse> referralTransactions(
      {@Query('page') int? page,
      @Query('from_date') String? from_date,
      @Query('to_date') String? to_date,
      @Query('product_id') int? product_id,
      @Query('status') String? status,
      @Body() MPinRequest? transactionRequest});

  @POST('/v3/besath_lead_transaction')
  Future<LeadTransactionsResponse> leadTransactions(
      {@Query('page') int? page,
      @Query('from_date') String? from_date,
      @Query('to_date') String? to_date,
      @Query('product_id') int? product_id,
      @Query('status') String? status,
      @Body() MPinRequest? transactionRequest});

  @POST('/v3/besath_withdraw_transaction')
  Future<WithdrawalTransactionsResponse> withdrawTransactions(
      {@Query('page') int? page,
      @Query('from_date') String? from_date,
      @Query('to_date') String? to_date,
      @Query('product_id') int? product_id,
      @Query('status') String? status,
      @Body() MPinRequest? transactionRequest});

  @GET('/get_help_for_section')
  Future<GetSectionHelpResponse> getSectionHelp(
      @Query('section_id') int section_id);

  @GET('/get_tds_info')
  Future<TDSResponse> tdsInfo();

  @GET('/v3/besath_get_training_videos')
  Future<GetTrainingVideoResponse> getZoomTrainingVideo(
      @Query('user_id') String user_id);

  @POST('/v3/besath_enroll_training')
  Future<BaseResponse> enrollTraining(@Query('user_id') String user_id,
      @Query('training_id') String training_id);
}
