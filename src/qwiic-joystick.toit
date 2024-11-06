// Copyright (C) 2021 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import binary
import serial


/**
Driver for the SparkFun Qwiic Joystick.

The Sparkfun Qwiic Joystick is an analog joystick with a button.
It communicates over I2C.

See https://www.sparkfun.com/products/15168.

This package was used in a tutorial:
  https://docs.toit.io/peripherals/drivers/sparkfun_joystick.
*/


/**
Driver for SparkFun Joystick.

Get it at https://www.sparkfun.com/products/15168.
*/
class Joystick:

  static REG-DEFAULT-ADDRESS_::= 0x00
  static REG-HORIZONTAL-POSITION_ ::= 0x03 // (to 0x04)
  static REG-VERTICAL-POSITION_::= 0x05 // (to 0x06)
  static REG-BUTTON-POSITION_ ::= 0x07

  /**
  The default I2C address of the Sparkfun Joystick.
  */
  static I2C-ADDRESS ::= 0x20


  registers_/serial.Registers

  constructor device/serial.Device:
    registers_ = device.registers

    reg := registers_.read-u8 REG-DEFAULT-ADDRESS_
    if reg != I2C-ADDRESS: throw "INVALID_CHIP"

  /**
  The horizontal value in the range [-1..1].
  */
  horizontal -> float:
    return read-position_ REG-HORIZONTAL-POSITION_

  /**
  The vertical value in the range [-1..1].
  */
  vertical -> float:
    return read-position_ REG-VERTICAL-POSITION_

  /**
  Whether the button is pressed.
  */
  pressed -> bool:
    return (registers_.read-u8 REG-BUTTON-POSITION_) == 0

  read-position_ reg/int -> float:
    value := registers_.read-u16-be reg
    // Move from uint16 range to int16 range.
    value -= int.MAX-16
    // Perform floating-point division to get to [-1..1] range.
    return value.to-float / int.MAX-16
