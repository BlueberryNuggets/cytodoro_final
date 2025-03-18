import 'package:shared_preferences/shared_preferences.dart';

// THIS IS DEDICATED TO THE MANAGEMENT OF SCORE DATA
class UserSimplePreferences {
  static late SharedPreferences _preferences;

  // mapping the shared-pref containers
  static const _keyPomodoroScore1 = 'pomodoro_score1';
  static const _keyPomodoroScore2 = 'pomodoro_score2';
  static const _keydnaScore = 'DNA_score';
  static const _keyQuizScore = 'quiz_score';
  static const _keySetIndex = 'pie_index';
  static const _keyTotalScore = 'total_score';
  static const _keyquizAccuracy = 'quiz_accuracy';
  static const _keycellNumber = 'cell_number';
  static const _keydnaAccuracy = 'dna_accuracy';
  static const _keyCytodoroSessions = 'cytodoro_sessions';
  static const _keytotalFocusTime = 'total_focustime';
  static const _keytotalPomodoroSessions = 'total_pomodorosessions';
  // static const _keydnaRateAdd = 'dnarate_add';
  static const _keyquizRateAdd = 'quizrate_add';
  static const _keyCanShowDivideCellButton = 'canShowDivideCellButton'; // Add this line
  static const _keyCytodoroDone = 'cytodoro_done'; // Add this line
  static const _keyHasDivideCellButtonBeenUsed= 'hasDivideCellButtonBeenUsed'; // Add this line
  static const _keyPomodoro_now = 'pomodoro_now';

  // FUNCTION: Initializing the sharedpref instance
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }


  // POMODORO FUNCTIONS __________________________________________
  static Future<void> setPomodoroScore1(int pomodoroScore1) async {
    await _preferences.setInt(_keyPomodoroScore1, pomodoroScore1);
  }

  static int getPomodoroScore1() {
    return _preferences.getInt(_keyPomodoroScore1) ?? 0;
  }

  static Future<void> setPomodoroScore2(int pomodoroScore2) async {
    await _preferences.setInt(_keyPomodoroScore2, pomodoroScore2);
  }

  static int getPomodoroScore2() {
    return _preferences.getInt(_keyPomodoroScore2) ?? 0;
  }

  // DNA FUNCTIONS ____________________________________________
  static Future<void> setdnaScore(int dnaScore) async {
    await _preferences.setInt(_keydnaScore, dnaScore);
  }

  static int getdnaScore() {
    return _preferences.getInt(_keydnaScore) ?? 0;
  }

  // QUIZ FUNCTIONS _____________________________________________
  static Future<void> setQuizScore(int quizScore) async {
    await _preferences.setInt(_keyQuizScore, quizScore);
  }

  static int getQuizScore() {
    return _preferences.getInt(_keyQuizScore) ?? 0;
  }

  // SETTING PIE CHART FUNCTIONS _____________________________________________
  static Future<void> setPieIndex(int pieIndex) async {
    await _preferences.setInt(_keySetIndex, pieIndex);
  }

  static int getPieIndex() {
    return _preferences.getInt(_keySetIndex) ?? 0;
  }

  // TOTAL SCORE FUNCTIONS _____________________________________________
  static Future<void> setTotalScore(int totalScore) async {
    await _preferences.setInt(_keyTotalScore, totalScore);
  }

  static int getTotalScore() {
    return _preferences.getInt(_keyTotalScore) ?? 0;
  }

  // STATS PAGE-RELATED FUNCTIONS _____________________________________________
  static Future<void> setQuizAccuracy(int quizAccuracy) async {
    await _preferences.setInt(_keyquizAccuracy, quizAccuracy);
  }

  static int getQuizAccuracy() {
    return _preferences.getInt(_keyquizAccuracy) ?? 0;
  }

  static Future<void> setquizRateAdd(int quizrateAdd) async {
    await _preferences.setInt(_keyquizRateAdd, quizrateAdd);
  }

  static int getquizRateAdd() {
    return _preferences.getInt(_keyquizRateAdd) ?? 0;
  }

  static Future<void> setCellNumber(int cellNumber) async {
    await _preferences.setInt(_keycellNumber, cellNumber);
  }

  static int getCellNumber() {
    return _preferences.getInt(_keycellNumber) ?? 1;
  }

  static Future<void> setdnaAccuracy(int dnaAccuracy) async {
    await _preferences.setInt(_keydnaAccuracy, dnaAccuracy);
  }

  static int getdnaAccuracy() {
    return _preferences.getInt(_keydnaAccuracy) ?? 0;
  }

  // static Future<void> setdnaRateAdd(int dnarateAdd) async {
  //   await _preferences.setInt(_keydnaRateAdd, dnarateAdd);
  // }

  // static int getdnaRateAdd() {
  //   return _preferences.getInt(_keydnaRateAdd) ?? 0;
  // }

  static Future<void> setCytodoroSessions(int cytodoroSessions) async {
    await _preferences.setInt(_keyCytodoroSessions, cytodoroSessions);
  }

  static int getCytodoroSessions() {
    return _preferences.getInt(_keyCytodoroSessions) ?? 0;
  }

  static Future<void> setTotalFocusTime(int totalFocusTime) async {
    await _preferences.setInt(_keytotalFocusTime, totalFocusTime);
  }

  static int getTotalFocusTime() {
    return _preferences.getInt(_keytotalFocusTime) ?? 0;
  }

  static Future<void> setTotalPomodoroSessions(int totalPomodorosessions) async {
    await _preferences.setInt(_keytotalPomodoroSessions, totalPomodorosessions);
  }

  static int getTotalPomodoroSessions() {
    return _preferences.getInt(_keytotalPomodoroSessions) ?? 0;
  }

  // APP RESTART FUNCTION
  static Future<void> clearPrefs() async {
    await _preferences.clear();
  }

  // Function to set and get the canShowDivideCellButton flag
  static Future<void> setCanShowDivideCellButton(bool value) async {
    await _preferences.setBool(_keyCanShowDivideCellButton, value);
  }

  static bool getCanShowDivideCellButton() {
    return _preferences.getBool(_keyCanShowDivideCellButton) ?? false;
  }


   // Function to set and get the cytodoro_done flag

  static Future<void> setCytodoroDone(bool cytodoro_done) async {
    await _preferences.setBool(_keyCytodoroDone, cytodoro_done);
  }

  static bool getCytodoroDone() {
    return _preferences.getBool(_keyCytodoroDone) ?? false;
  }

    // Function to set and get the can_Multiply flag

  static Future<void> setHasDivideCellButtonBeenUsed(bool hasDivideCellButtonBeenUsed) async {
    await _preferences.setBool(_keyHasDivideCellButtonBeenUsed, hasDivideCellButtonBeenUsed);
  }

  static bool getHasDivideCellButtonBeenUsed() {
    return _preferences.getBool(_keyHasDivideCellButtonBeenUsed) ?? false;
  }

  // Function to set and get the pomodoro_now flag

  static Future<void> setPomodoroNow(bool pomodoro_now) async {
    await _preferences.setBool(_keyPomodoro_now, pomodoro_now);
  }

  static bool getPomodoroNow() {
    return _preferences.getBool(_keyPomodoro_now) ?? true;
  }
}

