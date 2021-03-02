% Run Full
clear all; clc; 
tic;
featureDict = extractFeatures();

%%% Train Clean
trainList = 'trainCleanList.txt';
[eer_C,threshold] = trainClassifier(trainList,featureDict);


% Test Clean
testList = 'testCleanList.txt';
[TotalError_CC, FPR_CC, FNR_CC] = testClassifier(testList,featureDict,threshold);

% Test Babble
testList = 'testBabbleList.txt';
[TotalError_CB, FPR_CB, FNR_CB] = testClassifier(testList,featureDict,threshold);

%%% Train Multi
trainList = 'trainMultiList.txt';
[eer_M,threshold] = trainClassifier(trainList,featureDict);

% Test Clean
testList = 'testCleanList.txt';
[TotalError_MC, FPR_MC, FNR_MC] = testClassifier(testList,featureDict,threshold);

% Test Babble
testList = 'testBabbleList.txt';
[TotalError_MB, FPR_MB, FNR_MB] = testClassifier(testList,featureDict,threshold);


toc