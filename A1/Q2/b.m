function [y1] = b(Tau)

x = load('q3x.dat');
y = load('q3y.dat');

m = size(x,1); % number of data points

x = [ones(m,1) x]; % add intercept term

y1 = zeros(m,1); 

theta = inv(x'*x)*x'*y;


for i = 1:m
        w = exp(-(x(i,2) - x(:,2)).^2./(2*Tau^2));
		W = diag(w);
		theta = inv(x'*W*x)*x'*W*y;
		y1(i) = x(i,:)*theta;    
end

x1 = x(:,2);
plot(x1,y,'.b');
hold on
plot(x1,y1,'.r');
legend('Original Data', 'Locally Weighted Linear Regression','Location','northoutside','Orientation','horizontal');

theta
end
