
int value = 0;

void setup() {
  Serial.begin(9600);
  pinMode(LED_BUILTIN, OUTPUT);

}

void loop() {
  if(Serial.available()>0){
    value = Serial.read();
    if(value == 1){
      digitalWrite(LED_BUILTIN, HIGH);      
      }
      else if(value == 0){
        digitalWrite(LED_BUILTIN, LOW);
        }
    }
}
