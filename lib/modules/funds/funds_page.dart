import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

import '../../core/core.dart';
import '../../core/utils/extensions/color.dart';
import 'components/components.dart';
import 'core/domain/entities/entities.dart';
import 'funds_controller.dart';

class FundsPage extends StatefulWidget {
  const FundsPage({super.key});

  @override
  State<FundsPage> createState() => _FundsPageState();
}

class _FundsPageState extends State<FundsPage> {
  final FundsController _controller = Get.find();
  final int maxAdaptiveScreenWidth = 900;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller..pageController = PageController()
      ..textColorEditingController = TextEditingController(
        text: Color(_controller.selectedColor.value).toHex(leadingHashSign: true),
      )
      ..textNameEditingController = TextEditingController()
      ..textImageEditingController = TextEditingController()
      ..maskedLimitEditingController = MoneyMaskedTextController(
          decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$ ');
    _controller.textColorEditingController.addListener(updateColorFromText);
    _controller
      ..carouselController = CarouselController()
      ..init();
    super.initState();
  }

  void updateColorFromText() {
    var error = Validators.validateColor(
      _controller.textColorEditingController.text,
    );
    if (error == null) {
      _controller.selectedColor(_controller.textColorEditingController.text.convertToColor?.value);
    }
  }

  @override
  void dispose() {
    _controller.textColorEditingController.dispose();
    _controller.textNameEditingController.dispose();
    _controller.textImageEditingController.dispose();
    _controller.maskedLimitEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeAdapter(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: ThemeAdapter(context).iconColor),
        backgroundColor: ThemeAdapter(context).scaffoldBackgroundColor,
        title: const BusinessLogo(),
        actions: [
          IconButton(
            onPressed: _controller.newFund,
            icon: const Icon(
              LineAwesome.plus_solid,
            ),
          )
        ],
      ),
      body: Builder(builder: (context) {
        if ((kIsWeb && MediaQuery.of(context).size.width > maxAdaptiveScreenWidth) ||
            MediaQuery.of(context).size.width > maxAdaptiveScreenWidth) {
          return _buildPageFromWeb(context);
        }
        return _buildPageOthersPlatforms(context);
      }),
    );
  }

  Widget _buildPageOthersPlatforms(BuildContext context) {
    const itemWidth = 280.0;

    return LayoutBuilder(builder: (context, constraint) {
      return Obx(() {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Visibility(
                    visible: _controller.loadingFunds.isFalse,
                    replacement: ShimmerProgress.cardsShimmerH(context),
                    child: CarouselSlider(
                      carouselController: _controller.carouselController,
                      items: _controller.funds
                          .map((fund) => MenuCard(
                                fund: fund,
                                width: itemWidth,
                              ))
                          .toList(),
                      options: CarouselOptions(
                        onPageChanged: (page, _) => _controller.changeCard(page),
                        height: 200,
                        viewportFraction: itemWidth / MediaQuery.of(context).size.width,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        enlargeFactor: 0.3,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                  _buildEditor()
                ],
              ),
            ),
          ),
        );
      });
    });
  }

  Widget _buildPageFromWeb(BuildContext context) {
    const itemWidth = 280.0;

    return Obx(() {
      return Row(
        children: [
          Visibility(
            visible:_controller.loadingFunds.isFalse,
            replacement: ShimmerProgress.cardsShimmerV(context),
            child: SizedBox(
              width: 500,
              child: StackedCardCarousel(
                pageController: _controller.pageController,
                onPageChanged: _controller.changeCard,
                type: StackedCardCarouselType.fadeOutStack,
                initialOffset: 5,
                spaceBetweenItems: 420,
                items: _controller.funds.isEmpty?[const SizedBox.shrink()]: _controller.funds
                    .map((fund) => MenuCard(
                          fund: fund,
                          width: itemWidth,
                          height: 400,
                        ))
                    .toList(),
              ),
            ),
          ),
          _buildEditor()
        ],
      );
    });
  }

  Widget _buildEditor() {
    Color selectedColor = Color(_controller.selectedColor.value);

    return Visibility(
      visible: _controller.loadingFunds.isFalse,
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CustomFeatureHeader(
                      titleColor: selectedColor,
                      title: _controller.selectedFund.value?.id.isNotEmpty ?? false
                          ? 'Editar fundo'
                          : 'Adicionar fundo',
                      subtitle: 'Preencha os campos',
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _controller.textNameEditingController,
                            enabled: _controller.enabledFields.value,
                            hint: 'Nome do Cartão',
                            textColor: selectedColor,
                            validator: (str) => Validators.validateTextEmpty(str),
                          ),
                          Stack(
                            children: [
                              CustomTextField(
                                enabled: _controller.enabledFields.value,
                                validator: (str) => Validators.validateColor(str),
                                autoValidate: true,
                                controller: _controller.textColorEditingController,
                                onChanged: (v) => _controller.selectedFund.value!.colorObs(v),
                                textColor: selectedColor,
                                textBold: true,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: IconButton(
                                    onPressed: _controller.enabledFields.isFalse
                                        ? null
                                        : () async {
                                            Color newColor = await ColorsPickerDialog.show(
                                              selectedColor,
                                            );
                                            _controller.selectedColor(newColor.value);
                                            _controller.textColorEditingController.text =
                                                newColor.toHex(leadingHashSign: true);
                                          },
                                    icon: Icon(LineAwesome.eye_dropper_solid, color: selectedColor),
                                  ),
                                ),
                              )
                            ],
                          ),
                          IgnorePointer(
                            ignoring: _controller.enabledFields.isFalse,
                            child: CustomDropDownButton<BrandEntity>(
                              value: _controller.selectedBrand.value,
                              textHint: 'Bandeiras',
                              onChanged: _controller.selectedBrand,
                              expand: true,
                              validator: (v) => Validators.validateIsNotNull(v),
                              backgroundColor: _controller.enabledFields.isFalse
                                  ? ThemeAdapter(context).customColors.grey500
                                  : selectedColor,
                              borderSideColor: _controller.enabledFields.isFalse
                                  ? ThemeAdapter(context).customColors.grey500
                                  : selectedColor,
                              items: _controller.brands
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Row(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: e.url,
                                              width: 30,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(e.nome),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomTextField(
                      controller: _controller.maskedLimitEditingController,
                      enabled: _controller.enabledFields.value,
                      hint: 'Limite/Saldo',
                      textColor: selectedColor,
                      textInputType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropDownButton<int>(
                            value: _controller.closeDate.value,
                            textHint: 'Fecha',
                            onChanged: _controller.closeDate,
                            expand: true,
                            backgroundColor: _controller.enabledFields.isFalse
                                ? ThemeAdapter(context).customColors.grey500
                                : selectedColor,
                            borderSideColor: _controller.enabledFields.isFalse
                                ? ThemeAdapter(context).customColors.grey500
                                : selectedColor,
                            items: List.generate(31, (day) => day + 1)
                                .map((day) => DropdownMenuItem(
                                      value: day,
                                      child: Text('Fecha $day'),
                                    ))
                                .toList(),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomDropDownButton<int>(
                            value: _controller.expireDate.value,
                            textHint: 'Vence',
                            onChanged: _controller.expireDate,
                            expand: true,
                            backgroundColor: _controller.enabledFields.isFalse
                                ? ThemeAdapter(context).customColors.grey500
                                : selectedColor,
                            borderSideColor: _controller.enabledFields.isFalse
                                ? ThemeAdapter(context).customColors.grey500
                                : selectedColor,
                            items: List.generate(31, (day) => day + 1)
                                .map((day) => DropdownMenuItem(
                                      value: day,
                                      child: Text('Vence $day'),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: _controller.textImageEditingController,
                  enabled: _controller.enabledFields.value,
                  hint: 'Imagem URL',
                  textColor: selectedColor,
                  validator: (str) => Validators.validateUrl(str),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Débito',
                        style: ThemeAdapter(context).bodySmall.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      CustomSwitchBox(
                        enabled: _controller.enabledFields.isTrue,
                        value: _controller.isCredit.value,
                        onChanged: _controller.isCredit,
                        inactiveThumbColor: selectedColor,
                        fillColor: selectedColor,
                      ),
                      Text(
                        'Crédito',
                        style: ThemeAdapter(context).bodySmall.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _controller.newFund,
                  child: Visibility(
                    visible: _controller.selectedFund.value?.id.isNotEmpty ?? false,
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      child: Text(
                        'ID: ${_controller.selectedFund.value?.id.toUpperCase()}',
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    CustomRectangleButton(
                      size: const Size(double.nan, 60),
                      label: _controller.loadings.isTrue
                          ? 'Salvando...'
                          : _controller.enabledFields.isFalse
                              ? 'Modificar'
                              : 'Salvar',
                      onPressed: _controller.loadings.isTrue
                          ? null
                          : () => _controller.enabledFields.isTrue
                              ? _controller.saveFund(
                                  formValid: _formKey.currentState?.validate() ?? false,
                                )
                              : _controller.enabledFields(true),
                      background: selectedColor,
                      textAlign: Alignment.centerLeft,
                    ),
                    SizedBox(
                      height: 60,
                      child: Visibility(
                        visible: _controller.loadings.isTrue,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.transparent,
                          color: ThemeAdapter(context).customColors.white?.withOpacity(0.3),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: _controller.selectedFund.value?.id.isNotEmpty ?? false,
                          child: GestureDetector(
                            onLongPress: _controller.deleteFund,
                            child: IconButton(
                              onPressed: null,
                              icon: Icon(
                                LineAwesome.trash_alt,
                                color: ThemeAdapter(context).customColors.white,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            height: 60,
                            child: IntrinsicWidth(
                              child: Container(
                                // margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: ThemeAdapter(context).scaffoldBackgroundColor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(100),
                                    bottomLeft: Radius.circular(100),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      _controller.activeFund.isTrue ? 'Desat' : 'Ativar',
                                      style: ThemeAdapter(context).bodySmall.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    CustomSwitchBox(
                                      value: _controller.activeFund.value,
                                      onChanged: _controller.enabledFields.isFalse
                                          ? null
                                          : (v) => _controller.activeFund(v),
                                      fillColor: selectedColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
