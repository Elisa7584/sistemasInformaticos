int PIN_TMP = A0 ;

void setup(){
  Serial.begin(9600);
}

float medirTemperatura(){
  int lectura = analogRead(PIN_TMP);
  return lectura*0.49-49.76;
}
     
void loop(){ 
  
  // millis() devuelve la cantidad de 
  // milisegundos que han pasado desde
  // que se encenció el arduino. Se
  // desborda a los 50 días aprox
  int tiempoActual = millis()/1000;
  
  if (tiempoActual<5){
    float temperatura = medirTemperatura(); 
    Serial.print(temperatura); 
    Serial.println(" C"); 
  }
}