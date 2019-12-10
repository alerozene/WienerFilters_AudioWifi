unsigned long a;
//int a;
#define pin A5 
void setup() {
  Serial.begin(9600);
  pinMode(pin,INPUT);
}
void loop() {
  a = pulseIn(pin,HIGH,2500);
  //a = analogRead(pin);
  Serial.println(a);
  //delay(100);

}
