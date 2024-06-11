const int PIN_TMP = A0 ;
const int LDRPin = A1;
const int ledBlanco = 4;
const int ledRojo = 5;
const int pinBuzzer = 6;
int luz;
unsigned long startTime = millis();
int tiempoActual = startTime/3600000;

void setup(){
  Serial.begin(9600);
  pinMode(ledBlanco, OUTPUT);
  pinMode(ledRojo, OUTPUT);
  pinMode(pinBuzzer, OUTPUT);
}

float medirTemperatura(){
  int lectura = analogRead(PIN_TMP);
  return lectura*0.49-49.76;
}
int lumniosidad(int LDRPin){
  	int Voltaje = analogRead(LDRPin);
	const int A = 1000;     
	const int B = 15;       
	const int Rc = 10;      

  	return ((long)Voltaje*A*10)/((long)B*Rc*(1024-Voltaje));
} 

void loop(){ 
  float temperatura = medirTemperatura(); 
  luz = lumniosidad(LDRPin);
  if (temperatura < 20){
    tone(pinBuzzer, 1000);
    digitalWrite(ledRojo, HIGH);
  	delay(100);
  	noTone(pinBuzzer);
    digitalWrite(ledRojo, LOW);
  	delay(500);
  }
  if (tiempoActual < 12){
    
    if (luz < 700){
      digitalWrite(ledBlanco, HIGH);
    } else {
      digitalWrite(ledBlanco, LOW);
    } 
  }
  if (tiempoActual > 24){
    startTime = 0;
  }
}