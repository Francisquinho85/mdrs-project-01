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

%% 1d

clearvars;

lambda = 1800;
C = (10:10:40);
fprintf("\n1d) \n");

for i=1:4
    es = 0;
    es2 = 0;
    fprintf("\n C = %d \n",C(i));
    for j=64:1518
        s = (j*8)/(C(i)*1e6);
        s2 = s^2;
        if j==64
            es = es + (0.19 * s);
            es2 = es2 + (0.19 * s2);
        elseif j==110
            es = es + (0.23 * s);
            es2 = es2 + (0.23 * s2);
        elseif j==1518
            es = es + (0.17 * s);
            es2 = es2 + (0.17 * s2);
        else
            es = es + ((1 - 0.19 - 0.23 - 0.17)/(1518-64-3) * s);
            es2 = es2 + ((1 - 0.19 - 0.23 - 0.17)/(1518-64-3) * s2);
        end
    end
    w = (((lambda * es2) / (2 * (1 - lambda * es))) + es) * 1e3;
    fprintf("\n w = %d \n",w);
end

%% 1e

clearvars;

lambda = 1800;
C = (10:10:40);
f = 1e6;
P = 10000;
numIter = 50;
fprintf("\n1e) \n");

AVGpacketDelay64 = zeros(1,4);
AVGpacketDelay110 = zeros(1,4);
AVGpacketDelay1518 = zeros(1,4);
AVGpacketDelay64Err = zeros(1,4);
AVGpacketDelay110Err = zeros(1,4);
AVGpacketDelay1518Err = zeros(1,4);

for i=1:4
    fprintf("\n C = %d \n",C(i));
    output = RunSimulator1e(lambda,C(i),f,P,numIter);
    AVGpacketDelay64(i) = output(1);
    AVGpacketDelay110(i) = output(2);
    AVGpacketDelay1518(i) = output(3);
    AVGpacketDelay64Err(i) = output(4);
    AVGpacketDelay110Err(i) = output(5);
    AVGpacketDelay1518Err(i) = output(6);
end

figure(1);
bar(C,AVGpacketDelay64);
title("Avg Packet Delay 64 1e");
hold on;
eb1 = errorbar(C,AVGpacketDelay64,AVGpacketDelay64Err,AVGpacketDelay64Err);
eb1.Color = [0 0 0];
eb1.LineStyle = 'none';
hold off;

figure(2);
bar(C,AVGpacketDelay110);
title("Avg Packet Delay 110 1e");
hold on;
eb2 = errorbar(C,AVGpacketDelay110,AVGpacketDelay110Err,AVGpacketDelay110Err);
eb2.Color = [0 0 0];
eb2.LineStyle = 'none';
hold off;

figure(3);
bar(C,AVGpacketDelay1518);
title("Avg Packet Delay 1518 1e");
hold on;
eb3 = errorbar(C,AVGpacketDelay1518,AVGpacketDelay1518Err,AVGpacketDelay1518Err);
eb3.Color = [0 0 0];
eb3.LineStyle = 'none';
hold off;
