import Roboclaw

my_roboclaw = Roboclaw("/dev/tty.usbmodem14101", 14101);
[my_roboclaw, result] = my_roboclaw.Open(); %Establish connection

if result == 1
    disp('Connection Established')
else
    disp('Unable to establish connection')  
end

my_port = my_roboclaw.port;


writeline(my_port,"*IDN?")
my_port.NumBytesAvailable

% % fopen(my_port);
% 
% disp('Serial Port Monitor Started. Press Ctrl+C to stop.');
% 
% try
%     while count > 100000
%         if my_port.NumBytesAvailable > 0
%             data = fread(my_port, my_port.NumBytesAvailable);
%             disp(['Received data: ', char(data')]);
%             count = count + 1;
%         end
%     end
% catch ME
%     disp('Serial Port Monitor Stopped.');
% end
% 
% % Close the serial port
% clear my_port;

% address = dec2hex(128);
% address = 128;
% speed = 5;
% 
% 
% my_roboclaw.ForwardM1(address, speed);
% 
% clear my_roboclaw % Disconnects