// Copyright (C) 2021 Toitware ApS.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the EXAMPLES_LICENSE file.

import gpio
import serial.protocols.i2c as i2c

import sparkfun_joystick

main:
  bus := i2c.Bus
    --sda=gpio.Pin 21
    --scl=gpio.Pin 22

  device := bus.device sparkfun_joystick.I2C_ADDRESS

  joystick := sparkfun_joystick.SparkFunJoystick device

  joystick.on
  while true:
    print "$joystick.horizontal - $joystick.vertical "
        + "(pressed: $joystick.pressed)"
    sleep --ms=250
