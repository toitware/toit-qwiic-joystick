// Copyright (C) 2021 Toitware ApS.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the EXAMPLES_LICENSE file.

import gpio
import i2c

import qwiic-joystick show *

main:
  bus := i2c.Bus
      --sda=gpio.Pin 21
      --scl=gpio.Pin 22

  device := bus.device Joystick.I2C_ADDRESS

  joystick := Joystick device

  while true:
    print "$joystick.horizontal - $joystick.vertical "
        + "(pressed: $joystick.pressed)"
    sleep --ms=250
