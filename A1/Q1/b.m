clear all; close all; clc

x = load('q1x.dat');
y = load('q1y.dat');

% normalizing
mu = mean(x);
sigma = std(x);
x = (x-mu)./sigma;

theta = [5.8381 4.6160];

x1 = min(x)-1:max(x)+1;

figure
plot(x1,theta(1) + theta(2)*x1 , '-', x, y, '.r');
xlabel('Area') % x-axis label
ylabel('Price') % y-axis label
legend('Batch Gradient Descent','Training Data','location','northoutside');
