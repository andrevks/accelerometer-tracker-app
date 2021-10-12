#include <WiFi.h>
#include <HTTPClient.h>
#include <ArduinoJson.h>

// LDC 
#include <LiquidCrystal_I2C.h>

// set the LCD number of columns and rows
int lcdColumns = 16;
int lcdRows = 2;

// set LCD address, number of columns and rows
LiquidCrystal_I2C lcd(0x3F, lcdColumns, lcdRows);  

//LCD

//Provide your own WiFi credentials
const char* ssid = "WIFI NAME";
const char* password = "PASSWORD";

//String for storing server response
String response = "";
//JSON document
DynamicJsonDocument doc(2048);
 
 
void setup(void) {
  // initialize LCD
  lcd.init();
  // turn on LCD backlight                      
  lcd.backlight();

  //For displaying on the Serial Monitor
  Serial.begin(115200);
  //Initiate WiFi connection
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  Serial.println("");
 
  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.print("WiFi connected with IP: ");
  Serial.println(WiFi.localIP());
}
 
void loop(void) {
  //Initiate HTTP client
  HTTPClient http;
  
  //The API URL
  String request = "http://192.168.1.4:8085/accmeter";
  
  //Start the request
  http.begin(request);
  
  http.addHeader("Content-Type", "application/json");
  http.addHeader("Accept", "application/json");
  
  //Use HTTP GET request
  http.GET();
  
  //Response from server
  response = http.getString();
  
  Serial.println(response);
  //Parse JSON, read error if any
  
  DeserializationError error = deserializeJson(doc, response);
  if(error) {
     Serial.print(F("deserializeJson() failed: "));
     Serial.println(error.f_str());
     return;
  }
  
  // set cursor to first column, first row
  lcd.setCursor(0, 0);
  
  // print message
  lcd.print(doc["title"].as<char*>());
  
  delay(1000);

  //Print parsed value on Serial Monitor
  Serial.println(doc["title"].as<char*>());
  
  //Close connection  
  http.end();
  
  //Wait four seconds for the next information
  delay(4000);
  
  lcd.clear();
}