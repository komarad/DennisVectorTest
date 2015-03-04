class Timer {
  float _myTime = millis();
  float _myDeltaTime = 0;

  float getDeltaTime() {
    return _myDeltaTime;
  }

  void loop() {
    _myDeltaTime = (millis() - _myTime)/1000.0f;
    _myTime = millis();
  }
}
