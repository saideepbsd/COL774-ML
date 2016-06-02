file = fopen('test_updated.data');

m = 779; % training examples
n = 1558; % attributes

X = zeros(m,n);  %attribute matrix
Y = ones(m,1);   % ad or non ------ add ad -1 nonad 1

count = 0;

while true
    
   line = fgetl(file);
  
   if ~ischar(line)
        break
   end
   
   count=count+1;
   
   S = textscan(line, '%s','Delimiter',',');
      
   for i = 1:1558
      X(count,i)=str2double(S{1}{i});
   end
   
   if (strcmp(S{1}{1559},'ad.'))
        Y(count) = -1;
   end
   
      
end

dlmwrite('test_x.txt',X,'delimiter','\t');
dlmwrite('test_y.txt',Y,'delimiter','\t');


