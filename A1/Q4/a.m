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

C = zeros(n,n);

for i=1:m
	if(y(i,:)==1)
		mu=mu1;
	else
		mu=mu0;
	end
	C = C +(x(i,:)'-mu)*((x(i,:))'-mu)';
end;

C = C/m;




plot(x0(:,1),x0(:,2),'o');
hold on
plot(x1(:,1),x1(:,2),'x');
legend('Alaska','Canada');

mu0
mu1
C
x1 = x(:,1);
phi = (1/m)*sum(y(y1,:));
logK = log((1-phi)/phi) - (1/2)*((mu0+mu1)'*inv(C)*(mu0-mu1));
z = C\(mu0-mu1);
plot(x1,(1/z(2)).*(-logK-z(1)*x1));

