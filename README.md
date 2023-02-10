# ogbox
Pattern generator for optogenetic experiments. 

## Build instructions

1. Print case and assemble electronics based on wiring diagram.
2. Label the BNCs as "Trigger IN" and "Voltage OUT"
3. Connect to PC via USB and install the Arduino sketch ("arduino/OGBox/OGbox.ino") using Arduino IDE
4. You can verify that the OGBox is working correctly by connecting the output to an oscilloscope or LED driver and setting the toggle switch to Debug Mode. The default pattern should be a 1Hz pulse. (Note: if you don't see anything initially, the toggle switch might be set to Triggered Mode instead of Debug Mode).

| Part  | Source |  Quantity |
| ---  | --- |  --- |
| Arduino Micro  | https://www.digikey.com/en/products/detail/arduino/A000053/4486332  |  1  |
| MCP4725 12Bit DAC  | https://www.digikey.com/en/products/detail/adafruit-industries-llc/935/4990759 |  1  |
| Toggle switch  | https://www.digikey.com/en/products/detail/e-switch/100SP1T1B1M2QEH/378821  |  1  |
| Half sized solderless breadboard | https://www.digikey.com/en/products/detail/adafruit-industries-llc/64/7241427  |  1  |
| Female BNC leads | https://www.digikey.com/en/products/detail/pomona-electronics/4969/603340  |  2  |
| Case | 3D printed  |  1  |

![OGBox wiring diagram](schematic.png)

## Integrating OGBox into setup

### Overview
![Overview](overview.PNG)

### Step-by-step
1. The OGBox is used to operate Thorlabs T-Cubes which are set to Modulation Mode (i.e., the cube output current exactly follows the amplitude and waveform of the voltage input signal independent from the knob setting). Connect the output of the OGBox to the T-Cube "MOD IN" with a BNC cable.
2. There are two different operation modes for the OGBox: Triggered and Debug. In Triggered Mode the OGBox will only output while the Trigger Input is high (5V). In Debug Mode, the stimulus pattern will repeat indefinitely.
3. The OGBox generatates patterned waveforms based on three parameters: Intensity, Cyclelength, and Pulselength. These parameters are set via the USB connection with the Behavioral Control PC. The code in "matlab/demo.m" explains how to change OGBox parameters.
    - Intensity (ranges from 0-4095 and is proportional to maximum power output of the LED)
    - Cyclelength (time between pulses in milliseconds). Stimulus will be constant if set to 0.
    - Pulselength (length of each pulse in milliseconds). Stimulus will be constant if set to 0.
4. When the OGBox is in Triggered Mode, it will only output a voltage pattern while the Trigger Input is high (5V). We use another Arduino to control the timing of all experimental components, so that provides the trigger signal for the OGBox.



