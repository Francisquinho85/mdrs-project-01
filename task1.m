%% 1a
close all;
clearvars;
clc;

lambda = (400:400:2000);
C = 10;
f = 1e6;
P = 10000;
numIter = 50;
fprintf("\n1a) \n");
AVGpacketDelay = zeros(1,5);
AVGpacketError = zeros(1,5);
for i=1:5
    fprintf("\n lambda = %d \n",lambda(i));
    output = RunSimulator1(lambda(i),C,f,P,numIter);
    AVGpacketDelay(i) = output(2);
    AVGpacketError(i) = output(6);
end

bar(lambda,AVGpacketDelay);
title("Avg Packet Delay 1a");
hold on;
eb = errorbar(lambda,AVGpacketDelay,AVGpacketError,AVGpacketError);
eb.Color = [0 0 0];
eb.LineStyle = 'none';
hold off;

%% 1b

clearvars;

lambda = 1800;
C = 10;
f = [2000,10000,20000,100000];
P = 10000;
numIter = 50;
fprintf("\n1b) \n");
AVGpacketDelay = zeros(1,4);
AVGpacketLoss = zeros(1,4);
AVGpacketError = zeros(1,4);
AVGpacketLossErr = zeros(1,4);

for i=1:4
    fprintf("\n f = %d \n",f(i));
    output = RunSimulator1(lambda,C,f(i),P,numIter);
    AVGpacketLoss(i) = output(1);
    AVGpacketDelay(i) = output(2);
    AVGpacketLossErr(i) = output(5);
    AVGpacketError(i) = output(6); 
end

figure(1);
bar(f,AVGpacketDelay);
title("Avg Packet Delay 1b");
hold on;
eb = errorbar(f,AVGpacketDelay,AVGpacketError,AVGpacketError);
eb.Color = [0 0 0];
eb.LineStyle = 'none';
hold off;

figure(2);
bar(f,AVGpacketLoss);
title("Avg Packet Loss 1b");
hold on;
errb = errorbar(f,AVGpacketLoss,AVGpacketLossErr,AVGpacketLossErr);
errb.Color = [0 0 0];
errb.LineStyle = 'none';
hold off;

%% 1c
clearvars;

lambda = 1800;
C = (10:10:40);
f = 1e6;
P = 10000;
numIter = 50;
fprintf("\n1c) \n");
AVGpacketDelay = zeros(1,4);
AVGpacketError = zeros(1,4);
for i=1:4
    fprintf("\n C = %d \n",C(i));
    output = RunSimulator1(lambda,C(i),f,P,numIter);
    AVGpacketDelay(i) = output(2);
    AVGpacketError(i) = output(6);
end

bar(C,AVGpacketDelay);
title("Avg Packet Delay 1c");
hold on;
eb = errorbar(C,AVGpacketDelay,AVGpacketError,AVGpacketError);
eb.Color = [0 0 0];
eb.LineStyle = 'none';
hold off;

%% 1.d

clearvars;

lambda = 1800;
C = (10:10:40);

s = zeros(1,1518);
es = zeros(1,4);
es2 = zeros(1,4);
w = zeros(1,4);
for i=1:4
    fprintf("\n C = %d \n",C(i));
    for j=64:1518
        s(j) = (j*8)/(C(i)*1e6);
    end
    for j=64:1518
        if j==64
            es(i) = es(i) + (0.19 * s(j));
            es2(i) = es2(i) + (0.19 * s(j)^2);
        elseif j==110
            es(i) = es(i) + (0.23 * s(j));
            es2(i) = es2(i) + (0.23 * s(j)^2);
        elseif j==1518
            es(i) = es(i) + (0.17 * s(j));
            es2(i) = es2(i) + (0.17 * s(j)^2);
        else
            es(i) = es(i) + (0.41/(1518-64) * s(j));
            es2(i) = es2(i) + (0.41/(1518-64) * s(j)^2);
        end
    end
    w(i) = ((lambda * es2(i)) / (2 * (1 - lambda * es(i)) + es(i)))*1000;
    fprintf("\n w = %d \n",w(i));
end


