g = @(x) 1./(1+exp(-x)) ;
grad = @(x) x.*(1-x);

all = load('mnist_all.mat');

train_0 = all.train0;
train_1 = all.train1;
train_2 = all.train2;
train_3 = all.train3;
train_4 = all.train4;
train_5 = all.train5;
train_6 = all.train6;
train_7 = all.train7;
train_8 = all.train8;
train_9 = all.train9;


X = [train_0;train_1;train_2;train_3;train_4;train_5;train_6;train_7;train_8;train_9;];
X = im2double(X);

[m,n] = size(X);

Y_0 = zeros(size(train_0,1),10); % 0
Y_0(:,1) = 1;

Y_1 = zeros(size(train_1,1),10); % 0
Y_1(:,2) = 1;

Y_2 = zeros(size(train_2,1),10); % 0
Y_2(:,3) = 1;

Y_3 = zeros(size(train_3,1),10); % 0
Y_3(:,4) = 1;

Y_4 = zeros(size(train_4,1),10); % 0
Y_4(:,5) = 1;

Y_5 = zeros(size(train_5,1),10); % 0
Y_5(:,6) = 1;

Y_6 = zeros(size(train_6,1),10); % 0
Y_6(:,7) = 1;

Y_7 = zeros(size(train_7,1),10); % 0
Y_7(:,8) = 1;

Y_8 = zeros(size(train_8,1),10); % 0
Y_8(:,9) = 1;

Y_9 = zeros(size(train_9,1),10); % 0
Y_9(:,10) = 1;


Y = [Y_0;Y_1;Y_2;Y_3;Y_4;Y_5;Y_6;Y_7;Y_8;Y_9];

random = randperm(m);
X = X(random, :);
Y = Y(random, :);

theta1 = -0.05 + 0.1*rand(100,785);
theta2 = -0.05 + 0.1*rand(10, 101);

epsilon = 0.0001;

t=0; 

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
        
        a3 = g(z3);  % 10 x 1
        J = J + 1/2*(norm(Y(i,:)'-a3)^2);
                       
        delta2 = (Y(i,:)'-a3).* (a3 .*(1-a3));
        
        delta1 = (theta2' * delta2).*(grad(a2)); 
        delta1 = delta1(2:end); 
        
        
        theta1 = theta1 + (delta1 * a1')./sqrt(t); 
        theta2 = theta2 + (delta2 * a2')./sqrt(t);
                                     
    end
    
    
    num_iter = num_iter+1;
        
    if abs(Jprev - J) < epsilon || num_iter > 50
        flag = false;
    end
    
    Jprev = J;

end   
toc

test_0 = all.test0;
test_1 = all.test1;
test_2 = all.test2;
test_3 = all.test3;
test_4 = all.test4;
test_5 = all.test5;
test_6 = all.test6;
test_7 = all.test7;
test_8 = all.test8;
test_9 = all.test9;


testX = [test_0;test_1;test_2;test_3;test_4;test_5;test_6;test_7;test_8;test_9;];
testX = im2double(testX);
[M,N] = size(testX);


testY_0 = zeros(size(test_0,1),1); % 0
testY_0 = 0 + testY_0;

testY_1 = zeros(size(test_1,1),1); % 0
testY_1 = 1 + testY_1;

testY_2 = zeros(size(test_2,1),1); % 0
testY_2 = 2 + testY_2;

testY_3 = zeros(size(test_3,1),1); % 0
testY_3 = 3 + testY_3;

testY_4 = zeros(size(test_4,1),1); % 0
testY_4 = 4 + testY_4;

testY_5 = zeros(size(test_5,1),1); % 0
testY_5 = 5 + testY_5;

testY_6 = zeros(size(test_6,1),1); % 0
testY_6 = 6 + testY_6;

testY_7 = zeros(size(test_7,1),1); % 0
testY_7 = 7 + testY_7;

testY_8 = zeros(size(test_8,1),1); % 0
testY_8 = 8 + testY_8;

testY_9 = zeros(size(test_9,1),1); % 0
testY_9 = 9 + testY_9;


testY = [testY_0;testY_1;testY_2;testY_3;testY_4;testY_5;testY_6;testY_7;testY_8;testY_9];

count = 0;


%blah = zeros(size(testY,1),1);

predicted = zeros(size(testY,1),1);

for i = 1:M
    
        temp1 = testX(i,:)';
        
        a1 = [1;temp1];
        
        z2 = theta1*a1;
        
        a2 = [1;g(z2)];
        
        z3 = theta2*a2;
        
        a3 = g(z3);
        
        %blah(i,1) = a3;

        
        maxi  = -inf;
        digit = -1;
        
        for j=1:10
            if(a3(j)>maxi)
                maxi = a3(j);
                digit = j-1;
            end
        end
        
        predicted(i)=digit;
     
end

for i = 1:M
   if(testY(i)==predicted(i))
       count = count+1;
   end
end


%blah
accuracy = (count/M)*100
%toc
%}

%Elapsed time is 831.810728 seconds.

%accuracy =

%   92.7500


