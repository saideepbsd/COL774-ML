X = load('train_x.txt');
Y = load('train_y.txt');

[m,n] = size(X);

Q = zeros(m,m);

b = ones(m,1);

w = zeros(n,1);

C=1;

for i=1:m
	for j=1:m
		Q(i,j) = Y(i)*Y(j)*X(i,:)*(X(j,:))';
	end
end
 

cvx_begin
    cvx_precision low
    variable alph(m)
    maximize (b'*alph - (1/2)*alph'*Q*alph)
    subject to
        alph'*Y == 0;
        0 <= alph; 
        alph<= C;      
cvx_end

%support vectors
epsilon = 0.001;

num_sv=0;

for i=1:m
    if (alph(i)>epsilon&&alph(i)<C)
    num_sv = num_sv + 1;   
    end
end

num_sv

for i=1:m
    w = w + (alph(i)*Y(i)*X(i,:))';
end

mini = inf;
maxi = -inf;

for i=1:m
    if Y(i)== 1
        mini = min(mini,X(i,:)*w);
    else 
        maxi = max(maxi,X(i,:)*w);        
    end       
end

b = -(mini + maxi)/2;

X_test = load('test_x.txt');
Y_test = load('test_y.txt');

[M,N] = size(X_test);

y = zeros(M,1);

count = 0;

for i=1:M
    if (X_test(i,:)*w + b) > 0
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

% 98.4596

