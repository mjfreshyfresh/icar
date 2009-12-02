// RECIEVER

byte incomingByte, sensor1, sensor2;

void setup() {

// start serial port at 19200 bps
Serial.begin(19200);
Serial.println("Ready!");

// led pins

pinMode (5, OUTPUT);
pinMode (6, OUTPUT);

delay(1000);

}

void loop() {
if (Serial.available()) {   // are there any bytes available on the serial port ???

// assign bytes to the var ‘incomingByte’
incomingByte = Serial.read();

Serial.print(int(incomingByte));

// from now on is pretty clear I guess   :)

if ((int(incomingByte) == 254)) {
sensor1 = Serial.read();
Serial.print("Sensor 1 = ");
Serial.print(int(sensor1));
}

if ((int(incomingByte) == 255)) {
sensor2 = Serial.read();
Serial.print("  Sensor 2 = ");
Serial.print(int(sensor2));
}
}

analogWrite (5, sensor1);
analogWrite (6, sensor2);
}
