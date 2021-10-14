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
  // Inicializa o LCD
  lcd.init();
  // Liga o a luz de fundo                     
  lcd.backlight();
  //Começar uma comunicação serial para monitorar 
  Serial.begin(115200);
  //Inicializa a conexão WIFI
  WiFi.mode(WIFI_STA);
  //Passa o nome e a senha do WIFI
  WiFi.begin(ssid, password);
  Serial.println("");
  // Espera pela conexão
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.print("WiFi connected with IP: ");
  Serial.println(WiFi.localIP());
}
 
void loop(void) {
  //Cria a variável para conexão HTTP
  HTTPClient http;
  //A URL da API
  String request = "http://192.168.1.4:8085/accmeter";
  //Começa a requisição para a API
  http.begin(request);
  //Adiciona Headers com informações necessárias para a conexão
  http.addHeader("Content-Type", "application/json");
  http.addHeader("Accept", "application/json");
  //Escolhe o método GET para fazer a requisição
  http.GET();
  //Recebe a resposta da requisição GET 
  response = http.getString();
  //Imprime a resposta no monitor serial
  Serial.println(response);
  //Separa as variaveis do JSON, caso não houver erros
  DeserializationError error = deserializeJson(doc, response);
  if(error) {
     Serial.print(F("deserializeJson() failed: "));
     Serial.println(error.f_str());
     return;
  }
  //Seta o cursor para a primeira posição
  //Primeira linha
  lcd.setCursor(0, 0);
  // Imprime a orientação na tela LCD
  lcd.print(doc["title"].as<char*>());
  delay(1000);
  //Imprime a orientação no monitor serial
  Serial.println(doc["title"].as<char*>());
  //Termina a conexão HTTP  
  http.end();
  //Espera por 4 segundos
  delay(4000);
  lcd.clear();
}
