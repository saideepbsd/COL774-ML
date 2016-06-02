function [ ] = contour() 
x = load('q1x.dat');
y = load('q1y.dat');

alpha = 0.5;
% normalizing
mu = mean(x);
sigma = std(x);
x = (x-mu)./sigma;

m = size(x,1);

%adding the intercept term
x = [ones(m,1) x];

n = size(x,2);

J_theta = zeros(100, 100);   
t0 = linspace(0, 10, 100);
t1 = linspace(0, 10, 100);

for i = 1:length(t0)
    for j = 1:length(t1)
	  theta = [t0(i); t1(j)];
      h = x*theta;
	  J_theta(i,j) = 1/(2*m)*(sum((h-y)'*(h-y)));
    end
end

J_theta = J_theta';
figure;
contour(t0,t1,J_theta);
xlabel('\theta_0'); ylabel('\theta_1')
hold on 


%alpha = 0.0001; %learning rate
epsilon = 0.000001;
theta_old = zeros(n,1);
flag = true;

while flag          
    
    h = x*theta_old;
    cost = 1/(2*m)*(sum((h-y)'*(h-y)));          
    hold on
    scatter3(theta_old(1),theta_old(2),cost);   
    hold off
    
    theta = theta_old + alpha*(1/m)*(x'*(y-h));         
    if abs(theta - theta_old) < epsilon
        flag = false;
    end
    
    theta_old = theta;    
    pause (0.2); 
end
end
