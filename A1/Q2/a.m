x = load('q3x.dat');
y = load('q3y.dat');

m = size(x,1); % number of data points

x = [ones(m,1) x]; % add intercept term

y1 = zeros(m,1); 

theta = inv(x'*x)*x'*y;

for i = 1:m
    y1(i) = x(i,:)*theta;
end

theta

x1 = x(:,2);
plot(x1,y,'.b');
hold on
plot(x1,y1,'.r');
legend('Original Data', 'Unweighted Linear Regression','Location','northoutside','Orientation','horizontal');



