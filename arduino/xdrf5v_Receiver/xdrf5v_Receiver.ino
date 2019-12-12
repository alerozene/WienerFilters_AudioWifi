/* 
Receiver: XY-MK-5V
(Rectangular board)
Vcc->3.3V
Empty
DATA->A5
GND
 */

#define rfReceivePin A5  //RF Receiver pin = Analog pin 5
unsigned long duration;

void setup() {
  Serial.begin(9600);
  pinMode(rfReceivePin, INPUT);
}

void loop() {
  duration = pulseIn(rfReceivePin, HIGH);
  Serial.println(duration);
}
 
