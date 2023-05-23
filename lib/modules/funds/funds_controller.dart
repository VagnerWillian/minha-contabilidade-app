import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_user_controller.dart';
import '../../core/core.dart';
import 'core/domain/entities/entities.dart';
import 'core/usecases/usecases.dart';

class FundsController extends GetxController with MessagesMixin {
  final AuthUserController _authUserController;
  final GetAllFundsUseCase _getAllFundsUseCase;
  final GetAllBrandsUseCase _getAllBrandsUseCase;
  final CreateFundUseCase _createFundUseCase;
  final DeleteFundUseCase _deleteFundUseCase;

  FundsController(
    this._authUserController,
    this._getAllFundsUseCase,
    this._getAllBrandsUseCase,
    this._createFundUseCase,
    this._deleteFundUseCase,
  );

  final _message = Rxn<MessageModel>();
  final loadingFunds = false.obs;
  final loadings = false.obs;
  final funds = <FundEntity>[].obs;
  final selectedFund = Rxn<FundEntity>();
  final enabledFields = true.obs;
  final selectedBrand = Rxn<BrandEntity>();
  final selectedColor = 0xFF000000.obs;
  final closeDate = 31.obs;
  final expireDate = 31.obs;
  final activeFund = true.obs;
  final isCredit = true.obs;

  final brands = <BrandEntity>[];
  late FundEntity fundCache;
  late final TextEditingController textColorEditingController;
  late final TextEditingController textNameEditingController;
  late final TextEditingController textImageEditingController;
  late final TextEditingController maskedLimitEditingController;
  late final CarouselController carouselController;
  late final PageController pageController;

  Future<void> init() async {
    listens();
    try {
      await getAllFunds();
      await getAllBrands();
      if (funds.isEmpty) newFund();
      changeCard(0);
    } on Failure catch (err) {
      _defineError(err);
    }
  }

  void listens() {
    messageListener(_message);
    textNameEditingController.addListener(listenName);
    textColorEditingController.addListener(listenColor);
    textImageEditingController.addListener(listenImage);
    selectedBrand.listen(listenBrand);
  }

  @override
  void onClose() {
    selectedBrand.close();
    closeDate.close();
    expireDate.close();
    isCredit.close();
    activeFund.close();
    super.onClose();
  }

  void listenName() {
    selectedFund.value?.nameObs(textNameEditingController.text);
  }

  void listenColor() {
    selectedFund.value?.colorObs(textColorEditingController.text);
  }

  void listenImage() {
    selectedFund.value?.logoUrlObs(textImageEditingController.text);
  }

  void listenBrand(BrandEntity? brand) {
    selectedFund.value?.brandUrlObs(brand?.url);
  }

  void setFundsFields(FundEntity fund) {
    textNameEditingController.text = fund.name;
    textColorEditingController.text = fund.color.toUpperCase();
    textImageEditingController.text = fund.logo;
    maskedLimitEditingController.text = fund.limit.toStringAsFixed(2);
    closeDate(fund.closeDate);
    expireDate(fund.expireDate);
    isCredit(fund.isCredit);
    activeFund(fund.active);
    int brandLength = brands.where((b) => b.id == fund.brandId).length;
    if (brandLength > 0) selectedBrand(brands.singleWhere((b) => b.id == fund.brandId));
    if (brandLength == 0) selectedBrand.value = null;
  }

  Future<void> changeCard(int cardIndex) async {
    var fund = funds[cardIndex];
    if (fund.id.isNotEmpty) enabledFields(false);
    if (fund.id.isEmpty) enabledFields(true);
    selectedFund(fund);
    setFundsFields(fund);
  }

  Future<void> newFund() async {
    if (funds.isEmpty || funds.first.id.isNotEmpty) funds.insert(0, Fund.empty());
    if (funds.length > 1) jumpCarouselToStart();
    changeCard(0);
    enabledFields(true);
  }

  Future<void> getAllFunds() async {
    loadingFunds(true);
    print('BUSCANDO FUNDOS...');
    funds
      ..clear()
      ..addAll(await _getAllFundsUseCase(
        _authUserController.userLogged!.isAdmin,
        _authUserController.userLogged!.cards,
      ));
  }

  Future<void> deleteFund() async {
    loadings(true);
    try {
      print('APAGANDO ${selectedFund.value!.name.toUpperCase()}...');
      await _deleteFundUseCase(selectedFund.value!.id);
      funds.removeWhere((f) => f.id == selectedFund.value!.id);
      jumpCarouselToStart();
      changeCard(0);
      if (funds.isEmpty) newFund();
      print('${selectedFund.value!.name.toUpperCase()} APAGADO!');
    } on Failure catch (err) {
      _defineError(err);
    }
    loadings(false);
  }

  void jumpCarouselToStart() {
    if (pageController.hasClients) pageController.jumpToPage(0);
    if (!kIsWeb) carouselController.jumpToPage(0);
  }

  Future<void> getAllBrands() async {
    print('BUSCANDO BANDEIRAS...');
    brands
      ..clear()
      ..addAll(
        await _getAllBrandsUseCase(),
      );
    loadingFunds(false);
  }

  Future<void> saveFund({required bool formValid}) async {
    loadings(true);
    if (formValid) {
      selectedFund.value!.name = textNameEditingController.text;
      selectedFund.value!.color = textColorEditingController.text;
      selectedFund.value!.brandId = selectedBrand.value!.id;
      selectedFund.value!.brandUrl = selectedBrand.value!.url;
      selectedFund.value?.limit = maskedLimitEditingController.text.tryConvertRealToDouble();
      selectedFund.value!.closeDate = closeDate.value;
      selectedFund.value!.expireDate = expireDate.value;
      selectedFund.value!.logo = textImageEditingController.text;
      selectedFund.value!.isCredit = isCredit.value;
      selectedFund.value!.active = activeFund.value;
      selectedFund.value!.order = funds.length - 1;
      if (selectedFund.value!.id.isEmpty) selectedFund.value!.generateId();
      try {
        await _createFundUseCase(selectedFund.value!.toJson);
        enabledFields(false);
        print('FUNDO ${selectedFund.value!.name.toUpperCase()} CRIADO!');
      } on Failure catch (err) {
        _defineError(err);
      }
    }
    loadings(false);
  }

  void _defineError(Failure err) {
    if (err is FailureNetwork) {
      _message(MessageModel.network(
        title: err.error,
        message: err.message,
        failureNetwork: err,
      ));
    } else if (err is FailureApp) {
      _message(MessageModel.error(
        title: err.error,
      ));
    }
  }
}
