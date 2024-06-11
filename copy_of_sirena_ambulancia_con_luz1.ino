const int pinBuzzer = 9;
const int ledIzquierda = 12;
const int ledDerecha = 13;
const int tiempo = 400; //milisegundos

void setup() 
{
  pinMode(ledIzquierda, OUTPUT);
  pinMode(ledDerecha, OUTPUT);
}

void loop() 
{
  //generar tono de 440Hz durante 1000 ms
  tone(pinBuzzer, 440);
  digitalWrite(ledIzquierda, HIGH);
  digitalWrite(ledDerecha, LOW);
  delay(tiempo);

  //detener tono durante 500ms  
  // noTone(pinBuzzer);
  // delay(500);

  //generar tono de 523Hz durante 500ms, y detenerlo durante 500ms.
  tone(pinBuzzer, 523);
  digitalWrite(ledDerecha, HIGH);
  digitalWrite(ledIzquierda, LOW);
  delay(tiempo);
}