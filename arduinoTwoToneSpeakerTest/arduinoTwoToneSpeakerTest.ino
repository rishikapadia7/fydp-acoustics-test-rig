#include <stdint.h>

#define LED_PIN 13
#define MIC_PIN 0
#define SPEAKER_PIN 9

volatile uint16_t counter;
volatile uint16_t mic_data;
volatile uint8_t on_status;

void setup()
{
    pinMode( LED_PIN, OUTPUT );
    
    // Setup serial baud-rate
    Serial.begin( 9600 );

    /*********************************TIMER*************************/
    counter = 0;
    on_status = true;

    digitalWrite( LED_PIN, on_status );


    /*************************SPEAKER*********************/
    pinMode( SPEAKER_PIN, OUTPUT );
}

void loop()
{
    //Serial.println( mic_data );
    //analogWrite( SPEAKER_PIN, mic_data << 2 );
    
    
    analogWrite( SPEAKER_PIN, 40 );
    delay(500);
    analogWrite( SPEAKER_PIN, 20 );
    delay(500);
}
