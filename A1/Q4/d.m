clear all;
x = load('q4x.dat');
Y = importdata('q4y.dat');

[m,n] = size(x);
y = zeros(m,1);

for i = 1:m
    if(Y{i}=='Canada')
      y(i)=1;
    end  
end

y0 = find(y==0); %Alaska
y1 = find(y==1); %Canada 

x0 = x(y0,:);
x1 = x(y1,:);

m0 = size(x0,1);
m1 = size(x1,1);

mu0 = sum(x0)'/m0;
mu1 = sum(x1)'/m1;


C0 = zeros(n,n);

for i=1:m
	if(y(i,:) == 0)
		C0 = C0 + (x(i,:)'-mu0)*(x(i,:)'-mu0)';
    end
end
C0 = C0 / m0;


C1 = zeros(n,n);
for i=1:m
	if(y(i,:) == 1)
		C1 = C1 + (x(i,:)'-mu1)*(x(i,:)'-mu1)';
    end
end
C1 = C1/m1;


mu0
mu1
C0
C1



