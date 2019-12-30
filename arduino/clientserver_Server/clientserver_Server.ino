/*
  WiFi Web Server


 */

#include <SPI.h>
#include <WiFi101.h>

char ssid[] = "wifimkr1000";        // network name (SSID)
int status = WL_IDLE_STATUS;
WiFiServer server(80);

void setup() {
  //Initialize serial and wait for port to open:
  Serial.begin(9600);

  // check for the presence of the shield:
  if (WiFi.status() == WL_NO_SHIELD) {
    Serial.println("WiFi shield not present");
    // don't continue:
    while (true);
  }

  // Attempt access point creation
  status = WiFi.beginAP(ssid);
  if (status != WL_AP_LISTENING) {
    Serial.println("Creating access point failed");
    // don't continue
    while (true);
  }
  delay(5000);
  server.begin();
  // you're connected now, so print out the status:
  printWiFiStatus();
}



void loop() {
  
  WiFiClient client = server.available(); //gets a client connected to the server 
  if (client && client.connected() && Serial.available()) {
    String request = client.readStringUntil('\n');
    String sermessage = Serial.readStringUntil('\n');
    client.println(sermessage);
    client.stop();
  }
  else if (client && client.connected()){
    client.println("empty\n");
    client.stop();
    }
}

void printWiFiStatus() {
  // print the SSID of the network you're attached to:
  Serial.print("SSID: ");
  Serial.println(WiFi.SSID());

  // print your WiFi shield's IP address:
  IPAddress ip = WiFi.localIP();
  Serial.print("IP Address: ");
  Serial.println(ip);

  // print the received signal strength:
  long rssi = WiFi.RSSI();
  Serial.print("signal strength (RSSI):");
  Serial.print(rssi);
  Serial.println(" dBm");
}
