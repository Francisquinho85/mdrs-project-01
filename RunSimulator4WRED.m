function output = RunSimulator4WRED(lambda,C,f,P,n,numIter)

PL = zeros(10,1);
PLV = zeros(10,1);
APD = zeros(10,1);
APDV = zeros(10,1);
MPD = zeros(10,1);
MPDV = zeros(10,1);
TT = zeros(10,1);
alfa = 0.1;

for i = 1:numIter
    [PL(i), PLV(i), APD(i), APDV(i), MPD(i), MPDV(i), TT(i)] = Simulator4WRED(lambda,C,f,P,n);
end

confPL   = norminv(1-alfa/2) * sqrt(var(PL)/numIter);
confPLV  = norminv(1-alfa/2) * sqrt(var(PLV)/numIter);
confAPD  = norminv(1-alfa/2) * sqrt(var(APD)/numIter);
confAPDV = norminv(1-alfa/2) * sqrt(var(APDV)/numIter);
confMPD  = norminv(1-alfa/2) * sqrt(var(MPD)/numIter);
confMPDV = norminv(1-alfa/2) * sqrt(var(MPDV)/numIter);
confTT   = norminv(1-alfa/2) * sqrt(var(TT)/numIter);
PLsum = sum(PL)/numIter;
PLVsum = sum(PLV)/numIter;
APDsum = sum(APD)/numIter;
APDVsum = sum(APDV)/numIter;
MPDsum = sum(MPD)/numIter;
MPDVsum = sum(MPDV)/numIter;
TTsum = sum(TT)/numIter;

fprintf('Packet Loss (%%)            = %.2e +- %.2e\n',PLsum,confPL);
fprintf('Packet Loss VoIP (%%)       = %.2e +- %.2e\n',PLVsum,confPLV);
fprintf('Av. Packet Delay (ms)       = %.2e +- %.2e\n',APDsum,confAPD);
fprintf('Av. Packet Delay VoIP (ms)  = %.2e +- %.2e\n',APDVsum,confAPDV);
fprintf('Max Packet Delay (ms)       = %.2e +- %.2e\n',MPDsum,confMPD);
fprintf('Max Packet Delay VoIP (ms)  = %.2e +- %.2e\n',MPDVsum,confMPDV);
fprintf('Throughput (Mbps)           = %.2e +- %.2e\n',TTsum,confTT);
output = [PLsum,PLVsum,APDsum,APDVsum,MPDsum,MPDVsum,TTsum,confPL,confPLV,confAPD,confAPDV,confMPD,confMPDV,confTT];
end
