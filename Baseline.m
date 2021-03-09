% Run Full
clear all; clc; 
tic;
featureDict = extractFeatures();

%% Train Clean
trainList = 'trainCleanList.txt';
[threshold,ScoreDataT] = trainClassifier(trainList,featureDict);

% Test Clean
testList = 'testCleanList.txt';
[FPR_CC, FNR_CC] = testClassifier(testList,featureDict,threshold);

% Test Babble
testList = 'testBabbleList.txt';
[FPR_CB, FNR_CB] = testClassifier(testList,featureDict,threshold);

%% Train Multi
trainList = 'trainMultiList.txt';
[threshold,ScoreDataM] = trainClassifier(trainList,featureDict);

% Test Clean
testList = 'testCleanList.txt';
[FPR_MC, FNR_MC] = testClassifier(testList,featureDict,threshold);

% Test Babble
testList = 'testBabbleList.txt';
[FPR_MB, FNR_MB] = testClassifier(testList,featureDict,threshold);

%% Train Babble
trainList = 'trainBabbleList.txt';
[threshold,ScoreDataB] = trainClassifier(trainList,featureDict);

% Test Clean
testList = 'testCleanList.txt';
[FPR_BC, FNR_BC] = testClassifier(testList,featureDict,threshold);

% Test Babble
testList = 'testBabbleList.txt';
[FPR_BB, FNR_BB] = testClassifier(testList,featureDict,threshold);

%%
disp(['The false CC positive rate is ',num2str(FPR_CC*100),'%.'])
disp(['The false CC negative rate is ',num2str(FNR_CC*100),'%.'])
disp(['The false CB positive rate is ',num2str(FPR_CB*100),'%.'])
disp(['The false CB negative rate is ',num2str(FNR_CB*100),'%.'])
disp(['The false MC positive rate is ',num2str(FPR_MC*100),'%.'])
disp(['The false MC negative rate is ',num2str(FNR_MC*100),'%.'])
disp(['The false MB positive rate is ',num2str(FPR_MB*100),'%.'])
disp(['The false MB negative rate is ',num2str(FNR_MB*100),'%.'])
disp(['The false BC positive rate is ',num2str(FPR_BC*100),'%.'])
disp(['The false BC negative rate is ',num2str(FNR_BC*100),'%.'])
disp(['The false BB positive rate is ',num2str(FPR_BB*100),'%.'])
disp(['The false BB negative rate is ',num2str(FNR_BB*100),'%.'])

toc