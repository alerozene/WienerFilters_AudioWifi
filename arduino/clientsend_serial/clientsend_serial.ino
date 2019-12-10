
double a=0.0;
void setup(){
  Serial.begin(9600);
  }
  void loop(){

        if (Serial.available() > 0) {
            a = Serial.read();
            Serial.print(a);
        }
        // maybe add an else with an interrupt for data and a message
    }
