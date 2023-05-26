import Roboclaw

clear
% comport = "/dev/tty.usbmodem14101"; % Tomomi's macbook
comport = "COM4";  %lab computer; go on device manager to check

my_roboclaw = Roboclaw(comport, 9600);
[my_roboclaw, result] = my_roboclaw.Open(); %Establish connection

if result == 1
    disp('Connection Established')
    
    % address = dec2hex(128);
    address = 128;
    speed = 10;

    display(my_roboclaw)

    my_port = my_roboclaw.port;

    display(my_port)

    data = read(my_port, 1,"uint8");

    my_roboclaw.ForwardM1(address, speed);
    

else
    disp('Unable to establish connection')  
end

clear my_roboclaw % Disconnects
