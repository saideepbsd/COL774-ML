g = @(x) 1./(1+exp(-x)) ;
grad = @(x) x.*(1-x);

all = load('mnist_all.mat');

train_3 = all.train3;
train_8 = all.train8;

X = [train_3;train_8];
X = im2double(X);

[m,n] = size(X);

Y_3 = zeros(size(train_3,1),1); % 0
Y_8 = ones(size(train_8,1),1); % 1

Y = [Y_3;Y_8];

random = randperm(size(X,1));
X = X(random, :);
Y = Y(random, :);

theta1 = -0.05 + 0.1*rand(100,785);
theta2 = -0.05 + 0.1*rand(1, 101);

epsilon = 0.0001;

t=0; %num_iter

flag = true;

Jprev = inf;

num_iter=0;

tic;

while flag
    
    J = 0;
    
    for i=1:m
        
        t=t+1;       
        
        temp1 = X(i,:)';
        
        a1 = [1;temp1];
        
        z2 = theta1*a1;
        
        a2 = [1;g(z2)];
        
        z3 = theta2*a2;
        
        a3 = g(z3);
        
        J = J + 1/2*(norm(Y(i,1)-a3)^2);
        
        delta2 = a3*(1-a3)*(Y(i,1)-a3);
        
        delta1 = (theta2' * delta2).*(grad(a2)); 
        delta1 = delta1(2:end); 
        
        
        theta1 = theta1 + (delta1 * a1')/sqrt(t); 
        theta2 = theta2 + (delta2 * a2')/sqrt(t);
                                     
    end
    
    num_iter = num_iter+1;
        
    if abs(Jprev - J) < epsilon || num_iter > 40
        flag = false;
    end
    
    Jprev = J;

end   
toc

test_3 = all.test3;
test_8 = all.test8;

testX = [test_3;test_8];

testX = im2double(testX);

testY_3 = zeros(size(test_3,1),1);  % 1
testY_8 = ones(size(test_8,1),1); % 0

testY = [testY_3;testY_8];

count = 0;

[M,N] = size(testX);
%blah = zeros(size(testY,1),1);
for i = 1:M
    
        temp1 = testX(i,:)';
        
        a1 = [1;temp1];
        
        z2 = theta1*a1;
        
        a2 = [1;g(z2)];
        
        z3 = theta2*a2;
        
        a3 = g(z3);
        
        %blah(i,1) = a3;
          
        if a3 > 0.5
            if testY(i,1) == 1
                count = count + 1;
            end
       else
            if testY(i,1) == 0
                count = count + 1;
            end
        end
    
end


%blah
accuracy = (count/M)*100
%toc



