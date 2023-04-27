function disconnect_OT_Quattrocento()
    ConfString(1) = bin2dec('10000000');    % First byte that stop the data transer
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
    ConfString(40) = CRC8(ConfString, 39);  % Estimates the new CRC
    fwrite(tcpScoket, ConfString, 'uint8');
    fclose(tcpScoket);
end