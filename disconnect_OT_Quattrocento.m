function disconnect_OT_Quattrocento(ConfString,tcpScoket)
    ConfString(1) = bin2dec('10000000');    % First byte that stop the data transer
    ConfString(40) = CRC8(ConfString, 39);  % Estimates the new CRC
    fwrite(tcpScoket, ConfString, 'uint8');
    fclose(tcpScoket);
end