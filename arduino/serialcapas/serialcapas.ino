
int ii= 0;//Set maximum length for message
int maxl = 1e6;
int incomingByte = 0;; // variable type we are expecting

void setup() {
  Serial.begin(9600);
}

void loop() {
  
  //if (Serial.available()>0 & ii<maxl){
  if(Serial.available()>0){
    incomingByte = Serial.read();
    Serial.println(incomingByte, DEC);
    //i++;
    }
    delay(100);
}
