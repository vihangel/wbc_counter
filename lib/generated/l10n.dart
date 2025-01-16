// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Clear All`
  String get clearAll {
    return Intl.message(
      'Clear All',
      name: 'clearAll',
      desc: '',
      args: [],
    );
  }

  /// `Clear Values`
  String get clearValues {
    return Intl.message(
      'Clear Values',
      name: 'clearValues',
      desc: '',
      args: [],
    );
  }

  /// `Mode`
  String get mode {
    return Intl.message(
      'Mode',
      name: 'mode',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continu {
    return Intl.message(
      'Continue',
      name: 'continu',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `White Cells`
  String get whiteCells {
    return Intl.message(
      'White Cells',
      name: 'whiteCells',
      desc: '',
      args: [],
    );
  }

  /// `Red Cells`
  String get redCells {
    return Intl.message(
      'Red Cells',
      name: 'redCells',
      desc: '',
      args: [],
    );
  }

  /// `Abnormal Cells`
  String get abnormalCells {
    return Intl.message(
      'Abnormal Cells',
      name: 'abnormalCells',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get Other {
    return Intl.message(
      'Other',
      name: 'Other',
      desc: '',
      args: [],
    );
  }

  /// `Calculate`
  String get calculate {
    return Intl.message(
      'Calculate',
      name: 'calculate',
      desc: '',
      args: [],
    );
  }

  /// `You have added {totalQuantity} cells`
  String msg_confirmCalculateCells(Object totalQuantity) {
    return Intl.message(
      'You have added $totalQuantity cells',
      name: 'msg_confirmCalculateCells',
      desc: '',
      args: [totalQuantity],
    );
  }

  /// `Do you want to continue adding or generating the report?`
  String get sub_msg_confirmCalculateCells {
    return Intl.message(
      'Do you want to continue adding or generating the report?',
      name: 'sub_msg_confirmCalculateCells',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to continue adding or generating the report?`
  String get msg_confirmClearAllValues {
    return Intl.message(
      'Do you want to continue adding or generating the report?',
      name: 'msg_confirmClearAllValues',
      desc: '',
      args: [],
    );
  }

  /// `Saved Reports`
  String get savedReports {
    return Intl.message(
      'Saved Reports',
      name: 'savedReports',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message(
      'Support',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `Support our project`
  String get supportOurProject {
    return Intl.message(
      'Support our project',
      name: 'supportOurProject',
      desc: '',
      args: [],
    );
  }

  /// `Options to support`
  String get optionsToSupport {
    return Intl.message(
      'Options to support',
      name: 'optionsToSupport',
      desc: '',
      args: [],
    );
  }

  /// `Buy me a coffe`
  String get buyMeACoffe {
    return Intl.message(
      'Buy me a coffe',
      name: 'buyMeACoffe',
      desc: '',
      args: [],
    );
  }

  /// `Pix key`
  String get pixKey {
    return Intl.message(
      'Pix key',
      name: 'pixKey',
      desc: '',
      args: [],
    );
  }

  /// `Why support us?`
  String get whySupport {
    return Intl.message(
      'Why support us?',
      name: 'whySupport',
      desc: '',
      args: [],
    );
  }

  /// `Your support helps us continue to develop and improve our app. With your help, we can offer regular updates, new features, and ensure the app remains free for all users. Thank you for supporting our mission!`
  String get explainWhySupport {
    return Intl.message(
      'Your support helps us continue to develop and improve our app. With your help, we can offer regular updates, new features, and ensure the app remains free for all users. Thank you for supporting our mission!',
      name: 'explainWhySupport',
      desc: '',
      args: [],
    );
  }

  /// `Rate Us`
  String get rateUs {
    return Intl.message(
      'Rate Us',
      name: 'rateUs',
      desc: '',
      args: [],
    );
  }

  /// `WBC Configuration`
  String get configWbc {
    return Intl.message(
      'WBC Configuration',
      name: 'configWbc',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Vibration`
  String get vibration {
    return Intl.message(
      'Vibration',
      name: 'vibration',
      desc: '',
      args: [],
    );
  }

  /// `Sound`
  String get sound {
    return Intl.message(
      'Sound',
      name: 'sound',
      desc: '',
      args: [],
    );
  }

  /// `Notify count`
  String get alertThresholds {
    return Intl.message(
      'Notify count',
      name: 'alertThresholds',
      desc: '',
      args: [],
    );
  }

  /// `Add new alert threshold`
  String get addNewAlertThreshold {
    return Intl.message(
      'Add new alert threshold',
      name: 'addNewAlertThreshold',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Reset configuration`
  String get resetConfiguration {
    return Intl.message(
      'Reset configuration',
      name: 'resetConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Alert when WBC count reaches:`
  String get alertToCount {
    return Intl.message(
      'Alert when WBC count reaches:',
      name: 'alertToCount',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Enabled`
  String get enabled {
    return Intl.message(
      'Enabled',
      name: 'enabled',
      desc: '',
      args: [],
    );
  }

  /// `Disabled`
  String get disabled {
    return Intl.message(
      'Disabled',
      name: 'disabled',
      desc: '',
      args: [],
    );
  }

  /// `Thank you message`
  String get thanks {
    return Intl.message(
      'Thank you message',
      name: 'thanks',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for using our app and considering supporting our work. Your contribution is critical to our continued success. If you have any questions or suggestions, please don't hesitate to contact us. Together we can make a difference!`
  String get thanksMessage {
    return Intl.message(
      'Thank you for using our app and considering supporting our work. Your contribution is critical to our continued success. If you have any questions or suggestions, please don\'t hesitate to contact us. Together we can make a difference!',
      name: 'thanksMessage',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contactUs {
    return Intl.message(
      'Contact us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Do you like the app?`
  String get likeTheApp {
    return Intl.message(
      'Do you like the app?',
      name: 'likeTheApp',
      desc: '',
      args: [],
    );
  }

  /// `Leave a review in the store!`
  String get leaveAReview {
    return Intl.message(
      'Leave a review in the store!',
      name: 'leaveAReview',
      desc: '',
      args: [],
    );
  }

  /// `This helps us a lot!`
  String get itHelpsALot {
    return Intl.message(
      'This helps us a lot!',
      name: 'itHelpsALot',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Open Store`
  String get openStore {
    return Intl.message(
      'Open Store',
      name: 'openStore',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `App Evaluation`
  String get appEvaluation {
    return Intl.message(
      'App Evaluation',
      name: 'appEvaluation',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Patient Name`
  String get patientName {
    return Intl.message(
      'Patient Name',
      name: 'patientName',
      desc: '',
      args: [],
    );
  }

  /// `Patient Age`
  String get patientAge {
    return Intl.message(
      'Patient Age',
      name: 'patientAge',
      desc: '',
      args: [],
    );
  }

  /// `Observation`
  String get observation {
    return Intl.message(
      'Observation',
      name: 'observation',
      desc: '',
      args: [],
    );
  }

  /// `Share Report`
  String get shareReport {
    return Intl.message(
      'Share Report',
      name: 'shareReport',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this report?`
  String get confirmDeleteReport {
    return Intl.message(
      'Are you sure you want to delete this report?',
      name: 'confirmDeleteReport',
      desc: '',
      args: [],
    );
  }

  /// `Report Saved`
  String get reportSaved {
    return Intl.message(
      'Report Saved',
      name: 'reportSaved',
      desc: '',
      args: [],
    );
  }

  /// `Your report has been saved successfully!`
  String get msg_agreeing {
    return Intl.message(
      'Your report has been saved successfully!',
      name: 'msg_agreeing',
      desc: '',
      args: [],
    );
  }

  /// `Report deleted!`
  String get msg_reportDeleted {
    return Intl.message(
      'Report deleted!',
      name: 'msg_reportDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Delete Report`
  String get deleteReport {
    return Intl.message(
      'Delete Report',
      name: 'deleteReport',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `See Reports`
  String get seeReports {
    return Intl.message(
      'See Reports',
      name: 'seeReports',
      desc: '',
      args: [],
    );
  }

  /// `Discard changes`
  String get discardChanges {
    return Intl.message(
      'Discard changes',
      name: 'discardChanges',
      desc: '',
      args: [],
    );
  }

  /// `Before leaving`
  String get beforeLeaving {
    return Intl.message(
      'Before leaving',
      name: 'beforeLeaving',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to save the report?`
  String get saveReport {
    return Intl.message(
      'Do you want to save the report?',
      name: 'saveReport',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Error loading reports`
  String get errorLoadingReports {
    return Intl.message(
      'Error loading reports',
      name: 'errorLoadingReports',
      desc: '',
      args: [],
    );
  }

  /// `No reports saved yet`
  String get noReportsSaved {
    return Intl.message(
      'No reports saved yet',
      name: 'noReportsSaved',
      desc: '',
      args: [],
    );
  }

  /// `Neutrophils`
  String get neutrophilsTitle {
    return Intl.message(
      'Neutrophils',
      name: 'neutrophilsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Could not launch`
  String get couldNotLaunch {
    return Intl.message(
      'Could not launch',
      name: 'couldNotLaunch',
      desc: '',
      args: [],
    );
  }

  /// `Neutrophils are immune defense cells that generally have segmented nuclei, with 2 to 5 segments connected by thin filaments. The color of the cytoplasm is slightly pink to colorless. They are the most abundant white cells, with medium size and shape rounded to slightly lobed. They may contain fine, pale granules, but they are usually not very visible. Neutrophils are highly motile and phagocytose bacteria.`
  String get neutrophilsDescription {
    return Intl.message(
      'Neutrophils are immune defense cells that generally have segmented nuclei, with 2 to 5 segments connected by thin filaments. The color of the cytoplasm is slightly pink to colorless. They are the most abundant white cells, with medium size and shape rounded to slightly lobed. They may contain fine, pale granules, but they are usually not very visible. Neutrophils are highly motile and phagocytose bacteria.',
      name: 'neutrophilsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Nucleus: Neutrophils generally have segmented nuclei, with 2 to 5 segments connected by thin filaments.`
  String get neutrophilsTopic1 {
    return Intl.message(
      'Nucleus: Neutrophils generally have segmented nuclei, with 2 to 5 segments connected by thin filaments.',
      name: 'neutrophilsTopic1',
      desc: '',
      args: [],
    );
  }

  /// `Cytoplasm Color: The cytoplasm is slightly pink to colorless.`
  String get neutrophilsTopic2 {
    return Intl.message(
      'Cytoplasm Color: The cytoplasm is slightly pink to colorless.',
      name: 'neutrophilsTopic2',
      desc: '',
      args: [],
    );
  }

  /// `General Size and Shape: They are the most abundant white cells, medium in size and rounded to slightly lobed in shape.`
  String get neutrophilsTopic3 {
    return Intl.message(
      'General Size and Shape: They are the most abundant white cells, medium in size and rounded to slightly lobed in shape.',
      name: 'neutrophilsTopic3',
      desc: '',
      args: [],
    );
  }

  /// `Cytoplasmic Granules: May contain fine, pale granules, but are usually not very visible.`
  String get neutrophilsTopic4 {
    return Intl.message(
      'Cytoplasmic Granules: May contain fine, pale granules, but are usually not very visible.',
      name: 'neutrophilsTopic4',
      desc: '',
      args: [],
    );
  }

  /// `Mobility and Activity: Neutrophils are highly mobile and phagocytose bacteria.`
  String get neutrophilsTopic5 {
    return Intl.message(
      'Mobility and Activity: Neutrophils are highly mobile and phagocytose bacteria.',
      name: 'neutrophilsTopic5',
      desc: '',
      args: [],
    );
  }

  /// `Lymphocytes`
  String get lymphocytesTitle {
    return Intl.message(
      'Lymphocytes',
      name: 'lymphocytesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Lymphocytes are cells of the immune system. They have dense, round, uniform nuclei. The color of the cytoplasm is light blue to colorless. They are smaller than neutrophils and are generally spherical in shape. They generally do not contain visible granules. Less motile than neutrophils, are involved in the adaptive immune response.`
  String get lymphocytesDescription {
    return Intl.message(
      'Lymphocytes are cells of the immune system. They have dense, round, uniform nuclei. The color of the cytoplasm is light blue to colorless. They are smaller than neutrophils and are generally spherical in shape. They generally do not contain visible granules. Less motile than neutrophils, are involved in the adaptive immune response.',
      name: 'lymphocytesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Nucleus: Lymphocytes have dense, round, uniform nuclei.`
  String get lymphocytesTopic1 {
    return Intl.message(
      'Nucleus: Lymphocytes have dense, round, uniform nuclei.',
      name: 'lymphocytesTopic1',
      desc: '',
      args: [],
    );
  }

  /// `Cytoplasm Color: The color of the cytoplasm is light blue to colorless.`
  String get lymphocytesTopic2 {
    return Intl.message(
      'Cytoplasm Color: The color of the cytoplasm is light blue to colorless.',
      name: 'lymphocytesTopic2',
      desc: '',
      args: [],
    );
  }

  /// `General Size and Shape: They are smaller than neutrophils and are generally spherical in shape.`
  String get lymphocytesTopic3 {
    return Intl.message(
      'General Size and Shape: They are smaller than neutrophils and are generally spherical in shape.',
      name: 'lymphocytesTopic3',
      desc: '',
      args: [],
    );
  }

  /// `Cytoplasmic Granules: Generally contain no visible granules.`
  String get lymphocytesTopic4 {
    return Intl.message(
      'Cytoplasmic Granules: Generally contain no visible granules.',
      name: 'lymphocytesTopic4',
      desc: '',
      args: [],
    );
  }

  /// `Mobility and Activity: Less mobile than neutrophils, they are involved in the adaptive immune response.`
  String get lymphocytesTopic5 {
    return Intl.message(
      'Mobility and Activity: Less mobile than neutrophils, they are involved in the adaptive immune response.',
      name: 'lymphocytesTopic5',
      desc: '',
      args: [],
    );
  }

  /// `Eosinophils`
  String get eosinophilsTitle {
    return Intl.message(
      'Eosinophils',
      name: 'eosinophilsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Eosinophils have a bilobed nucleus, resembling a pair of glasses. The cytoplasm is pink-orange due to the presence of eosinophilic granules. They are slightly larger than neutrophils and have an irregular shape. The granules are large and stained, usually pink. They are involved in the allergic response and defense against parasites.`
  String get eosinophilsDescription {
    return Intl.message(
      'Eosinophils have a bilobed nucleus, resembling a pair of glasses. The cytoplasm is pink-orange due to the presence of eosinophilic granules. They are slightly larger than neutrophils and have an irregular shape. The granules are large and stained, usually pink. They are involved in the allergic response and defense against parasites.',
      name: 'eosinophilsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Nucleus: Eosinophils have a bilobed nucleus, resembling a pair of glasses.`
  String get eosinophilsTopic1 {
    return Intl.message(
      'Nucleus: Eosinophils have a bilobed nucleus, resembling a pair of glasses.',
      name: 'eosinophilsTopic1',
      desc: '',
      args: [],
    );
  }

  /// `Cytoplasm Color: The cytoplasm is pink-orange due to the presence of eosinophilic granules.`
  String get eosinophilsTopic2 {
    return Intl.message(
      'Cytoplasm Color: The cytoplasm is pink-orange due to the presence of eosinophilic granules.',
      name: 'eosinophilsTopic2',
      desc: '',
      args: [],
    );
  }

  /// `General Size and Shape: They are slightly larger than neutrophils and have an irregular shape.`
  String get eosinophilsTopic3 {
    return Intl.message(
      'General Size and Shape: They are slightly larger than neutrophils and have an irregular shape.',
      name: 'eosinophilsTopic3',
      desc: '',
      args: [],
    );
  }

  /// `Cytoplasmic Granules: The granules are large and stained, usually pink.`
  String get eosinophilsTopic4 {
    return Intl.message(
      'Cytoplasmic Granules: The granules are large and stained, usually pink.',
      name: 'eosinophilsTopic4',
      desc: '',
      args: [],
    );
  }

  /// `Mobility and Activity: They are involved in the allergic response and defense against parasites.`
  String get eosinophilsTopic5 {
    return Intl.message(
      'Mobility and Activity: They are involved in the allergic response and defense against parasites.',
      name: 'eosinophilsTopic5',
      desc: '',
      args: [],
    );
  }

  /// `Basophils`
  String get basophilsTitle {
    return Intl.message(
      'Basophils',
      name: 'basophilsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Basophils have a bilobed nucleus, but it can be difficult to discern due to the dense granules. The cytoplasm is dark blue to black due to the basophilic granules. They are similar in size to neutrophils and eosinophils. They have dense granules, which obscure vision of the nucleus. They are involved in severe allergic reactions and immune responses.`
  String get basophilsDescription {
    return Intl.message(
      'Basophils have a bilobed nucleus, but it can be difficult to discern due to the dense granules. The cytoplasm is dark blue to black due to the basophilic granules. They are similar in size to neutrophils and eosinophils. They have dense granules, which obscure vision of the nucleus. They are involved in severe allergic reactions and immune responses.',
      name: 'basophilsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Nucleus: Basophils have a bilobed nucleus, but it can be difficult to discern due to the dense granules.`
  String get basophilsTopic1 {
    return Intl.message(
      'Nucleus: Basophils have a bilobed nucleus, but it can be difficult to discern due to the dense granules.',
      name: 'basophilsTopic1',
      desc: '',
      args: [],
    );
  }

  /// `Cytoplasm Color: The cytoplasm is dark blue to black due to basophil granules.`
  String get basophilsTopic2 {
    return Intl.message(
      'Cytoplasm Color: The cytoplasm is dark blue to black due to basophil granules.',
      name: 'basophilsTopic2',
      desc: '',
      args: [],
    );
  }

  /// `General Size and Shape: They are similar in size to neutrophils and eosinophils.`
  String get basophilsTopic3 {
    return Intl.message(
      'General Size and Shape: They are similar in size to neutrophils and eosinophils.',
      name: 'basophilsTopic3',
      desc: '',
      args: [],
    );
  }

  /// `Cytoplasmic Granules: They have dense granules, which obscure the view of the nucleus.`
  String get basophilsTopic4 {
    return Intl.message(
      'Cytoplasmic Granules: They have dense granules, which obscure the view of the nucleus.',
      name: 'basophilsTopic4',
      desc: '',
      args: [],
    );
  }

  /// `Mobility and Activity: Are involved in severe allergic reactions and immune response.`
  String get basophilsTopic5 {
    return Intl.message(
      'Mobility and Activity: Are involved in severe allergic reactions and immune response.',
      name: 'basophilsTopic5',
      desc: '',
      args: [],
    );
  }

  /// `Monocytes`
  String get monocytesTitle {
    return Intl.message(
      'Monocytes',
      name: 'monocytesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Monocytes have a large, irregularly shaped, often kidney-shaped nucleus. The cytoplasm is bluish-gray. They are the largest white blood cells and are irregular in shape. They usually have no visible granules. They are motile and differentiate into macrophages when they move to tissues.`
  String get monocytesDescription {
    return Intl.message(
      'Monocytes have a large, irregularly shaped, often kidney-shaped nucleus. The cytoplasm is bluish-gray. They are the largest white blood cells and are irregular in shape. They usually have no visible granules. They are motile and differentiate into macrophages when they move to tissues.',
      name: 'monocytesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Nucleus: Monocytes have a large, irregularly shaped and often kidney-shaped nucleus.`
  String get monocytesTopic1 {
    return Intl.message(
      'Nucleus: Monocytes have a large, irregularly shaped and often kidney-shaped nucleus.',
      name: 'monocytesTopic1',
      desc: '',
      args: [],
    );
  }

  /// `Cytoplasm Color: The cytoplasm is bluish-gray.`
  String get monocytesTopic2 {
    return Intl.message(
      'Cytoplasm Color: The cytoplasm is bluish-gray.',
      name: 'monocytesTopic2',
      desc: '',
      args: [],
    );
  }

  /// `General Size and Shape: They are the largest white blood cells and have an irregular shape.`
  String get monocytesTopic3 {
    return Intl.message(
      'General Size and Shape: They are the largest white blood cells and have an irregular shape.',
      name: 'monocytesTopic3',
      desc: '',
      args: [],
    );
  }

  /// `Cytoplasmic Granules: Generally have no visible granules.`
  String get monocytesTopic4 {
    return Intl.message(
      'Cytoplasmic Granules: Generally have no visible granules.',
      name: 'monocytesTopic4',
      desc: '',
      args: [],
    );
  }

  /// `Mobility and Activity: They are mobile and differentiate into macrophages when they move to tissues.`
  String get monocytesTopic5 {
    return Intl.message(
      'Mobility and Activity: They are mobile and differentiate into macrophages when they move to tissues.',
      name: 'monocytesTopic5',
      desc: '',
      args: [],
    );
  }

  /// `More Examples`
  String get moreExamples {
    return Intl.message(
      'More Examples',
      name: 'moreExamples',
      desc: '',
      args: [],
    );
  }

  /// `How to identify the cells?`
  String get howIdentify {
    return Intl.message(
      'How to identify the cells?',
      name: 'howIdentify',
      desc: '',
      args: [],
    );
  }

  /// `Tips to identify`
  String get tipsToIdentify {
    return Intl.message(
      'Tips to identify',
      name: 'tipsToIdentify',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Portuguese`
  String get portuguese {
    return Intl.message(
      'Portuguese',
      name: 'portuguese',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get spanish {
    return Intl.message(
      'Spanish',
      name: 'spanish',
      desc: '',
      args: [],
    );
  }

  /// `French`
  String get french {
    return Intl.message(
      'French',
      name: 'french',
      desc: '',
      args: [],
    );
  }

  /// `Italian`
  String get italian {
    return Intl.message(
      'Italian',
      name: 'italian',
      desc: '',
      args: [],
    );
  }

  /// `Eritrocytes`
  String get eritrocytesTitle {
    return Intl.message(
      'Eritrocytes',
      name: 'eritrocytesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Platelets`
  String get plateletsTitle {
    return Intl.message(
      'Platelets',
      name: 'plateletsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Blast`
  String get blastTitle {
    return Intl.message(
      'Blast',
      name: 'blastTitle',
      desc: '',
      args: [],
    );
  }

  /// `Matamielocitos`
  String get matamielocitosTitle {
    return Intl.message(
      'Matamielocitos',
      name: 'matamielocitosTitle',
      desc: '',
      args: [],
    );
  }

  /// `Mielocitos`
  String get mielocitosTitle {
    return Intl.message(
      'Mielocitos',
      name: 'mielocitosTitle',
      desc: '',
      args: [],
    );
  }

  /// `Promielocitos`
  String get promielocitosTitle {
    return Intl.message(
      'Promielocitos',
      name: 'promielocitosTitle',
      desc: '',
      args: [],
    );
  }

  /// `Reticulocitos`
  String get reticulocitosTitle {
    return Intl.message(
      'Reticulocitos',
      name: 'reticulocitosTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hipersegmentados`
  String get hipersegmentadosTitle {
    return Intl.message(
      'Hipersegmentados',
      name: 'hipersegmentadosTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pilosas`
  String get pilosasTitle {
    return Intl.message(
      'Pilosas',
      name: 'pilosasTitle',
      desc: '',
      args: [],
    );
  }

  /// `This feature is experimental and is using the Roboflow API.`
  String get experimentalFeature {
    return Intl.message(
      'This feature is experimental and is using the Roboflow API.',
      name: 'experimentalFeature',
      desc: '',
      args: [],
    );
  }

  /// `The data provided should not be considered absolute or confirmatory.`
  String get dataDisclaimer {
    return Intl.message(
      'The data provided should not be considered absolute or confirmatory.',
      name: 'dataDisclaimer',
      desc: '',
      args: [],
    );
  }

  /// `Upload from Gallery`
  String get uploadFromGallery {
    return Intl.message(
      'Upload from Gallery',
      name: 'uploadFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Use Camera`
  String get useCamera {
    return Intl.message(
      'Use Camera',
      name: 'useCamera',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `AI Help Page`
  String get aiHelpPage {
    return Intl.message(
      'AI Help Page',
      name: 'aiHelpPage',
      desc: '',
      args: [],
    );
  }

  /// `Analysis Results`
  String get analysisResults {
    return Intl.message(
      'Analysis Results',
      name: 'analysisResults',
      desc: '',
      args: [],
    );
  }

  /// `Back to Menu`
  String get backToMenu {
    return Intl.message(
      'Back to Menu',
      name: 'backToMenu',
      desc: '',
      args: [],
    );
  }

  /// `This is just a calculator, the data must be added, interpreted and calculated by a healthcare professional. Check here`
  String get explainCount {
    return Intl.message(
      'This is just a calculator, the data must be added, interpreted and calculated by a healthcare professional. Check here',
      name: 'explainCount',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
