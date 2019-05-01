import RPi.GPIO as GPIO

pinA = 0
pinB = 0

zeroflag = False
tic = 0
def setup():
    GPIO.setmode(GPIO.BUM)
    GPIO.setup(pinA,GPIO.IN)
    GPIO.setup(pinB,GPIO.IN)

def loop():
    sideA == GPIO.input(pinA)
    sideB == GPIO.input(pinB)
    if(sideA == GPIO.LOW and sideB == GPIO.LOW):
        zeroflag = True
    elif sideA == GPIO.HIGH and sideB == GPIO.LOW:
        zeroflag = False
        tic += 1
    elif sideA == GPIO.LOW and sideB == GPIO.HIGH:
        zeroflag = False
        tic -= 1

setup()
try:
    while 1:
        loop()
        print(tic)
except KeyboardInterrupt:
    GPIO.cleanup()
    
