function [ConfString, tcpScoket, NumChanVal, NCHsel, NumSampBlockRead]=connect_OT_Quattrocento()
    RefreshRate = 0.125; % Maps refresh rate in seconds
    % Sampling frequency values
    Fsamp = [0 8 16 24];    % Codes to set the sampling frequency
    FsampVal = [512 2048 5120 10240];
    FSsel = 2;  % FSsel  = 1 -> 512 Hz; FSsel  = 2 -> 2048 Hz; FSsel  = 3 -> 5120 Hz; FSsel  = 4 -> 10240 Hz
    
    % Channels numbers
    NumChan = [0 2 4 6];    % Codes to set the number of channels
    NumChanVal = [120 216 312 408];
    NCHsel = 4; % NCHsel = 1 -> IN1, IN2, MULTIPLE IN1, AUX IN; NCHsel = 2 -> IN1..IN4, MULTIPLE IN1, MULTIPLE IN2, AUX IN; NCHsel = 3 -> IN1..IN6, MULTIPLE IN1..MULTIPLE IN3, AUX IN; NCHsel = 4 -> IN1..IN8, MULTIPLE IN1..MULTIPLE IN4, AUX IN
    
    AnOutSource = 0;        % Source input for analog output:
    % 0 = the analog output signal came from IN1
    % 1 = the analog output signal came from IN2
    % 2 = the analog output signal came from IN3
    % 3 = the analog output signal came from IN4
    % 4 = the analog output signal came from IN5
    % 5 = the analog output signal came from IN6
    % 6 = the analog output signal came from IN7
    % 7 = the analog output signal came from IN8
    % 8 = the analog output signal came from MULTIPLE IN1
    % 9 = the analog output signal came from MULTIPLE IN2
    % 10 = the analog output signal came from MULTIPLE IN3
    % 11 = the analog output signal came from MULTIPLE IN4
    % 12 = the analog output signal came from AUX IN
    AnOutChan = 0;          % Channel for analog output
    AnOutGain = bin2dec('00010000'); % bin2dec('00000000') = Gain on the Analog output equal to 1; bin2dec('00010000') = Gain on the Analog output equal to 2; bin2dec('00100000') = Gain on the Analog output equal to 4; bin2dec('00110000') = Gain on the Analog output equal to 16
    
    % Generate the configuration string
    ConfString(1) = bin2dec('10000000') + Fsamp(FSsel) + NumChan(NCHsel) + 1;
    ConfString(2) = AnOutGain + AnOutSource;
    ConfString(3) = AnOutChan;
    % -------- IN 1 -------- %
    ConfString(4) = 0;
    ConfString(5) = 0;
    ConfString(6) = bin2dec('00010100');
    % -------- IN 2 -------- %
    ConfString(7) = 0;
    ConfString(8) = 0;
    ConfString(9) = bin2dec('00010100');
    % -------- IN 3 -------- %
    ConfString(10) = 0;
    ConfString(11) = 0;
    ConfString(12) = bin2dec('00010100');
    % -------- IN 4 -------- %
    ConfString(13) = 0;
    ConfString(14) = 0;
    ConfString(15) = bin2dec('00010100');
    % -------- IN 5 -------- %
    ConfString(16) = 0;
    ConfString(17) = 0;
    ConfString(18) = bin2dec('00010100');
    % -------- IN 6 -------- %
    ConfString(19) = 0;
    ConfString(20) = 0;
    ConfString(21) = bin2dec('00010100');
    % -------- IN 7 -------- %
    ConfString(22) = 0;
    ConfString(23) = 0;
    ConfString(24) = bin2dec('00010100');
    % -------- IN 8 -------- %
    ConfString(25) = 0;
    ConfString(26) = 0;
    ConfString(27) = bin2dec('00010100');
    % -------- MULTIPLE IN 1 -------- %
    ConfString(28) = 0;
    ConfString(29) = 0;
    ConfString(30) = bin2dec('00010100');
    % -------- MULTIPLE IN 2 -------- %
    ConfString(31) = 0;
    ConfString(32) = 0;
    ConfString(33) = bin2dec('00010100');
    % -------- MULTIPLE IN 3 -------- %
    ConfString(34) = 0;
    ConfString(35) = 0;
    ConfString(36) = bin2dec('00010100');
    % -------- MULTIPLE IN 4 -------- %
    ConfString(37) = 0;
    ConfString(38) = 0;
    ConfString(39) = bin2dec('00010100');
    % ---------- CRC8 ---------- %
    ConfString(40) = CRC8(ConfString, 39);
    TCPPort = 23456;

    % Open the TCP socket
    tcpScoket = tcpclient('169.254.1.10', TCPPort);
    tcpScoket.InputBufferSize = 2*NumChanVal(NCHsel)*FsampVal(FSsel);
    NumSampBlockRead = FsampVal(FSsel)*RefreshRate;
end