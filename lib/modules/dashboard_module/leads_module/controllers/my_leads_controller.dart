import 'package:bank_sathi/Model/pair.dart';
import 'package:bank_sathi/Model/request/my_leads_request.dart';
import 'package:bank_sathi/Model/response/GetMyLeadsResponse.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLeadsController extends BaseController
    with SingleGetTickerProviderMixin {
  List statusList = <Pair>[];

  final _selectedStatus = Pair.empty().obs;

  Pair get selectedStatus => _selectedStatus.value;

  set selectedStatus(val) => _selectedStatus.value = val;

  TabController? tabController;

  RxList<Lead> _leadList = <Lead>[].obs;

  get leadList => _leadList.value;

  set leadList(val) => _leadList = val;

  RxList<Product> _productsList = <Product>[].obs;

  List<Product> get productsList => _productsList.value;

  set productsList(val) => _productsList.value = val;

  List<int> selectedProductsList = <int>[];

  final _selectedTime = 0.obs;

  int get selectedTime => _selectedTime.value;

  set selectedTime(val) => _selectedTime.value = val;

  RxInt isProductFilter = 0.obs;

  RxInt isAnyMoreFilter = 0.obs;

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  int totalPage = 2;
  int currentPage = 1;

  RxBool _apiCallDone = false.obs;

  get apiCallDone => _apiCallDone.value;

  set apiCallDone(val) => _apiCallDone.value = val;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime? newReminderDate;
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future fetchLeads() async {}

  RxString total_leads = "".obs,
      inprocess_leads = "".obs,
      completed_leads = "".obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  changeIndex(position) async {
    try {
      if (tabController != null)
        tabController!.animateTo(position,
            curve: Curves.easeInExpo, duration: 500.milliseconds);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    super.onClose();
    fromDateController.dispose();
    toDateController.dispose();
  }
}

class CompletedLeadController extends MyLeadsController {
  CompletedLeadController() {
    selectedStatus = statusList[0];
    fetchLeads();
  }

  @override
  List statusList = [
    Pair.create(2, "All"),
    Pair.create(0, "Rejected"),
    Pair.create(1, "Completed"),
  ];

  Future fetchLeads() async {
    if (currentPage <= totalPage) {
      try {
        apiCallDone = false;
        MyLeadsRequest request = MyLeadsRequest(
            user_id: getUserId(),
            status: selectedStatus.first,
            fromDate: selectedTime == 0
                ? null
                : fromDateController.text.toServerDate(),
            products: selectedProductsList,
            toDate:
                selectedTime == 0 ? null : toDateController.text.toServerDate(),
            page: currentPage);

        pageState = currentPage == 1
            ? PageStates.PAGE_LOADING
            : PageStates.PAGE_LOADING_MORE;

        final response = await restClient.myLeads(
            isProductFilter.value == 0 ? null : isProductFilter.value, request);
        pageState = PageStates.PAGE_IDLE;
        if (response.success) {
          productsList = response.data.products;
          if (Get.isSnackbarOpen!) Get.back();
          currentPage = response.data.leads.current_page;
          totalPage = response.data.leads.last_page;
          if (currentPage == 1) {
            leadList.clear();
            if (response.data.leads.data.length > 0) {
              pageState = PageStates.PAGE_IDLE;
            } else {
              pageState = PageStates.PAGE_EMPTY_DATA;
            }
          } else {
            pageState = PageStates.PAGE_IDLE;
          }
          currentPage++;
          leadList.addAll(response.data.leads.data);

          apiCallDone = true;
        } else {
          handleError(msg: response.message);
          pageState = PageStates.PAGE_ERROR;
          apiCallDone = true;
        }
      } catch (e) {
        pageState = PageStates.PAGE_ERROR;
        apiCallDone = true;
      }
      _leadList.refresh();
    }
    return;
  }

  @override
  void onInit() {
    super.onInit();
  }
}

class OnGoingLeadController extends MyLeadsController {
  OnGoingLeadController() {
    selectedStatus = statusList[0];
    fetchLeads();
  }

  @override
  List statusList = [
    Pair.create(62, "In Process"),
    Pair.create(63, "Completed"),
    Pair.create(64, "Rejected"),
    Pair.create(null, "")
    // Pair.create(null, "All"),
  ];

  @override
  Future fetchLeads() async {
    if (currentPage <= totalPage) {
      try {
        apiCallDone = false;

        MyLeadsRequest request = MyLeadsRequest(
            user_id: getUserId(),
            status: selectedStatus.first,
            fromDate: selectedTime == 0
                ? null
                : fromDateController.text.toServerDate(),
            products: selectedProductsList,
            toDate:
                selectedTime == 0 ? null : toDateController.text.toServerDate(),
            page: currentPage);
        pageState = currentPage == 1
            ? PageStates.PAGE_LOADING
            : PageStates.PAGE_LOADING_MORE;

        final response = await restClient.myLeads(
            isProductFilter.value == 0 ? null : isProductFilter.value, request);

        if (response.success) {
          productsList = response.data.products;
          if (Get.isSnackbarOpen!) Get.back();
          currentPage = response.data.leads.current_page;
          totalPage = response.data.leads.last_page;
          if (currentPage == 1) {
            leadList.clear();
            super.total_leads.value = response.data.total_leads;
            super.inprocess_leads.value = response.data.inprocess_leads;
            super.completed_leads.value = response.data.completed_leads;

            if (response.data.leads.data.length > 0) {
              pageState = PageStates.PAGE_IDLE;
            } else {
              pageState = PageStates.PAGE_EMPTY_DATA;
            }
          } else {
            pageState = PageStates.PAGE_IDLE;
          }
          currentPage++;
          leadList.addAll(response.data.leads.data);
          apiCallDone = true;
        } else {
          handleError(msg: response.message);
          pageState = PageStates.PAGE_ERROR;
          apiCallDone = true;
        }
      } catch (e) {
        pageState = PageStates.PAGE_ERROR;
        apiCallDone = true;
      }
      _leadList.refresh();
    }
    return;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    fetchLeads();
  }
}
