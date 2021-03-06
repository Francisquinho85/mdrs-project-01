function output = RunSimulator1(lambda,C,f,P,numIter)

PL = zeros(10,1);
APD = zeros(10,1);
MPD = zeros(10,1);
TT = zeros(10,1);
alfa = 0.1;

for i = 1:numIter
    [PL(i), APD(i), MPD(i), TT(i)] = Simulator1(lambda,C,f,P);
end

confPL = norminv(1-alfa/2) * sqrt(var(PL)/numIter);
confAPD = norminv(1-alfa/2) * sqrt(var(APD)/numIter);
confMPD = norminv(1-alfa/2) * sqrt(var(MPD)/numIter);
confTT = norminv(1-alfa/2) * sqrt(var(TT)/numIter);
PLsum = sum(PL)/numIter;
APDsum = sum(APD)/numIter;
MPDsum = sum(MPD)/numIter;
TTsum = sum(TT)/numIter;

fprintf('Packet Loss (%%)       = %.2e +- %.2e\n',PLsum,confPL);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n',APDsum,confAPD);
fprintf('Max Packet Delay (ms) = %.2e +- %.2e\n',MPDsum,confMPD);
fprintf('Throughput (Mbps)     = %.2e +- %.2e\n',TTsum,confTT);
output = [PLsum,APDsum,MPDsum,TTsum,confPL,confAPD,confMPD,confTT];
end



