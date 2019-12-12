/* 
Test RF transmission. Change the frequency with   SignFrequency constant
 */
 #define SignFrequency  1 //Hz
 #define rfTransmitPin 4  //RF Transmitter pin = digital pin 4
 #define ledPin 13        //Onboard LED = digital pin 13

 void setup(){
   pinMode(rfTransmitPin, OUTPUT);     
   pinMode(ledPin, OUTPUT);    
 }

 void loop(){
   
     digitalWrite(rfTransmitPin, HIGH);     //Transmit a HIGH signal
     digitalWrite(ledPin, HIGH);            //Turn the LED on
     delay(1000*1/SignFrequency);           //Wait for T
     
     digitalWrite(rfTransmitPin,LOW);      //Transmit a LOW signal
     digitalWrite(ledPin, LOW);            //Turn the LED off
     delay(1000*1/SignFrequency);           //Wait for T
   
 }
