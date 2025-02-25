%digit1 = 3;
%digit2 = 5;

trainData = csvread('data\train.csv');
trainData = [trainData(:,end),trainData(:,1:end-1)];
trainData_digit1 = trainData(trainData(:,1)==digit1,:);
trainData_digit2 = trainData(trainData(:,1)==digit2,:);
trainData = [trainData_digit1; trainData_digit2];

trainData_shuffle = trainData(randperm(size(trainData,1)),:);
trainData_shuffle(trainData_shuffle(:,1) == digit1) = 1;
trainData_shuffle(trainData_shuffle(:,1) == digit2) = -1;


testData = csvread('data\test.csv');
testData = [testData(:,end),testData(:,1:end-1)];
testData_digit1 = testData(testData(:,1)==digit1,:);
testData_digit2 = testData(testData(:,1)==digit2,:);
testData = [testData_digit1; testData_digit2];

testData_shuffle = testData(randperm(size(testData,1)),:);
testData_shuffle(testData_shuffle(:,1) == digit1) = 1;
testData_shuffle(testData_shuffle(:,1) == digit2) = -1;

totalData = [trainData_shuffle; testData_shuffle];

%aa_shuffle = aa(randperm(size(aa,1)),:);
% 
fileID = fopen(['MNIST_qs3vm_',num2str(digit1),num2str(digit2),'_.dat'],'w');
%fprintf(fileID,'%6s %12s\n','x','exp(x)');
for i=1:size(totalData,1)
    fprintf(fileID,'%d',totalData(i,1));
    for j=2:size(totalData,2)
        fprintf(fileID,' %d:',j-1);
        fprintf(fileID,'%0.6f',totalData(i,j));
    end
    fprintf(fileID,' \n');
end

fclose(fileID);

% err = zeros(10,1);
% for i = 1:100
%     aa_shuffle = aa(randperm(size(aa,1)),:);
% 
%     count_l = 10;
% 
%     xx = aa_shuffle(1:count_l,2:end);
%     yy = aa_shuffle(1:count_l,1);
% 
%     sum(yy==1);
% 
%     SVMModel = fitcsvm(xx,yy);
%     [label,score] = predict(SVMModel,aa_shuffle(count_l+1:end,2:end));
%     err(i) = sum(label~=aa_shuffle(count_l+1:end,1))/length(label);
% end