%### estimating performance with different amplitude and with fixed number of
%samples (n = 50) 
%variance = 1
Q1 = zeros(1,40);
count_s1 = 0;
sigma = 1;
%presence of target
for a = [0.5 : 0.5 : 20]
    R1 = normrnd(a,sigma,[1,50]);
    X = sum(R1)/50;
    Q1(1,a*2) = X;
    if (X > a/2)
        count_s1= count_s1 +1;
    end
end
fprintf("by varying amplitude of samples taken, number of times correct results obtained (out of 40)\n");
fprintf('In the presence of target= %i\n',  count_s1);


%absence of target
Q2 = zeros(1,40);
count_s2 = 0;
for a = 0.5 : 0.5 : 20
    R2 = normrnd(0,sigma,[1,50]);
    X = sum(R2)/50;
    Q2(1,a*2) = X;
    if (X <= a/2)
        count_s2= count_s2 +1;
    end
end
% presence
subplot(2,1,1)
fprintf('In the absence of target = %i\n',  count_s2)

x = 1:40; 
plot(x,Q1);
xlabel("amplitude of signal, A");
ylabel("average of signal");
title('average of received signal VS number of samples (target present)');
grid on;
% absence
subplot(2,1,2)
plot(x,Q2);
xlabel("amplitude of signal, A");
ylabel("average of signal");
title('average of received signal VS number of samples (target absent)');
grid on;
 
pause;
close all 
%performance curves
x = [0.5 : 0.25 : 20];
plot(x,qfunc(-x*sqrt(50)/2));
xlabel('DC amplitude');
ylabel('cumulative probability of presence of target');
title('performance of detector versus amplitude of signal');
grid on;
fprintf('After taking amplitude of signal approx. greater than 1V probabilty of detection is one\n');

    