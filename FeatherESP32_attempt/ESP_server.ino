/*
  WiFi Web Server
 */

#include <WiFi.h>
#include <WiFiClient.h>
#include <WiFiAP.h>

#define LED_BUILTIN 2   // Set the GPIO pin where you connected your test LED or comment this line out if your dev board has a built-in LED

// Set these to your desired credentials.
const char *ssid = "wifimkr1000";
const char *password = "wifimkr1000";

WiFiServer server(80);

void setup() {
   
  Serial.begin(500000);
  Serial.println();
  Serial.println("Configuring access point...");

  WiFi.softAP(ssid, password);
  IPAddress myIP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(myIP);
  server.begin();
  
  // Random number creation
  randomSeed(analogRead(0));
  Serial.println("Server started");
  
}



void loop() {
  
  WiFiClient client = server.available();   // listen for incoming clients
  
  
  if (client) {
    Serial.println("Client connected");
    while (client.connected()) {
      if (Serial.available()) {
        Serial.println("1");
        String sermessage = Serial.readStringUntil('\n');
        client.println(sermessage);
      }
      
    }
    Serial.println("Client disconnected");
  }
  /*if (client && client.connected() && Serial.available()) {
    //String request = client.readStringUntil('\n');
    String sermessage = Serial.readStringUntil('\n');
    Serial.print("Sending :");
    Serial.println(sermessage);
    client.println(sermessage);
    client.stop();
  }
  else if (client && client.connected()){
    String request = client.readStringUntil('\n');
    Serial.print("Received: ");
    Serial.println(request);
    client.println("empty\n");
    client.stop();
    }*/
}
