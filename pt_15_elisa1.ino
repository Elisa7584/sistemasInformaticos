const int sensorMovimientoPin = 2;
const int zumbadorPin = 6;
const int ledRojoPin = 10;
const int ledVerdePin = 11;
const int pulsadorPin = 7;
const int LDRPin = A0;


bool alarmaActivada = false;
bool movimientoDetectado = false;

void setup() {
 
  pinMode(sensorMovimientoPin, INPUT);
  pinMode(zumbadorPin, OUTPUT);
  pinMode(ledRojoPin, OUTPUT);
  pinMode(ledVerdePin, OUTPUT);
  pinMode(pulsadorPin, INPUT_PULLUP);


  digitalWrite(ledVerdePin, HIGH);
  
}
  
  int lumniosidad(int LDRPin){
  	int Voltaje = analogRead(LDRPin);
	const int A = 1000;     
	const int B = 15;       
	const int Rc = 10;     

  	return ((long)Voltaje*A*10)/((long)B*Rc*(1024-Voltaje));
}

void loop() {
  
  if (digitalRead(pulsadorPin) == LOW) {
    delay(50); 
    alarmaActivada = !alarmaActivada; 
    if (alarmaActivada) {
      digitalWrite(ledRojoPin, HIGH); 
      delay(5000); 
    } else {
      digitalWrite(ledRojoPin, LOW); 
    }
  }

  if (alarmaActivada && digitalRead(sensorMovimientoPin) == HIGH) {
    movimientoDetectado = true;
  }

  if (movimientoDetectado) {
    digitalWrite(zumbadorPin, HIGH);
    delay(100); 
    digitalWrite(zumbadorPin, LOW);
    movimientoDetectado = false;
  }

  if (alarmaActivada && millis() % 1000 < 500) {
    digitalWrite(ledRojoPin, HIGH);
  } else {
    digitalWrite(ledRojoPin, LOW);
  }
  
  int hayMovimiento = digitalRead(sensorMovimientoPin);
  int esNoche = (lumniosidad(sensorMovimientoPin) < 400);
 
  if (esNoche)
  {
    digitalWrite(ledRojoPin, HIGH);
    digitalWrite(ledVerdePin, HIGH);
  }else if(hayMovimiento){
    digitalWrite(ledRojoPin, HIGH);
    digitalWrite(ledVerdePin, HIGH);
    delay(5000);
  }
  else{
    digitalWrite(ledRojoPin, LOW);
    digitalWrite(ledVerdePin, LOW);
  }
}

