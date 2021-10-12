import gpio
import serial.protocols.i2c as i2c

import sparkfun_joystick show SparkFunJoystick

main:
  bus := i2c.Bus
    --sda=gpio.Pin 21
    --scl=gpio.Pin 22

  device := bus.device SparkFunJoystick.I2C_ADDRESS

  joystick := SparkFunJoystick device

  joystick.on
  while true:
    print "$joystick.horizontal - $joystick.vertical "
        + "(pressed: $joystick.pressed)"
    sleep --ms=250
