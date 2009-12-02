/*
 Accelerometer MMA7260 
 2009-12-01
 
 This program reads the values from a MMA7269 tri-axis accelerometer
 from an ATMega168 microcontroller. The values are read from the
 analog inputs of the ATMega168 and are rewritten as a series of
 3 bytes back to the serial port. 
 The values read in from the ATMega168 (0-5V) are mapped to
 a narrow range of 0-255 to fit within a single byte.
 */

int accXPin = 0;
int accYPin = 1;
int accZPin = 2;
int accY, accX, accZ;

const int numReadings = 20;    // Number of samples for smoothing calculation
int neutralReading = 337;      // Midpoint of the accelerometer, 0-1023 from analogWrite
int maxReading = 675;          // Max of 3.3 V (not used)
int minReading = 150;          // Minimum reading (not used)

// Structure to hold the readings for each axis
typedef struct {
  int ctr;
  int total;
  int readings[numReadings];
} Axis;

// Note : there is probably a way to combine the three structures
// into some 2D array.
Axis axisX, axisY, axisZ;

void setup() {
  Serial.begin(9600);
}

void loop() {
  // Snippets are extracted from  http://itp.nyu.edu/physcomp/sensors/Reports/MMA7260Q

  // When there's no acceleration on a given axis, the output for that axis outputs half 
  // the supply voltage, or about 1.65V. With acceleration in a positive direction along
  //  the axis, the output voltage for that axis rises. With negative acceleration along
  //  the axis, the voltage goes down. In other words:
  //   * at rest the voltage is in the middle;
  //   * at full forward acceleration, the voltage is at its highest;
  //   * at full backward acceleration, the voltage is at its lowest. 

  accX = calculateAccel(analogRead(accXPin), 'x');
  accY = calculateAccel(analogRead(accYPin), 'y');
  accZ = calculateAccel(analogRead(accZPin), 'z');

  Serial.write(map(accX, 0, maxReading, 0, 255 ));
  Serial.write(map(accY, 0, maxReading, 0, 255 ));
  Serial.write(map(accZ, 0, maxReading, 0, 255 ));
}

int calculateAccel(int val, char axis)
{
  switch(axis)
  {
    case 'x':
      axisX.total = axisX.total - axisX.readings[axisX.ctr];
      axisX.readings[axisX.ctr] = val;
      axisX.total = axisX.total + axisX.readings[axisX.ctr];
      axisX.ctr++;
      if(axisX.ctr == numReadings) { axisX.ctr = 0;}
      return axisX.total/numReadings;
      break;
    case 'y':
      axisY.total = axisY.total - axisY.readings[axisY.ctr];
      axisY.readings[axisY.ctr] = val;
      axisY.total = axisY.total + axisY.readings[axisY.ctr];
      axisY.ctr++;
      if(axisY.ctr == numReadings) { axisY.ctr = 0;}
      return axisY.total/numReadings;
      break;
    case 'z':
      axisZ.total = axisZ.total - axisZ.readings[axisZ.ctr];
      axisZ.readings[axisZ.ctr] = val;
      axisZ.total = axisZ.total + axisZ.readings[axisZ.ctr];
      axisZ.ctr++;
      if(axisZ.ctr == numReadings) { axisZ.ctr = 0;}
      return axisZ.total/numReadings;
      break;
  }
}
