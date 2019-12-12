/* 
Receiver: XY-MK-5V
(Rectangular board)
Vcc->3.3V
Empty
DATA->A5
GND
 */

 #define rfReceivePin A5  //RF Receiver pin = Analog pin 5
 unsigned int data = 0;   //variable used to store received data
 
 void setup(){
   pinMode(ledPin, OUTPUT);
   Serial.begin(9600);
 }

 void loop(){
  data=analogRead(rfReceivePin);    //listen for data on Analog pin 5
  Serial.print(data);               //print data to serial
  Serial.print(",0,1023");          //print two lines to stabilize the plotter
  Serial.println();
  delay(2); 
 }
