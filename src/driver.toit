import binary
import serial

class SparkFunJoystick:
  static I2C_ADDRESS ::= 0x20

  static REG_DEFAULT_ADDRESS_::= 0x00
  static REG_HORIZONTAL_POSITION_ ::= 0x03 // (to 0x04)
  static REG_VERTICAL_POSITION_::= 0x05 // (to 0x06)
  static REG_BUTTON_POSITION_ ::= 0x07

  registers_/serial.Registers

  constructor device/serial.Device:
    registers_ = device.registers

  on:
    reg := registers_.read_u8 REG_DEFAULT_ADDRESS_
    if reg != I2C_ADDRESS: throw "INVALID_CHIP"

  off:

  /**
  Returns the horizontal value in the range [-1..1].
  */
  horizontal -> float:
    return read_position_ REG_HORIZONTAL_POSITION_

  /**
  Returns the vertical value in the range [-1..1].
  */
  vertical -> float:
    return read_position_ REG_VERTICAL_POSITION_

  /**
  Returns true if the button is pressed.
  */
  pressed -> bool:
    return (registers_.read_u8 REG_BUTTON_POSITION_) == 0

  read_position_ reg/int -> float:
    value := registers_.read_u16_be reg
    // Move from uint16 range to int16 range.
    value -= binary.INT16_MAX
    // Perform floating-point division to get to [-1..1] range.
    return value.to_float / binary.INT16_MAX
