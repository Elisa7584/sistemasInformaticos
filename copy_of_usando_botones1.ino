const int pinPulsadorRojo = 1;
const int pinPulsadorVerde = 2;
const int pinPulsadorAzul = 3;

const int pinLedRojo = 8;
const int pinLedVerde = 9;
const int pinLedAzul = 10;

int valorRojo = 0;
int valorVerde = 0;
int valorAzul = 0;
 
void setup() {
  // Pines de los botones
  pinMode(pinPulsadorRojo, INPUT);
  pinMode(pinPulsadorVerde, INPUT);
  pinMode(pinPulsadorAzul, INPUT);
  
  // Pines de los leds
  pinMode(pinLedRojo, OUTPUT);
  pinMode(pinLedVerde, OUTPUT);
  pinMode(pinLedAzul, OUTPUT);
}
 
void loop(){
  valorRojo = digitalRead(pinPulsadorRojo); //lectura digital de pin
  valorVerde = digitalRead(pinPulsadorVerde);
  valorAzul = digitalRead(pinPulsadorAzul);
  
  digitalWrite(pinLedRojo, valorRojo);
  digitalWrite(pinLedVerde, valorVerde);
  digitalWrite(pinLedAzul, valorAzul);
  
  //delay(2000);
}