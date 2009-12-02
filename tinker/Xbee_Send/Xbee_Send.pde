// SENDER

int analogValue2, analogValue5, val2, val5;

void setup()
{
// start serial port at 19200 bps
Serial.begin(19200);
}

void loop()
{
// read analog input
analogValue2 = analogRead(2);
analogValue5 = analogRead(5);

// remap values

val2 = map(analogValue2, 0, 1023, 253, 0);  // 254 and 255 for SYNC
val5 = map(analogValue5, 0, 1023, 253, 0);

Serial.print(254, BYTE); //SYNC char
Serial.print(val2, BYTE);

Serial.print(255, BYTE); //SYNC char
Serial.print(val5, BYTE);

delay(150);
}
