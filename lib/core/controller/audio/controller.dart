import 'package:flutter_quiz_app/core/constants/assets_constants.dart';
import 'package:flutter_quiz_app/core/service/cache/cache.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soundpool/soundpool.dart';

class AudioController extends GetxController {
  final _cacheService = Get.find<CacheService>();

  final Soundpool _soundpool = Soundpool.fromOptions();
  late final int clickID;
  late final int correctAnswerID;
  late final int wrongAnswerID;
  late final int completeBadID;
  late final int completeNormalID;
  late final int completeSuccessID;
  late final int timerID;

  var isOpenSound = true.obs;

  bool get getIsOpenSound => isOpenSound.value;

  @override
  void onInit() {
    super.onInit();
    initSoundID();
  }

  Future<void> initSoundID() async {
    clickID = await _soundpool
        .load(await rootBundle.load(AssetsConstants.clickSound));
    correctAnswerID = await _soundpool
        .load(await rootBundle.load(AssetsConstants.correctAnswerSound));
    wrongAnswerID = await _soundpool
        .load(await rootBundle.load(AssetsConstants.wrongAnswerSound));
    completeBadID = await _soundpool
        .load(await rootBundle.load(AssetsConstants.completeBadSound));
    completeNormalID = await _soundpool
        .load(await rootBundle.load(AssetsConstants.completeNormalSound));
    completeSuccessID = await _soundpool
        .load(await rootBundle.load(AssetsConstants.completeSuccessSound));
    timerID = await _soundpool
        .load(await rootBundle.load(AssetsConstants.timerSound));
  }

  Future<void> setIsOpenSound(bool isOpen) async {
    isOpenSound.value = isOpen;
    await setLocalData(isOpen);
  }

  Future<void> getLocalData() async {
    if (_cacheService.box.hasData('isOpenSound')) {
      isOpenSound.value = _cacheService.box.read('isOpenSound');
    } else {
      await setLocalData(true);
      isOpenSound.value = true;
    }
  }

  Future<void> setLocalData(bool isOpen) async {
    await _cacheService.box.write('isOpenSound', isOpen);
  }

  Future<void> playClickSound() async {
    if (getIsOpenSound) {
      await _soundpool.play(clickID);
    }
  }

  Future<void> playCorrectAnswerSound() async {
    if (getIsOpenSound) {
      await _soundpool.play(correctAnswerID);
    }
  }

  Future<void> playWrongAnswerSound() async {
    if (getIsOpenSound) {
      await _soundpool.play(wrongAnswerID);
    }
  }

  Future<void> playCompleteBadSound() async {
    if (getIsOpenSound) {
      await _soundpool.play(completeBadID);
    }
  }

  Future<void> playCompleteNormalSound() async {
    if (getIsOpenSound) {
      await _soundpool.play(completeNormalID);
    }
  }

  Future<void> playCompleteSuccessSound() async {
    if (getIsOpenSound) {
      await _soundpool.play(completeSuccessID);
    }
  }

  Future<void> playTimerSound() async {
    if (getIsOpenSound) {
      await _soundpool.play(timerID);
    }
  }

  Future<void> stopSound({required int soundID}) async {
    await _soundpool.stop(soundID);
  }
}
