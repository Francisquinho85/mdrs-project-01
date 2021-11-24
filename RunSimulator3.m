function RunSimulator3(lambda,C,f,P,n,numIter)

PL = zeros(10,1);
PLV = zeros(10,1);
APD = zeros(10,1);
APDV = zeros(10,1);
MPD = zeros(10,1);
MPDV = zeros(10,1);
TT = zeros(10,1);
alfa = 0.1;

for i = 1:numIter
    [PL(i), PLV(i), APD(i), APDV(i), MPD(i), MPDV(i), TT(i)] = Simulator3(lambda,C,f,P,n);
end

confPL   = norminv(1-alfa/2) * sqrt(var(PL)/numIter);
confPLV  = norminv(1-alfa/2) * sqrt(var(PLV)/numIter);
confAPD  = norminv(1-alfa/2) * sqrt(var(APD)/numIter);
confAPDV = norminv(1-alfa/2) * sqrt(var(APDV)/numIter);
confMPD  = norminv(1-alfa/2) * sqrt(var(MPD)/numIter);
confMPDV = norminv(1-alfa/2) * sqrt(var(MPDV)/numIter);
confTT   = norminv(1-alfa/2) * sqrt(var(TT)/numIter);

fprintf('Packet Loss (%%)            = %.2e +- %.2e\n',sum(PL)/numIter,confPL);
fprintf('Packet Loss VoIP (%%)       = %.2e +- %.2e\n',sum(PLV)/numIter,confPLV);
fprintf('Av. Packet Delay (ms)       = %.2e +- %.2e\n',sum(APD)/numIter,confAPD);
fprintf('Av. Packet Delay VoIP (ms)  = %.2e +- %.2e\n',sum(APDV)/numIter,confAPDV);
fprintf('Max Packet Delay (ms)       = %.2e +- %.2e\n',sum(MPD)/numIter,confMPD);
fprintf('Max Packet Delay VoIP (ms)  = %.2e +- %.2e\n',sum(MPDV)/numIter,confMPDV);
fprintf('Throughput (Mbps)           = %.2e +- %.2e\n',sum(TT)/numIter,confTT);

end