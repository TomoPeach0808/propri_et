classdef Roboclaw
    %Roboclaw interface class
    
    properties (Access = public)
        comport;
        rate;
        timeout = 0.01; 
        retries = 3;
        crc = 0;
        
        port;
    end

    % properties (Constant)
    %     %Commands (cmd)
    %     M1FORWARD = 0;
	% 	M1BACKWARD = 1;
	% 	SETMINMB = 2;
	% 	SETMAXMB = 3;
	% 	M2FORWARD = 4;
	% 	M2BACKWARD = 5;
	% 	M17BIT = 6;
	% 	M27BIT = 7;
	% 	MIXEDFORWARD = 8;
	% 	MIXEDBACKWARD = 9;
	% 	MIXEDRIGHT = 10;
	% 	MIXEDLEFT = 11;
	% 	MIXEDFB = 12;
	% 	MIXEDLR = 13;
	% 	GETM1ENC = 16;
	% 	GETM2ENC = 17;
	% 	GETM1SPEED = 18;
	% 	GETM2SPEED = 19;
	% 	RESETENC = 20;
	% 	GETVERSION = 21;
	% 	SETM1ENCCOUNT = 22;
	% 	SETM2ENCCOUNT = 23;
	% 	GETMBATT = 24;
	% 	GETLBATT = 25;
	% 	SETMINLB = 26;
	% 	SETMAXLB = 27;
	% 	SETM1PID = 28;
	% 	SETM2PID = 29;
	% 	GETM1ISPEED = 30;
	% 	GETM2ISPEED = 31;
	% 	M1DUTY = 32;
	% 	M2DUTY = 33;
	% 	MIXEDDUTY = 34;
	% 	M1SPEED = 35;
	% 	M2SPEED = 36;
	% 	MIXEDSPEED = 37;
	% 	M1SPEEDACCEL = 38;
	% 	M2SPEEDACCEL = 39;
	% 	MIXEDSPEEDACCEL = 40;
	% 	M1SPEEDDIST = 41;
	% 	M2SPEEDDIST = 42;
	% 	MIXEDSPEEDDIST = 43;
	% 	M1SPEEDACCELDIST = 44;
	% 	M2SPEEDACCELDIST = 45;
	% 	MIXEDSPEEDACCELDIST = 46;
	% 	GETBUFFERS = 47;
	% 	GETPWMS = 48;
	% 	GETCURRENTS = 49;
	% 	MIXEDSPEED2ACCEL = 50;
	% 	MIXEDSPEED2ACCELDIST = 51;
	% 	M1DUTYACCEL = 52;
	% 	M2DUTYACCEL = 53;
	% 	MIXEDDUTYACCEL = 54;
	% 	READM1PID = 55;
	% 	READM2PID = 56;
	% 	SETMAINVOLTAGES = 57;
	% 	SETLOGICVOLTAGES = 58;
	% 	GETMINMAXMAINVOLTAGES = 59;
	% 	GETMINMAXLOGICVOLTAGES = 60;
	% 	SETM1POSPID = 61;
	% 	SETM2POSPID = 62;
	% 	READM1POSPID = 63;
	% 	READM2POSPID = 64;
	% 	M1SPEEDACCELDECCELPOS = 65;
	% 	M2SPEEDACCELDECCELPOS = 66;
	% 	MIXEDSPEEDACCELDECCELPOS = 67;
	% 	SETM1DEFAULTACCEL = 68;
	% 	SETM2DEFAULTACCEL = 69;
	% 	SETPINFUNCTIONS = 74;
	% 	GETPINFUNCTIONS = 75;
	% 	SETDEADBAND = 76;
	% 	GETDEADBAND = 77;
	% 	RESTOREDEFAULTS = 80;
	% 	GETTEMP = 82;
	% 	GETTEMP2 = 83;
	% 	GETERROR = 90;
	% 	GETENCODERMODE = 91;
	% 	SETM1ENCODERMODE = 92;
	% 	SETM2ENCODERMODE = 93;
	% 	WRITENVM = 94;
	% 	READNVM = 95;
	% 	SETCONFIG = 98;
	% 	GETCONFIG = 99;
	% 	SETM1MAXCURRENT = 133;
	% 	SETM2MAXCURRENT = 134;
	% 	GETM1MAXCURRENT = 135;
	% 	GETM2MAXCURRENT = 136;
	% 	SETPWMMODE = 148;
	% 	GETPWMMODE = 149;
	% 	READEEPROM = 252;
	% 	WRITEEEPROM = 253;
	% 	FLAGBOOTLOADER = 255;
    % 
    % end
    % 
    methods
        % Define roboclaw
          function obj = Roboclaw(comport,rate,timeout,retries)
              if nargin > 0 && ~isempty(comport)
                  obj.comport = comport;
              end

              if nargin > 1 && ~isempty(rate)
                  obj.rate = rate;
              end
            
              if nargin > 2 && ~isempty(timeout)
                  obj.timeout = timeout;
              end
            
              if nargin > 3 && ~isempty(retries)
                  obj.retries = retries;
              end
              
          end
          
          % Open Serial port connection
          function result = Open(obj)
            try
                obj.port = serialport(obj.comport, obj.rate, "Timeout", 1);
            catch
                result = 0; % connection fail
                return;
            end
            result = 1; % connected
          end

          % % % ------------------------------------------------ % % %
          % % % --------------  Helper Functions -------------- % % %
          
          % Reset CRC
          function obj = crc_clear(obj)
              obj.crc = 0;
          end
          
          % Update CRC
          function obj = crc_update(obj, data)
              obj.crc = bitxor(obj.crc, bitshift(data,8));
              for bit = 0:7
                  if bitand(obj.crc,32768) == 32768
                      obj.crc = bitxor(bitshift(obj.crc, 1), 4129);
                  else
                      obj.crc = bitshift(obj.crc,1);
                  end
              end
          end

          % function obj = crc_update(obj, data)
          %      obj.crc = bitxor(obj.crc, bitshift(data, 8));
          %     for bit = 0:7
          %         if bitand(obj.crc,32768) == 32768
          %             obj.crc = bitxor(bitshift(obj.crc, 1), int32(4129));
          %         else
          %            obj.crc = bitshift(obj.crc, 1);
          %         end
          %     end
          % end


          % Convert address and command to bytes and writes to serial port
          function sendcommand(obj, address, command)
              % Performs crc value on address
              obj.crc_clear();
              obj.crc_update(address);

              addressBytes = typecast(uint8(address), 'uint8'); %Convert address to 'uint8' type
              obj.port.write(addressBytes);

              obj.crc_update(command);
              commandBytes = typecast(uint8(command), 'uint8');
              obj.port.write(commandBytes);
          end

          function [result, obj] = readchecksumword(obj)
              data = read(obj.port, 2, "uint8");
              if numel(data) == 2
                  obj.crc = bitor(bitshift(data(1), 8), data(2));
                  result = 1;
              else
                  obj.crc = 0;
                  result = 0;
              end
          end

          function [result,val] = readbyte(obj)
              data = read(obj.port, 1, "uint8");
              if ~isempty(data)
                  val = data(1);
                  obj.crc_update(val);
                  result = 1;
              else
                  val = 0;
                  result = 0;
              end
          end



          %--------Write Functions-------%

          function writebyte(obj, val)
              obj.crc_update(bitand(val,255));
              valBytes = typecast(uint8(val), 'uint8');
              obj.port.write(valBytes);
          end

          function writeword(obj, val)
              obj.writebyte(bitand(val,65535))
          end

          function result = writechecksum(obj)
              obj.writeword(bitand(obj.crc, 65535));
              val = obj.readbyte();
              if numel(val) > 0
                  if val(1)
                      result = true;
                      return;
                  end
              end
              result = false;
          end

          % function write1(obj, address, cmd, val)
          %     % Need to write trystimeout = retries, sendcommand, writebyte, write
          %     % checksum first
          %     trys = obj.retries
          %     while trys
          % 
          % 
          % 
          % 
          % end



          % % % ------------------------------------------------ % % %
          % % % --------------- Command Functions --------------- % % %
          % 
          % function movement = ForwardM1(obj, address, val):
          %     % Need to finish write1 function
          % end

          



%       

%         function obj = crc_update(obj, data)
%              obj.crc = bitxor(obj.crc, bitshift(data, 8));
%             for bit = 0:7
%                 if bitand(obj.crc,32768) == 32768
%                     obj.crc = bitxor(bitshift(obj.crc, 1), int32(4129));
%                 else
%                    obj.crc = bitshift(obj.crc, 1);
%                 end
%             end
%         end
      
    end
end
