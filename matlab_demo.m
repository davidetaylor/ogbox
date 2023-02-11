%% OGBox Demo
%
% This demo shows how to programatically set OGBox parameters using MATLAB.
%
% The OGBox has two modes set by the toggle switch on the front: PREVIEW and TRIGGERED. PREVIEW mode is useful for 
% testing different stimulus patterns, whereas TRIGGERED mode is used for experiments.
%
% This demo is intended to be used in PREVIEW mode.

%% INITIALIZE OGBox
% If everything is set up correctly, there should be a slow flash coming from the LED (OGBox output should be a square wave if using oscilloscope)

ogbox_com_port = 'COM3'; % NOTE: this will vary by computer.

try
    ogbox_serial = serial(ogbox_com_port); % create a serial connection with the OGBox Arduino
    ogbox_serial.BaudRate=9600;
    fopen(ogbox_serial);
    pause(2)
catch ME
    fprintf('Problem connecting to OGBox...\n');
end

%% Set OGBox parameters: Bright static stimulus
% If everything is set up correctly, the LED should become constant
ogbox_intensity = 4000; % Arbitrary units ranging from 0-4095. Controls the output voltage of the DAC (0 = 0V, 4095 = 5V)
ogbox_cyclelength = 0; % set to 0 for constant stimulus
ogbox_pulselength = 0; % set to 0 for constant stimulus
parameter_message = sprintf('%d,%d,%d', ogbox_intensity, ogbox_cyclelength, ogbox_pulselength);
fprintf(ogbox_serial, parameter_message); % Send parameters to OGBox


%% Set OGBox parameters: Dim static stimulus
% LED should grow dimmer
ogbox_intensity = 1000; % Arbitrary units ranging from 0-4095. Controls the output voltage of the DAC (0 = 0V, 4095 = 5V)
ogbox_cyclelength = 0; % set to 0 for constant stimulus
ogbox_pulselength = 0; % set to 0 for constant stimulus
parameter_message = sprintf('%d,%d,%d', ogbox_intensity, ogbox_cyclelength, ogbox_pulselength);
fprintf(ogbox_serial, parameter_message); % Send parameters to OGBox

%% Set OGBox parameters: Pulsed stimulus
% LED should begin pulsing again at a brighter intensity
% 10Hz stimulus with 500ms pulse lengths
ogbox_intensity = 4000; % Arbitrary units ranging from 0-4095. Controls the output voltage of the DAC (0 = 0V, 4095 = 5V)
ogbox_cyclelength = 1000; % ms
ogbox_pulselength = 500; % ms
parameter_message = sprintf('%d,%d,%d', ogbox_intensity, ogbox_cyclelength, ogbox_pulselength);
fprintf(ogbox_serial, parameter_message); % Send parameters to OGBox

%% Close serial connection to OGBox Arduino
fclose(ogbox_serial);
