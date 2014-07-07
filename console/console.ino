
// First we'll set up constants for the pin numbers.
// This will make it easier to follow the code below.

const int button1Pin = 2;  // pushbutton 1 pin
const int button2Pin = 3;  // pushbutton 2 pin
const int button3Pin = 4;  // pushbutton 3 pin
const int button4Pin = 5;  // pushbutton 4 pin
const int ledPin =  13;    // LED pin


void setup()
{
  // Set up the pushbutton pins to be an input:
  pinMode(button1Pin, INPUT);
  pinMode(button2Pin, INPUT);
  pinMode(button3Pin, INPUT);  
  pinMode(button4Pin, INPUT);
  Serial.begin(9600);
  
  // Set up the LED pin to be an output:
  pinMode(ledPin, OUTPUT);      
}


void loop()
{
  int button1State, button2State, button3State, button4State;  // variables to hold the pushbutton states


  button1State = digitalRead(button1Pin);
  button2State = digitalRead(button2Pin);
  button3State = digitalRead(button3Pin);
  button4State = digitalRead(button4Pin);

 //  delay(10);

  if (button1State == LOW) 
  {
  //digitalWrite(ledPin, HIGH);   
  //delay(100);           
  Serial.println("L");
  delay(200);
  Serial.println("null");
  }
  else if (button2State == LOW)
  {
  Serial.println("P");
  delay(200);
  Serial.println("null");
  }
    else if (button3State == LOW)
  {
  Serial.println("S");
  delay(200);
  Serial.println("null");
  }
    else if (button4State == LOW)
  {       
  Serial.println("R");
  delay(200);
  Serial.println("null");
  }
  
  
}
