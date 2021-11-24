function [PL, PLV, APD, APDV, MPD, MPDV, TT] = Simulator4(lambda,C,f,P,n)
% INPUT PARAMETERS:
%  lambda - packet rate (packets/sec)
%  C      - link bandwidth (Mbps)
%  f      - queue size (Bytes)
%  P      - number of packets (stopping criterium)
%  n      - number of VoIP packets
% OUTPUT PARAMETERS:
%  PL    - packet loss of data packets(%)
%  PLV   - packet loss of VoIP packets (%)
%  APD   - average packet delay of data packet(milliseconds)
%  APDV  - average packet delay of VoIP packets (milliseconds)
%  MPD   - maximum packet delay of data packets(milliseconds)
%  MPDV  - maximum packet delay of VoIP packets (milliseconds)
%  TT    - transmitted throughput (data+VoIP) (Mbps)

%Events:
ARRIVAL = 0;       % Arrival of a packet            
DEPARTURE = 1;     % Departure of a packet
DATA = 0;
VOIP = 1;

%State variables:
STATE = 0;           % 0 - connection free; 1 - connection busy
QUEUEOCCUPATION = 0; % Occupation of the queue (in Bytes)
QUEUE = [];          % Size and arriving time instant of each packet in the queue

%Statistical Counters:
TOTALPACKETS = 0;           % No. of packets arrived to the system
TOTALPACKETSVOIP = 0;       % No. of VoIP packets arrived to the system
LOSTPACKETS = 0;            % No. of packets dropped due to buffer overflow
LOSTPACKETSVOIP = 0;        % No. of VoIP packets dropped
TRANSMITTEDPACKETS = 0;     % No. of transmitted packets
TRANSMITTEDPACKETSVOIP = 0; % No. of VoIP transmitted packets
TRANSMITTEDBYTES = 0;       % Sum of the Bytes of transmitted packets
DELAYS = 0;                 % Sum of the delays of transmitted packets
DELAYSVOIP = 0;             % Sum of the delays of VoIP transmitted packets
MAXDELAY = 0;               % Maximum delay among all transmitted packets
MAXDELAYVOIP = 0;           % Maximum delay among VoIP packets

% Initializing the simulation clock:
Clock = 0;

% Initializing the List of Events with the first ARRIVAL:
tmp = Clock + exprnd(1/lambda);
EventList = [ARRIVAL, tmp, GeneratePacketSize(), tmp, DATA];

for i=1:n
    tmpVoip = Clock + rand() * 0.002;
    EventList = [EventList; ARRIVAL, tmpVoip, GeneratePacketSizeVoip(), tmpVoip, VOIP];
end

%Simulation loop:
while TRANSMITTEDPACKETS + TRANSMITTEDPACKETSVOIP < P     % Stopping criterium
    EventList = sortrows(EventList,2);    % Order EventList by time
    Event = EventList(1,1);               % Get first event and 
    Clock = EventList(1,2);               %   and
    PacketSize = EventList(1,3);          %   associated
    ArrivalInstant = EventList(1,4);      %   parameters.
    PacketType = EventList(1,5);          %
    EventList(1,:) = [];                  % Eliminate first event
    switch Event
        case ARRIVAL                      % If first event is an ARRIVAL
            if PacketType == DATA
                TOTALPACKETS = TOTALPACKETS + 1;
                tmp = Clock + exprnd(1/lambda);
                EventList = [EventList; ARRIVAL, tmp, GeneratePacketSize(), tmp, DATA];
                if STATE == 0
                    STATE = 1;
                    EventList = [EventList; DEPARTURE, Clock + 8*PacketSize/(C*10^6), PacketSize, Clock, DATA];
                else
                    if QUEUEOCCUPATION + PacketSize <= f
                        QUEUE = [QUEUE;PacketSize , Clock, DATA];
                        QUEUEOCCUPATION = QUEUEOCCUPATION + PacketSize;
                    else
                        LOSTPACKETS = LOSTPACKETS + 1;
                    end
                end
            else
                TOTALPACKETSVOIP = TOTALPACKETSVOIP + 1;
                tmpVoip = Clock + GenerateTimeBetweenVoip();
                EventList = [EventList; ARRIVAL, tmpVoip, GeneratePacketSizeVoip(), tmpVoip, VOIP];
                if STATE == 0
                    STATE = 1;
                    EventList = [EventList; DEPARTURE, Clock + 8*PacketSize/(C*10^6), PacketSize, Clock, VOIP];
                else
                    if QUEUEOCCUPATION + PacketSize <= f
                        QUEUE = [QUEUE;PacketSize , Clock, VOIP];
                        QUEUEOCCUPATION = QUEUEOCCUPATION + PacketSize;
                    else
                        LOSTPACKETSVOIP = LOSTPACKETSVOIP + 1;
                    end
                end
            end

           
        case DEPARTURE                     % If first event is a DEPARTURE
            if PacketType == DATA
                TRANSMITTEDBYTES = TRANSMITTEDBYTES + PacketSize;
                DELAYS = DELAYS + (Clock - ArrivalInstant);
                if Clock - ArrivalInstant > MAXDELAY
                    MAXDELAY = Clock - ArrivalInstant;
                end
                TRANSMITTEDPACKETS= TRANSMITTEDPACKETS + 1;
                if QUEUEOCCUPATION > 0
                    QUEUE = sortrows(QUEUE,-3);
                    EventList = [EventList; DEPARTURE, Clock + 8*QUEUE(1,1)/(C*10^6), QUEUE(1,1), QUEUE(1,2), QUEUE(1,3)];
                    QUEUEOCCUPATION = QUEUEOCCUPATION - QUEUE(1,1);
                    QUEUE(1,:) = [];
                else
                    STATE = 0;
                end
            else
                TRANSMITTEDBYTES = TRANSMITTEDBYTES + PacketSize;
                DELAYSVOIP = DELAYSVOIP + (Clock - ArrivalInstant);
                if Clock - ArrivalInstant > MAXDELAYVOIP
                    MAXDELAYVOIP = Clock - ArrivalInstant;
                end
                TRANSMITTEDPACKETSVOIP = TRANSMITTEDPACKETSVOIP + 1;
                if QUEUEOCCUPATION > 0
                    QUEUE = sortrows(QUEUE,-3);
                    EventList = [EventList; DEPARTURE, Clock + 8*QUEUE(1,1)/(C*10^6), QUEUE(1,1), QUEUE(1,2), QUEUE(1,3)];
                    QUEUEOCCUPATION = QUEUEOCCUPATION - QUEUE(1,1);
                    QUEUE(1,:) = [];
                else
                    STATE = 0;
                end
            end
    end
end

%Performance parameters determination:
PL = 100*LOSTPACKETS/TOTALPACKETS;             % in %
PLV = 100*LOSTPACKETSVOIP/TOTALPACKETSVOIP;    % in %
APD = 1000*DELAYS/TRANSMITTEDPACKETS;          % in milliseconds
APDV = 1000*DELAYSVOIP/TRANSMITTEDPACKETSVOIP; % in milliseconds
MPD = 1000*MAXDELAY;                           % in milliseconds
MPDV = 1000*MAXDELAYVOIP;                       % in milliseconds
TT = 10^(-6)*TRANSMITTEDBYTES*8/Clock;         % in Mbps

end

function out = GeneratePacketSize()
    aux = rand();
    aux2 = [65:109 111:1517];
    if aux <= 0.19
        out = 64;
    elseif aux <= 0.19 + 0.23
        out = 110;
    elseif aux <= 0.19 + 0.23 + 0.17
        out = 1518;
    else
        out = aux2(randi(length(aux2)));
    end
end

function out = GeneratePacketSizeVoip()
    aux = (110:130);
    out = aux(randi(length(aux)));
end

function out = GenerateTimeBetweenVoip()
    out = (16 + rand()*8) / 1000;
end
