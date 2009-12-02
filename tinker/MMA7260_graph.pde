/*
Datalogger multi
 by Tom Igoe

 This program takes a string of three bytes from the serial port at 9600 baud 
 and graphs one of them.
 Typing "x" causes the program to graph the first byte in the string
 Typing "y" causes the program to graph the second byte in the string
 Typing "z" causes the program to graph the third byte in the string


 The program sends out a single byte, value 65 ("A") to get the remote device
 to send a string.

 Created 20 April 2005
 Updated 28 August 2005
 */

import processing.serial.*;

Serial myPort;  // The serial port
int[] serialInArray = new int[3];    // Where we'll put what we receive
int serialCount = 0;                 // A count of how many bytes we receive

// initial variables:
int i = 1;                   // counter
int inByte = -1;             // data from serial port

int xpos, ypos, zpos = 0;

boolean firstContact = false;

void setup () {
  size(400, 300);        // window size

  // List all the available serial ports
  //println(Serial.list());
  // I know that the third port in the serial list on my mac
  // is always my  Keyspan adaptor, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[0], 9600);

  // set inital background:
  background(0);

  // send initial byte:
  myPort.write(65);    // Send a capital A to start the microcontroller sending

}
void draw () {
  while (myPort.available() > 0) {
    processByte(myPort.read());
    // Note that we heard from the microntroller:
    firstContact = true;
  }
  // If there's no serial data, send again until we get some.
  // (in case you tend to start Processing before you start your 
  // external device):
  if (firstContact == false) {
    delay(300);
    myPort.write(65);
  }


}

void drawGraph () {
  int valueToGraph = 0;
// decide which value to graph:  
  if (keyCode == 88) {    //x
    valueToGraph = xpos;
      stroke(255,0,0);
  }
  if (keyCode == 89) {    //y
    valueToGraph = ypos;
      stroke(0,255,0);
  }
  if (keyCode == 90) {    //z
    valueToGraph = zpos;
      stroke(0,0,255);
  }
    // draw the line:

  line(i, height, i, height - valueToGraph);

  // at the edge of the screen, go back to the beginning:
  if (i >= width-2) {
    i = 0;
    background(0); 
  } 
  else {
    i++;
  }

}

void processByte( int inByte) {
  // Add the latest byte from the serial port to array:
  serialInArray[serialCount] = inByte;
  serialCount++;
  // If we have 3 bytes:
  if (serialCount > 2 ) {
    xpos = serialInArray[0];
    ypos = serialInArray[1];
    zpos = serialInArray[2];
       println(xpos + "\t" + ypos + "\t" + zpos);
    drawGraph();
    // Send a capital A to request new sensor readings:
    myPort.write(65);
    // Reset serialCount:
    serialCount = 0;
  }
}
