% n - number of samples

% w - noise 
% DC signal sent A = 1, sigma = 1

%##for estimating performance with different number of samples with fixed
%amplitude  
% when target is present
% Q is an array containing sample mean for different number of samples for
% this case
A = 1;
sigma = 1;
n = 100;
Q = zeros(1,n);
count_s = 0;
for  i = 1:n
    R = normrnd(A , sigma, [1,i]);
    X = sum(R)/i;
    Q(1,i) = X;
    if (X > A/2)
        count_s= count_s +1;
    end
end
fprintf("by varying number of samples taken, number of times correct results obtained  (out of 100)\n");
fprintf('In the presence of target= %i\n',  count_s);
% when target is absent
% Z is an array containing sample mean for different number of samples for
% this case
Z = zeros(1,n);
count_n = 0;
for i = 1:n
    R = normrnd(0, sigma, [1,i]);
    X = sum(R)/i;
    Z(1,i) = X;
    if (X<=A/2)
        count_n = count_n+1;
    end
end

fprintf('In the absence of target = %i\n',  count_n)



% plot samples received in presence and absence of target
% presence
figure(1);
subplot(2,1,1);

x = 1:100;
y1 =  normrnd(A , sigma, [1,100]);
stem(x,y1,'filled');
xlabel("sample, i");
ylabel("signal received");
title('samples received in presence of target');
grid on;
% absence
subplot(2,1,2);

y2 =  normrnd(0,sigma, [1,100]);
stem(x,y2,'filled');
xlabel("sample, i");
ylabel("signal received");
title('samples received in absence of target');
grid on;
pause;
close all;
figure(2);
% plot sample mean X vs i for samples received in presence and absence of target
subplot(2,1,1);

plot(x,Q);
hold on;
plot(x,0.5*ones(100),'--r');

hold off;
xlabel("number of samples, N");
ylabel('sample mean');
legend('sample mean', 'threshold')

grid on;

subplot(2,1,2);

plot(x,Z);
hold on;
plot(x,0.5*ones(100),'--r');

hold off;
xlabel('number of samples, N');
ylabel('sample mean');
legend('sample mean', 'threshold')

grid on;
pause;
close all;
%performance curves
figure(3);
plot(x,qfunc(-A*sqrt(x)/2));
xlabel('number of samples, N');
ylabel('cumulative probability of presence of target');
title('performance of detector versus number of samples');
grid on;
fprintf('After taking approx. 40 samples probabilty of detection is one\n');
    
    