clear all;
x = load('q2x.dat');
y = load('q2y.dat');



m = size(x,1);
x = [ones(m,1) x];
n = size(x,2);
g = @(z)(1./(1 + exp(-z))); %sigmoid 
theta = zeros(n, 1);
H = zeros(n,n); % Hessian

for i = 1:20
    z = x * theta;
    h = g(z);    
    slope = (1/m)*x'*(y-h);
    
    %H = (1/m)*x'*diag(h)*diag(1-h)*x;
    
    for j = 1:m
        for k = 1:n
            for l = 1:n
                H(k,l) = H(k,l) + h(j)*(1-h(j))*x(j,k)*x(j,l);
            end
        end
    end
    
    
    theta = theta + inv(H)*slope;
end

class1   = find(y == 1); 
class0   = find(y == 0);

plot(x(class1,2), x(class1,3), 'x'); 
hold on
plot(x(class0,2), x(class0,3), '*');
x1 = x(:,2);
y1 = (-1/theta(3))*(theta(2)*x(:,2)+theta(1)*x(:,1));
plot(x1,y1);
legend('y=1','y=0','Decision Boundary');

theta





