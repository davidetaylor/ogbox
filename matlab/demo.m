%% OGBox Demo
%
% This demo shows how to programatically set OGBox parameters (intensity and pattern) using MATLAB.
%
% The OGBox has two modes set by the toggle switch on the front: CONSTANT and TRIGGERED. CONSTANT mode is useful for 
% testing different stimulus patterns, whereas TRIGGERED mode is used for experiments.
%
% This demo is intended to be used in CONSTANT mode.

%% INITIALIZE OGBox
% Establish a serial connection with the OGBox Arduino
% If everything is set up correctly, there should be a slow flash coming from the LED (OGBox output should be a square wave if using oscilloscope)

config.ogbox_com = 'COM3'; % this will vary by computer.

try
    ogbox_serial = serial(config.ogbox_com);
    ogbox_serial.BaudRate=9600;
    fopen(ogbox_serial);
    pause(2)
catch ME
    fprintf('Problem with OGBox...\n');
end

%% Set OGBox parameters: Bright static stimulus
% If everything is set up correctly, the LED should become constant
ogbox_commands.opto_intensity = 4000; % Arbitrary units ranging from 0-4095. Controls the output voltage of the DAC (0 = 0V, 4095 = 5V)
ogbox_commands.opto_cyclelength = 0; % set to 0 for constant stimulus
ogbox_commands.opto_pulselength = 0; % set to 0 for constant stimulus
fprintf(ogbox_serial, OGBoxMessage(ogbox_commands)); % Send parameters to OGBox

%% Set OGBox parameters: Dim static stimulus
% LED should grow dimmer
ogbox_commands.opto_intensity = 1000; % Arbitrary units ranging from 0-4095. Controls the output voltage of the DAC (0 = 0V, 4095 = 5V)
ogbox_commands.opto_cyclelength = 0; % set to 0 for constant stimulus
ogbox_commands.opto_pulselength = 0; % set to 0 for constant stimulus
fprintf(ogbox_serial, OGBoxMessage(ogbox_commands)); % Send parameters to OGBox

%% Set OGBox parameters: Pulsed stimulus
% LED should begin pulsing again
% 10Hz stimulus with 500ms pulse lengths
ogbox_commands.opto_intensity = 4000; % Arbitrary units ranging from 0-4095. Controls the output voltage of the DAC (0 = 0V, 4095 = 5V)
ogbox_commands.opto_cyclelength = 1000; % ms
ogbox_commands.opto_pulselength = 500; % ms
fprintf(ogbox_serial, OGBoxMessage(ogbox_commands)); % Send parameters to OGBox

%% Close serial connection to OGBox Arduino
fclose(ogbox_serial);
