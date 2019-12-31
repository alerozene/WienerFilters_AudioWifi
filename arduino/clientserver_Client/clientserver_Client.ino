/*
  Web client

 */


#include <SPI.h>
#include <WiFi101.h>

bool debug = false;

///////please enter your sensitive data in the Secret tab/arduino_secrets.h
char ssid[] = "wifimkr1000";        // your network SSID (name)
int keyIndex = 0;            // your network key Index number (needed only for WEP)
int status = WL_IDLE_STATUS;
// if you don't want to use DNS (and reduce your sketch size)
// use the numeric IP instead of the name for the server:
//IPAddress server(192,168,1,1);  // numeric IP for Google (no DNS)

// Initialize the Ethernet client library
// with the IP address and port of the server
// that you want to connect to (port 80 is default for HTTP):
WiFiClient client;
void setup() {
  //Initialize serial and wait for port to open:
  Serial.begin(9600);
  
  // check for the presence of the shield:
  if (WiFi.status() == WL_NO_SHIELD) {
    Serial.println("WiFi shield not present");
    // don't continue:
    while (true);
  }

  // attempt to connect to WiFi network:
  while (status != WL_CONNECTED) {
    if(debug){
      Serial.print("Attempting to connect to SSID: ");
      Serial.println(ssid);
      }
    // Connect to WPA/WPA2 network. Change this line if using open or WEP network:
    status = WiFi.begin(ssid);
    // wait 10 seconds for connection:
    delay(5000);
  }
  if(debug){
    Serial.println("Connected to wifi");
    printWiFiStatus();  
    }
    else{
      Serial.println("Emitter_detected\n")
      }
}

void loop() {
  
  if (client.connect({192,168,1,1}, 80)) {
  client.print("request\n");
  String response = client.readStringUntil('\n');
  if(debug){
    Serial.println(response);
    }
  if(response != "empty"){
    Serial.println(response);
    client.stop();
    }
    else{
      client.stop();
      }
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
