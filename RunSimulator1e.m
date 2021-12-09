function output = RunSimulator1e(lambda,C,f,P,numIter)

PL = zeros(10,1);
APD = zeros(10,1);
APD64 = zeros(10,1);
APD110 = zeros(10,1);
APD1518 = zeros(10,1);
MPD = zeros(10,1);
TT = zeros(10,1);
alfa = 0.1;

for i = 1:numIter
    [PL(i), APD(i), MPD(i), TT(i), APD64(i), APD110(i), APD1518(i)] = Simulator1e(lambda,C,f,P);
end

confAPD64 = norminv(1-alfa/2) * sqrt(var(APD64)/numIter);
confAPD110 = norminv(1-alfa/2) * sqrt(var(APD110)/numIter);
confAPD1518 = norminv(1-alfa/2) * sqrt(var(APD1518)/numIter);
APD64sum = sum(APD64)/numIter;
APD110sum = sum(APD110)/numIter;
APD1518sum = sum(APD1518)/numIter;

fprintf('Av. Packet Delay 64 (ms) = %.2e +- %.2e\n',APD64sum,confAPD64);
fprintf('Av. Packet Delay 110 (ms) = %.2e +- %.2e\n',APD110sum,confAPD110);
fprintf('Av. Packet Delay 1518 (ms) = %.2e +- %.2e\n',APD1518sum,confAPD1518);

output = [APD64sum,APD110sum,APD1518sum,confAPD64,confAPD110,confAPD1518];
end
