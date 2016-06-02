clear all;
x = load('q1x.dat');
y = load('q1y.dat');

% normalizing
mu = mean(x);
sigma = std(x);
x = (x-mu)./sigma;

m = size(x,1);

%adding the intercept term
x = [ones(m,1) x];

alpha = 0.001; %learning rate
epsilon = 0.000001;

n = size(x,2);

theta_old = zeros(n,1);
flag = true;

while flag  
    
    h = x*theta_old;
    theta = theta_old + alpha*(1/m)*(x'*(y-h));
    
    if abs(theta - theta_old) < epsilon
        flag = false;
    end
    
    theta_old = theta;
  
end


theta = (theta)';

x1 = min(x(:,2))-1:max(x(:,2))+1;
plot(x1, theta(2)*x1 + theta(1), '-', x(:,2), y, '.r');
alpha
theta
epsilon