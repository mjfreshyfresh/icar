int xVal = 0;
int xValOld = 0;
int threshold = 75;
int diff = 0;

void setup()
{
   Serial.begin(9600);
}


void loop()
{
   xValOld = xVal;
   xVal = analogRead(0);
  diff = xVal - xValOld;
  if(diff > threshold)
  {
    Serial.print("Forward Beeotch! "); 
    Serial.println(diff);     
  }
  if(diff < (threshold * -1))
  {
    Serial.print("Backward Beeotch! ");     
    Serial.println(diff);         
  }
      
  Serial.println("");
  Serial.print(xVal);      
  Serial.print(" : " );  
  Serial.print(diff);  
  Serial.println("");
  
  delay(250);   
}

