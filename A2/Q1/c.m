X = load('train_x.txt');
Y = load('train_y.txt');

[m,n] = size(X);

Q = zeros(m,m);

b = ones(m,1);

gamma = 0.00025;

for i=1:m
	for j=1:m       
		Q(i,j) = Y(i)*Y(j)*exp(-(gamma*(norm(X(i,:)-X(j,:))^2)));
	end
end
 
cvx_begin
    cvx_precision low
    variable alph(m)
    maximize (b'*alph - (1/2)*alph'*Q*alph)
    subject to
        alph'*Y == 0
        0 <= alph <= 1      
cvx_end

%support vectors
epsilon = 0.001;
num_sv=0;
for i=1:m
if(alph(i)>epsilon && alph(i)<1)
    num_sv = num_sv + 1;   
end
end

num_sv


mini = inf;
maxi = -inf;

for i=1:m
    temp = 0;    
    for j = 1:m
    temp = temp + alph(j)*Y(j)*(exp(-gamma*(norm(X(j,:)-X(i,:))^2)));        
    end   
    if Y(i)== 1
        mini = min(mini,temp);
    else 
        maxi = max(maxi,temp);        
    end       
end

b = -(mini + maxi)/2;

X_test = load('test_x.txt');
Y_test = load('test_y.txt');

[M,N] = size(X_test);

y = zeros(M,1);

count = 0;

for i=1:M    
    temp = b;    
    for j = 1:m
    temp = temp + alph(j)*Y(j)*(exp(-gamma*(norm(X(j,:)-X_test(i,:))^2)));        
    end    
    if temp > 0
        y(i) = 1;
        if y(i) == Y_test(i)
           count = count + 1;
        end    
    else
        y(i) = -1;
        if y(i) == Y_test(i)
           count = count + 1;
        end   
    end    
end


accuracy = (count/M)*100
% 98.7163