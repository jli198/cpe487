# Low-Pass and High-Pass Filter on Siren

## Objective

* **Implemented on the Nexys A7-100T FPGA a low-pass, high-pass, and bandpass filter that will attenuate (or mute) either the high, low, or both high or low frequencies in an audio signal. The team implemented this using the correct switch method and an incorrect button method (the buttons will alter the amplitudes not the frequency).**

## Physical Components

* Nexys A7-100T FPGA
* Pmod [I2S (Inter-IC Sound)](https://en.wikipedia.org/wiki/I%C2%B2S) 24-bit [Digital-to-Analog Converter (DAC)](https://en.wikipedia.org/wiki/Digital-to-analog_converter) is required and connects to the [top 6 pins of the Pmod JA port](https://reference.digilentinc.com/_media/reference/programmable-logic/nexys-a7/nexys-a7_rm.pdf).
* Pmod I2S also requires a [3.5-mm connector](https://en.wikipedia.org/wiki/Phone_connector_(audio)) to a speaker or headphones.

![PMODI2S](i2s.png)

## File Components

* ***dac_if.vhd***
  * 32-bit parallel stereo data is converted to serial format that DAC supports
* ***siren.vhd***
  * Top-level file that combines all file sources then sends them to dac_if.vhd
  * lo_tone, hi_tone, and wail_speed constants define the siren
  * Timing counter tcount generates all necessary timing signals
  * Wail module instance is summoned to initiate 32-bit signed audio sequences data_L and data_R (different data sent to both channels)
  * File sent to instance of dac_if to convert to required serial stream
* ***siren.xdc***
  * Constraint File
  * Add Buttons, Switches, hexcalc numberpad, anode and LEDDEC displays to be utilized by the other files
* ***tone.vhd***
  * Frequency of tone is determined by input [pitch](https://en.wikipedia.org/wiki/Pitch_(music))
  * Process cnt_pr generates unsigned sawtooth waveform count by incrementing 32-bit counter pitch values every clock cycle
  * Frequency with which it traverses whole 32-bit count range is thus proportional to pitch
  * Lowest possible tone frequency is obtained when pitch = 1
  * Select signal assignment statement converts unsigned sawtooth count into signed triangle wave
  * Sawtooth count is split up into 4 quadrants quad and index value within quadrant
  * Signals quad and index generate triangle wave
* ***wail.vhd***
  * Instance of module tone is generated and modulates pitch up and down to produce "wail"
  * Inputs lo_pitch and hi_pitch constrain upper and lower peaks of tone
  * Inputs wspeed and wclk dictate how fast pitch changes
  * Process wp initializes wailing tone
  * Process is run on rising edge of wclk (slow clock of ~ 48 Hz)
    * Every wclk cycle, current pitch is raised or lowered based on updn value
    * updn = '1', pitch rises. updn = '0', pitch lowers
  * wspeed input indicates how much pitch changes each wclk cycle
  * When current pitch exceeds hi_pitch, updn = '0' and pitch starts decreasing
  * When current pitch is lower than lo_pitch, updn = '1' and pitch starts increasing

## Modifications

Lab 5 was utilized as the base to implement a low and high pass filter. The team did not utilize the original Lab 5 code on GitHub as the base but rather the Modifications the team did for Lab 5 for submission that was utilized as the base code. This includes features to change the wail speed and to implement a square wave. </br>
</br>
The report will take you through the flow of how data flows through each file and compiles into a single project.

### siren.xdc

To start, a button for lowpass, high pass (these buttons do not do the right purpose), high pass filter reset and low pass filter reset (to reset the threshold that can be inputted with the numberpad but this does not work in the final code): </br>
`set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports bt_lowpass]` </br>
`set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVCMOS33} [get_ports bt_highpass]` </br>
`set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33} [get_ports bt_reset_high]` </br>
`set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS33} [get_ports bt_reset_low]` </br>
</br>
Button N17 and Button P18 represent bt_reset_high and bt_reset_low. </br>
</br>
In addition, switches SW8, S9, and S10 are going to be utilized to activate the low-pass filter (SW8), high-pass filter (SW9), and to set the low-pass and high-pass thresholds after a reset (this does not work). The statements </br>
`set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS33} [get_ports SW8]` and </br>
`set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS33} [get_ports SW9]` and </br>
`set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33} [get_ports SW10]` were inserted after SW7. </br>
SW8 is assigned to Pin T8, SW9 is assigned to Pin U8, and SW10 is assigned to Pin R16. </br>
</br>
In addition, ports for the numberpad, anode, and segments are initalized like in previous labs. </br>
The hexcalc ports are initialized to the JB port so the calculator can be plugged into the FPGA. </br>
LEDDEC's segment and anode ports are also mapped to their respective ports in the constraints file like in previous labs.

### tone.vhd

All data values set to 16 bits are changed to 32 bit ones. </br>
</br>
The ports high_pass and low_pass are the values that are typed into the calculator. It represents the threshold for highpass or lowpass filter entered into the numpad (this did not work in the end). Even when it was initialized as the same threshold, the team got different results. </br>
</br>
bt_reset_high and bt_reset_low are inputs to represent the highpass threshold and allow it to be modified by user input. The same is true for bt_reset_low for the lowpass threshold (this did not work in the end). </br>
</br>
This is the main code where modifications are made. SW8 and SW9 are initialized as IN ports in the ENTITY tone: </br>
`SW8 : IN STD_LOGIC;` </br>
`SW9 : IN STD_LOGIC);` </br>
</br>
wspeed is an 8 bit unsigned value where each bit can be modified by using switches 0-7. Based on the value of wailspeed, it alters the pitch value. It changes pitch which in turns changes the frequency. Therefore, for our filter, the team chooses to cut off frequency based on the current value of wail speed. In this case, the cutoff value for lowpass is "00001111". The cutoff value for highpass is "00111111".</br>
The if statement is used to check the wailspeed and if one of the filters is activated. In this case, SW8 corresponds to the low-pass filter being active. If SW8 is active and wailspeed is greater than the threshold for lowpass "00001111", the count variable is set to 0 which in turn stops higher frequencies from being played. </br>
SW9 corresponds to the high-pass filter being active. If SW9 is active and wailspeed is less than the high-pass cutoff value "00111111", then the count variable, then count goes to 0 which in turns stop low frequencies from being played. </br>
</br>
The first method the team tried for a bandpass filter was to put a conditional statement where all these conditions are all met. wailspeed is greater than the low-pass threshold and less than the high-pass threshold and both SW8 and SW9 are active. This did not work as when the program ran as it would cutoff all the frequencies. </br>
</br>
To successfully implement this, a nested if statement is created in each of the low and high pass checks. </br>
The following is for activating a bandpass when the low-pass filter is active first. If wspeed is greater than the low-pass threshold and the low-pass switch (SW8) is on, then count is set to '0'. But, there is another if statement that checks if wspeed is less than the high-pass threshold and the high-pass switch (SW9) is on, the frequency is in the bandpass region and the count will start increasing, and plays the audio.
</br>
The same is true is for activating a bandpass when the high-pass filter is active first. If wspeed is less than the low-pass threshold and the high-pass switch (SW9) is on, then count is set to '0'. But, there is another if statement that checks if wspeed is greater than the low-pass threshold and the low-pass switch (SW8) is on, the frequency is in the bandpass region and the count will start increasing, and plays the audio. </br>
</br>
**This section below does not work and actually attenuates only the amplitude and not the frequency.** </br>
</br>
In the behavioral architecutre of the tone module, signals are created for low pass and high pass versions of triangle and square wave: </br>
`SIGNAL triangle_wave_lowpass : signed (31 DOWNTO 0);` </br>
`SIGNAL triangle_wave_highpass : signed (31 DOWNTO 0);` </br>
`SIGNAL square_wave_lowpass : signed (31 DOWNTO 0);` </br>
`SIGNAL square_wave_highpass : signed (31 DOWNTO 0);` </br>
</br>
triangle_wave_lowpass takes the triangle_wave data and it remaps anytime triangle wave quadrant is positive it remaps to 0. When the values of the quadrant is negative, it keeps the amplitude as is. </br>
The same is true for the other signals listed above. triangle_wave_highpass has any qudarants are negative it remaps to 0, but if it's positive, it does not modify it. </br>
The same is true for square_wave_lowpass and square_wave_highpass but this is just for a square wave and not a triangle wave. </br>
</br>
After the cnt_pr process begins, conditional statements are made to indicate that the low pass and high pass is initiated. </br>
</br>

**This section of the code works.** </br>
There are multiple `WITH quad SELECT` statements. The gist for low pass SELECT statements is that the 1st and 2nd quadrants are set to the 16-bit representation of 0, as we want the lower frequencies in the signal to be attenuated (or muted). For high pass SELECT statements, the 3rd and 4th quadrants are set to the 16-bit representation of 0, as we want the higher frequencies in the signal to be attenuated. </br>
</br>
Afterwards, a PROCESS called button is initalized with inputs square_wave, square_wave_lowpass, square_wave_highpass, triangle_wave, triangle_wave_lowpass, triangle_wave_highpass. </br>
The decision tree states that if the square button is pressed, it will go down the square wave conditional. Otherwise, it will go down the triangle wave conditional. Either way, it will generate the given wave but with possible alterations. </br>
If SW8 is switched on, the low-pass filter will be engaged with the given wave. </br>
If SW9 is switched on, the high-pass filter will be engaged with the given wave. </br>
If both are switched on, both filters will be engaged with the given wave, producing a bandgap filter. </br>
Otherwise, the regular wave of the conditional will be engaged.

### wail.vhd

For both the entity and behavioral architecutre of the wail module, SW8 and SW9 will be initialized as IN ports as in tone.vhd: </br>
`SW8 : IN STD_LOGIC;` </br>
`SW9 : IN STD_LOGIC);` </br>
At the end of the wail module, an instance of tone is created and the outputs of tone.vhd are initialized as the inputs of wail.vhd. </br>
In this case, SW8 and SW9 from tone.vhd and wail.vhd are paired together. </br>
`SW8 => SW8, -- low pass` </br>
`SW9 => SW9); -- high pass` </br>

To summarize, wail has all our ports defined as IN or OUT, signed, unsigned, or neither, and STD_LOGIC, or a STD_LOGIC_VECTOR. The tone.vhd outputs are then ported via PORT MAP to ports defined in wail.vhd.

### keypad.vhd

The code is the same as for [Lab 4](https://github.com/byett/dsd/tree/CPE487-Fall2023/Nexys-A7/Lab-4) except all the buttons not being used were commented out. For this project, one would only need the values of 0 and 1.

### leddec.vhd

dig indicates which digit of the 8 bits. 4-bit signal data4 was created and takes parts of the 32-bit data value and breaking it where each digit corresponds to a separate panel of the 8 panel LEDDEC. The program also turns on all anodes. The anode values that correspond to 5-8 were uncommented so every anode can be dsiaplyed.

### dac_if.vhd

dac_if.vhd is not modified at all for this project.

### siren.vhd

SW8 and SW9 are initialized as IN ports for the siren entity as like before. </br>
`SW8 : IN STD_LOGIC;` </br>
`SW9 : IN STD_LOGIC);` </br>
</br>
In the behavioral architecture of siren, the wail component has SW8 and SW9 initialized like in the siren entity: </br>
`SW8 => SW8, -- low pass` </br>
`SW9 => SW9); -- high pass` </br>
</br>
An instance of dac_if called dac AND two instances of wail called w1 and w2 is created. w1 and w2 portmap and map the SW8 and SW9 from wail.vhd to the input SW8 and SW9 in siren.vhd.
`SW8 => SW8, -- low pass` </br>
`SW9 => SW9); -- high pass` </br>

## Summary

Marc worked on implementing the VHDL modifications to the Siren project. Jason was responsible for additional research in converting the siren signals to be attenuated at either low or high frequencies. Xavion documented the process the team went through as well as any hardships that happened along the way.</br>
</br>
Over the weekend, Marc took the equipment home, but the team realized that the DAC brought home was broken, so Marc had to go back into the lab and grabbed a working one. </br>
