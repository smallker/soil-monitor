#include <Arduino.h>
#include <NTPClient.h>
#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include "FirebaseESP8266.h"
#define WIFI_SSID               "bolt"
#define WIFI_PASSWORD           "11111111"
#define FIREBASE_HOST           "soil-monitor-db907-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH           "wSlAQ5p06hxhvYoFqAVWlTYIb7RDR9O5UDTQqjEB"
#define FIREBASE_FCM_SERVER_KEY "AAAAM8GY_gc:APA91bEh7kMjjG7_SlcZIfZhdFRRpiuk4fqrV1llfXRSBHlCFY_BaTIll0hfyevfaUMEEB-nS6jlUhX3fWRyQezZaPTwCobZZtjsEwVo0XMrYmrnBoT8ilR_gPmUvBfe2iODMsBIG7MO"

FirebaseData firebaseData;
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org", 0);
void sendMessage(String title, String body)
{
  Serial.println("------------------------------------");
  Serial.println(title + " : " + body);
  Serial.println("------------------------------------");
  firebaseData.fcm.setNotifyMessage(title, body);
  if (Firebase.sendTopic(firebaseData))
  {
    Serial.println(firebaseData.fcm.getSendResult());
  }
  else
  {
    Serial.println(firebaseData.errorReason());
  }
}

void setup()
{
  Serial.begin(9600);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
  firebaseData.setBSSLBufferSize(1024, 1024);
  firebaseData.setResponseSize(1024);
  firebaseData.fcm.begin(FIREBASE_FCM_SERVER_KEY);
  firebaseData.fcm.setPriority("high");
  firebaseData.fcm.setTimeToLive(1000);
  firebaseData.fcm.setTopic("notification");
}
void loop()
{
  timeClient.update();
  /*
    Data dummy
  */
  int temperature = 30 + (rand() % 10);
  int humidity = rand()%100;
  int soil = rand()%100;
  float ph = rand()%10;
  FirebaseJson history;
  history.add("temperature", temperature);
  history.add("humidity", humidity);
  history.add("soil", soil);
  history.add("ph",ph);
  history.add("timestamp", (String)timeClient.getEpochTime());
  Firebase.pushJSON(firebaseData, "/history",history);
  delay(5000);
}
