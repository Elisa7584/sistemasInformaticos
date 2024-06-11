// Definición de pines
const int PIN_ECHO = 13;
const int PIN_TRIGGER = 12;
const int PIN_LED_VERDE = 0;
const int PIN_LED_AMARILLO = 1;
const int PIN_LED_ROJO = 2;
const int PIN_PULSADOR = 3;
const int PIN_BUZZER = 8;

// Variables globales
int tiempo, frecuencia;

// Inicialización
void setup()
{
    // Serial.begin(9600);
    pinMode(PIN_TRIGGER, OUTPUT);
    pinMode(PIN_ECHO, INPUT);
    pinMode(PIN_LED_VERDE, OUTPUT);
    pinMode(PIN_LED_AMARILLO, OUTPUT);
    pinMode(PIN_LED_ROJO, OUTPUT);
}

// Función para medir la distancia
int medirDistancia(int trigger, int echo)
{
    long duration, distanceCm;
    digitalWrite(trigger, LOW);
    delayMicroseconds(4);
    digitalWrite(trigger, HIGH);
    delayMicroseconds(10);
    digitalWrite(trigger, LOW);
    duration = pulseIn(echo, HIGH);
    distanceCm = duration * 10 / 292 / 2;
    return distanceCm;
}

// Loop principal
void loop()
{
    int distanciaCm = medirDistancia(PIN_TRIGGER, PIN_ECHO);

    if (digitalRead(PIN_PULSADOR))
    {
        digitalWrite(PIN_LED_VERDE, LOW);
        digitalWrite(PIN_LED_AMARILLO, LOW);
        digitalWrite(PIN_LED_ROJO, HIGH);
        frecuencia = 3000;
        tone(PIN_BUZZER, frecuencia);
    }
    else if (distanciaCm > 50)
    {
        digitalWrite(PIN_LED_VERDE, HIGH);
        digitalWrite(PIN_LED_AMARILLO, LOW);
        digitalWrite(PIN_LED_ROJO, LOW);
        tiempo = 500;
        frecuencia = 1000;
        tone(PIN_BUZZER, frecuencia);
        delay(tiempo);
        noTone(PIN_BUZZER);
        delay(tiempo);
    }
    else if (distanciaCm > 20 && distanciaCm < 50)
    {
        digitalWrite(PIN_LED_VERDE, LOW);
        digitalWrite(PIN_LED_AMARILLO, HIGH);
        digitalWrite(PIN_LED_ROJO, LOW);
        tiempo = 250;
        frecuencia = 2000;
        tone(PIN_BUZZER, frecuencia);
        delay(tiempo);
        noTone(PIN_BUZZER);
        delay(tiempo);
    }
    else
    {
        digitalWrite(PIN_LED_VERDE, LOW);
        digitalWrite(PIN_LED_AMARILLO, LOW);
        digitalWrite(PIN_LED_ROJO, HIGH);
        tiempo = 125;
        frecuencia = 3000;
        tone(PIN_BUZZER, frecuencia);
        delay(tiempo);
        noTone(PIN_BUZZER);
        delay(tiempo);
    }

    // Imprimo la distancia medida en el monitor serial
    // Serial.print("Distancia: ");
    // Serial.println(distanciaCm);
}
