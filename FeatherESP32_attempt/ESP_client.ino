/*
  Web client

 */


#include <WiFi.h>
#include <WiFiMulti.h>
WiFiMulti WiFiMulti;

bool debug = true;

void setup() {
  Serial.begin(500000);
  delay(10);
  WiFiMulti.addAP("wifimkr1000", "wifimkr1000");
  
  Serial.println();
  Serial.println();
  Serial.print("Waiting for WiFi... ");

  while(WiFiMulti.run() != WL_CONNECTED) {
      Serial.print(".");
      delay(500);
  }
  
  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

  delay(500);
}

void loop() {
  
  WiFiClient client;
   
  client.connect({192,168,4,1}, 80);
  
  while (client && client.connected()) {

    if(client.available()){
      String response = client.readStringUntil('\n');
      Serial.println(response);
      //client.println("Responding");
    }
    
  }
}
