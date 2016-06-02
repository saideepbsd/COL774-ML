function [] = a_display(index)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

Data = importdata('mnist_all.mat')

eg = Data.train3;

%m = size(eg,1);

I = zeros(28,28);

f = eg(index,:);

for j = 1:28
   I(j,:) = f(28*(j-1)+1:28*j);  
end

imshow(I);

end

