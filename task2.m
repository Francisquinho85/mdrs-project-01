%% 2a
close all;
clearvars;
clc;

lambda = 1500;
C = 10;
f = 1e6;
P = 10000;
n = (10:10:40);
numIter = 50;
fprintf("\n2a) \n");
AVGpacketDelay = zeros(1,4);
AVGpacketDelayVoip = zeros(1,4);
AVGpacketDelayErr = zeros(1,4);
AVGpacketDelayErrVoip = zeros(1,4);

for i=1:4
    fprintf("\n n = %d \n",n(i));
    output = RunSimulator3(lambda,C,f,P,n(i),numIter);
    AVGpacketDelay(i) = output(3);
    AVGpacketDelayVoip(i) = output(4);
    AVGpacketDelayErr(i) = output(10);
    AVGpacketDelayErrVoip(i) = output(11); 
end

figure(1);
bar(n,AVGpacketDelay);
title("Avg Packet Delay 2a");
hold on;
eb = errorbar(n,AVGpacketDelay,AVGpacketDelayErr,AVGpacketDelayErr);
eb.Color = [0 0 0];
eb.LineStyle = 'none';
hold off;

figure(2);
bar(n,AVGpacketDelayVoip);
title("Avg Packet Delay Voip 2a");
hold on;
errb = errorbar(n,AVGpacketDelayVoip,AVGpacketDelayErrVoip,AVGpacketDelayErrVoip);
errb.Color = [0 0 0];
errb.LineStyle = 'none';
hold off;

%% 2b
clearvars;

lambda = 1500;
C = 10;
f = 1e6;
P = 10000;
n = (10:10:40);
numIter = 50;
fprintf("\n2b) \n");
AVGpacketDelay = zeros(1,4);
AVGpacketDelayVoip = zeros(1,4);
AVGpacketDelayErr = zeros(1,4);
AVGpacketDelayErrVoip = zeros(1,4);

for i=1:4
    fprintf("\n n = %d \n",n(i));
    output = RunSimulator4(lambda,C,f,P,n(i),numIter);
    AVGpacketDelay(i) = output(3);
    AVGpacketDelayVoip(i) = output(4);
    AVGpacketDelayErr(i) = output(10);
    AVGpacketDelayErrVoip(i) = output(11); 
end

figure(3);
bar(n,AVGpacketDelay);
title("Avg Packet Delay 2b");
hold on;
eb = errorbar(n,AVGpacketDelay,AVGpacketDelayErr,AVGpacketDelayErr);
eb.Color = [0 0 0];
eb.LineStyle = 'none';
hold off;

figure(4);
bar(n,AVGpacketDelayVoip);
title("Avg Packet Delay Voip 2b");
hold on;
errb = errorbar(n,AVGpacketDelayVoip,AVGpacketDelayErrVoip,AVGpacketDelayErrVoip);
errb.Color = [0 0 0];
errb.LineStyle = 'none';
hold off;

%% 2c

clearvars;

lambdaData = 1500;
C = 10 * 1e6;
n = (10:10:40);

fprintf("\n2c) \n");

avgPacketSizeData = 0;
for j=64:1518     
    if j==64
        avgPacketSizeData = avgPacketSizeData + (64*0.19);
    elseif j==110
        avgPacketSizeData = avgPacketSizeData + (110*0.23);
    elseif j==1518
        avgPacketSizeData = avgPacketSizeData + (1518*0.17);
    else
        avgPacketSizeData = avgPacketSizeData + j*((1 - 0.19 - 0.23 - 0.17)/(1519-64-3));
    end
end

miuData = C / (avgPacketSizeData*8);

avgPacketSizeVoIP = 0;
for j=110:130
    avgPacketSizeVoIP = avgPacketSizeVoIP + j*(1/21);
end

miuVoIP = C / (avgPacketSizeVoIP*8);

w = zeros(1,2);

for i=1:4
    lambdaVoIP = 50 * n(i);
    esData = 1/miuData;
    esVoIP = 1/miuVoIP;
    es2Data = 2/(miuData^2);
    es2VoIP = 2/(miuVoIP^2);
    fprintf("\n n = %d \n",n(i));
    roVoIP = lambdaVoIP * esVoIP;
    roData = lambdaData * esData;
    w(1) = ((((lambdaVoIP * es2VoIP) + (lambdaData * es2Data)) / (2 * (1 - roVoIP))) + esVoIP)*1e3;
    w(2) = ((((lambdaVoIP * es2VoIP) + (lambdaData * es2Data)) / (2 * (1 - roVoIP) * (1 - roVoIP - roData))) + esData)*1e3;

    
    fprintf("\n wVoIP = %d \n",w(1));
    fprintf("\n wData = %d \n",w(2));
end

%% 2d
clearvars;

lambda = 1500;
C = 10;
f = 1e4;
P = 10000;
n = (10:10:40);
numIter = 50;
fprintf("\n2d) \n");
AVGpacketDelay = zeros(1,4);
AVGpacketDelayVoip = zeros(1,4);
AVGpacketDelayErr = zeros(1,4);
AVGpacketDelayErrVoip = zeros(1,4);
AVGpacketLoss = zeros(1,4);
AVGpacketLossErr = zeros(1,4);
AVGpacketLossVoip = zeros(1,4);
AVGpacketLossErrVoip = zeros(1,4);

for i=1:4
    fprintf("\n n = %d \n",n(i));
    output = RunSimulator3(lambda,C,f,P,n(i),numIter);
    AVGpacketLoss(i) = output(1);
    AVGpacketLossVoip(i) = output(2);
    AVGpacketDelay(i) = output(3);
    AVGpacketDelayVoip(i) = output(4);
    AVGpacketLossErr(i) = output(8);
    AVGpacketLossErrVoip(i) = output(9);
    AVGpacketDelayErr(i) = output(10);
    AVGpacketDelayErrVoip(i) = output(11); 
end

figure(5);
bar(n,AVGpacketDelay);
title("Avg Packet Delay 2d");
hold on;
eb1 = errorbar(n,AVGpacketDelay,AVGpacketDelayErr,AVGpacketDelayErr);
eb1.Color = [0 0 0];
eb1.LineStyle = 'none';
hold off;

figure(6);
bar(n,AVGpacketDelayVoip);
title("Avg Packet Delay Voip 2d");
hold on;
eb2 = errorbar(n,AVGpacketDelayVoip,AVGpacketDelayErrVoip,AVGpacketDelayErrVoip);
eb2.Color = [0 0 0];
eb2.LineStyle = 'none';
hold off;

figure(7);
bar(n,AVGpacketLoss);
title("Data Packet Loss 2d");
hold on;
eb3 = errorbar(n,AVGpacketLoss,AVGpacketLossErr,AVGpacketLossErr);
eb3.Color = [0 0 0];
eb3.LineStyle = 'none';
hold off;

figure(8);
bar(n,AVGpacketLossVoip);
title("Voip Packet Loss 2d");
hold on;
eb4 = errorbar(n,AVGpacketLossVoip,AVGpacketLossErrVoip,AVGpacketLossErrVoip);
eb4.Color = [0 0 0];
eb4.LineStyle = 'none';
hold off;

%% 2e
clearvars;

lambda = 1500;
C = 10;
f = 1e4;
P = 10000;
n = (10:10:40);
numIter = 50;
fprintf("\n2e) \n");
AVGpacketDelay = zeros(1,4);
AVGpacketDelayVoip = zeros(1,4);
AVGpacketDelayErr = zeros(1,4);
AVGpacketDelayErrVoip = zeros(1,4);
AVGpacketLoss = zeros(1,4);
AVGpacketLossErr = zeros(1,4);
AVGpacketLossVoip = zeros(1,4);
AVGpacketLossErrVoip = zeros(1,4);

for i=1:4
    fprintf("\n n = %d \n",n(i));
    output = RunSimulator4(lambda,C,f,P,n(i),numIter);
    AVGpacketLoss(i) = output(1);
    AVGpacketLossVoip(i) = output(2);
    AVGpacketDelay(i) = output(3);
    AVGpacketDelayVoip(i) = output(4);
    AVGpacketLossErr(i) = output(8);
    AVGpacketLossErrVoip(i) = output(9);
    AVGpacketDelayErr(i) = output(10);
    AVGpacketDelayErrVoip(i) = output(11); 
end

figure(1);
tiledlayout(2,2);
ax1 = nexttile;
bar(ax1,n,AVGpacketDelay);
title("Avg Packet Delay 2e");
hold on;
eb1 = errorbar(n,AVGpacketDelay,AVGpacketDelayErr,AVGpacketDelayErr);
eb1.Color = [0 0 0];
eb1.LineStyle = 'none';
hold off;

ax2 = nexttile;
bar(ax2,n,AVGpacketDelayVoip);
title("Avg Packet Delay Voip 2e");
hold on;
eb2 = errorbar(n,AVGpacketDelayVoip,AVGpacketDelayErrVoip,AVGpacketDelayErrVoip);
eb2.Color = [0 0 0];
eb2.LineStyle = 'none';
hold off;

ax3 = nexttile;
bar(ax3,n,AVGpacketLoss);
title("Data Packet Loss 2e");
hold on;
eb3 = errorbar(n,AVGpacketLoss,AVGpacketLossErr,AVGpacketLossErr);
eb3.Color = [0 0 0];
eb3.LineStyle = 'none';
hold off;

ax4 = nexttile;
bar(ax4,n,AVGpacketLossVoip);
title("Voip Packet Loss 2e");
hold on;
eb4 = errorbar(n,AVGpacketLossVoip,AVGpacketLossErrVoip,AVGpacketLossErrVoip);
eb4.Color = [0 0 0];
eb4.LineStyle = 'none';
hold off;

%% 2f
clearvars;

lambda = 1500;
C = 10;
f = 1e4;
P = 10000;
n = (10:10:40);
numIter = 50;
fprintf("\n2f) \n");
AVGpacketDelay = zeros(1,4);
AVGpacketDelayVoip = zeros(1,4);
AVGpacketDelayErr = zeros(1,4);
AVGpacketDelayErrVoip = zeros(1,4);
AVGpacketLoss = zeros(1,4);
AVGpacketLossErr = zeros(1,4);
AVGpacketLossVoip = zeros(1,4);
AVGpacketLossErrVoip = zeros(1,4);

for i=1:4
    fprintf("\n n = %d \n",n(i));
    output = RunSimulator4WRED(lambda,C,f,P,n(i),numIter);
    AVGpacketLoss(i) = output(1);
    AVGpacketLossVoip(i) = output(2);
    AVGpacketDelay(i) = output(3);
    AVGpacketDelayVoip(i) = output(4);
    AVGpacketLossErr(i) = output(8);
    AVGpacketLossErrVoip(i) = output(9);
    AVGpacketDelayErr(i) = output(10);
    AVGpacketDelayErrVoip(i) = output(11); 
end

figure(2);
tiledlayout(2,2);
ax1 = nexttile;
bar(ax1,n,AVGpacketDelay);
title("Avg Packet Delay 2f");
hold on;
eb1 = errorbar(n,AVGpacketDelay,AVGpacketDelayErr,AVGpacketDelayErr);
eb1.Color = [0 0 0];
eb1.LineStyle = 'none';
hold off;

ax2 = nexttile;
bar(ax2,n,AVGpacketDelayVoip);
title("Avg Packet Delay Voip 2f");
hold on;
eb2 = errorbar(n,AVGpacketDelayVoip,AVGpacketDelayErrVoip,AVGpacketDelayErrVoip);
eb2.Color = [0 0 0];
eb2.LineStyle = 'none';
hold off;

ax3 = nexttile;
bar(ax3,n,AVGpacketLoss);
title("Data Packet Loss 2f");
hold on;
eb3 = errorbar(n,AVGpacketLoss,AVGpacketLossErr,AVGpacketLossErr);
eb3.Color = [0 0 0];
eb3.LineStyle = 'none';
hold off;

ax4 = nexttile;
bar(ax4,n,AVGpacketLossVoip);
title("Voip Packet Loss 2f");
hold on;
eb4 = errorbar(n,AVGpacketLossVoip,AVGpacketLossErrVoip,AVGpacketLossErrVoip);
eb4.Color = [0 0 0];
eb4.LineStyle = 'none';
hold off;

