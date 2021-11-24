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

gbar = bar(lambda,AVGpacketDelay);
hold on;
eb = errorbar(lambda,AVGpacketDelay,AVGpacketError,AVGpacketError);
eb.Color = [0 0 0];
eb.LineStyle = 'none';
hold off;

%% 1b

clearvars;


