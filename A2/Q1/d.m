train_X = load('train_x.txt');
train_Y = load('train_y.txt');

test_X = load('test_x.txt');
test_Y = load('test_y.txt');


model_1 = svmtrain(train_Y, train_X, '-t 0 -c 1');
[lin] = svmpredict(test_Y, test_X, model_1);

model_2 = svmtrain(train_Y, train_X, '-t 2 -g 0.00025 -c 1 ');
[gauss] = svmpredict(test_Y, test_X, model_2);
