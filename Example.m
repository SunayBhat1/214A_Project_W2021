%%% See Read Me for Full package details
addpath('DataFiles'); % Adds provided data files

%%% Example 1
% Test Classiifer on data
testList = 'testCleanList.txt';
prediction = speakerVerifyClassifier(testList);

% Check results
fid = fopen(testList);
myData = textscan(fid,'%s %s %f');
fclose(fid);
labels = myData{3};

FPR = sum(~labels & prediction)/sum(~labels);
FNR = sum(labels & ~prediction)/sum(labels);

disp(['The false positive rate is ',num2str(FPR*100),'%.'])
disp(['The false negative rate is ',num2str(FNR*100),'%.'])


%%% Example 2
testList = 'testBabbleList.txt';
prediction = speakerVerifyClassifier(testList);

% Check results
fid = fopen(testList);
myData = textscan(fid,'%s %s %f');
fclose(fid);
labels = myData{3};

FPR = sum(~labels & prediction)/sum(~labels);
FNR = sum(labels & ~prediction)/sum(labels);

disp(['The false positive rate is ',num2str(FPR*100),'%.'])
disp(['The false negative rate is ',num2str(FNR*100),'%.'])

% Train and Test Classifier on data (Took 45 mins on given files here)
% trainList = 'trainMultiList.txt';
% testList = 'testBabbleList.txt';
% prediction = speakerVerifyClassifier(testList,trainList);
% 
% % Check results
% fid = fopen(testList);
% myData = textscan(fid,'%s %s %f');
% fclose(fid);
% labels = myData{3};
% 
% FPR = sum(~labels & prediction)/sum(~labels);
% FNR = sum(labels & ~prediction)/sum(labels);
% 
% disp(['The false positive rate is ',num2str(FPR*100),'%.'])
% disp(['The false negative rate is ',num2str(FNR*100),'%.'])
