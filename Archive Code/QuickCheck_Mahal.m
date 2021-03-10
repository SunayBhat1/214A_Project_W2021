% QuickCheck Mahal

%% Clean Train
threshold.mu0 = mean(ScoreDataT(labelT==0,:));
threshold.std0 = std(ScoreDataT(labelT==0,:));
threshold.mu1 = mean(ScoreDataT(labelT==1,:));
threshold.std1 = std(ScoreDataT(labelT==1,:));
threshold.mus = mean(ScoreDataT);


testList = 'testCleanList.txt';
[FPR_CC, FNR_CC] = testClassifier(testList,featureDict,threshold);

testList = 'testBabbleList.txt';
[FPR_CB, FNR_CB] = testClassifier(testList,featureDict,threshold);

%% Multi Train
threshold.mu0 = mean(ScoreDataM(labelM==0,:));
threshold.std0 = std(ScoreDataM(labelM==0,:));
threshold.mu1 = mean(ScoreDataM(labelM==1,:));
threshold.std1 = std(ScoreDataM(labelM==1,:));
threshold.mus = mean(ScoreDataM);

testList = 'testCleanList.txt';
[FPR_MC, FNR_MC] = testClassifier(testList,featureDict,threshold);

testList = 'testBabbleList.txt';
[FPR_MB, FNR_MB] = testClassifier(testList,featureDict,threshold);

%% Babble Train
threshold.mu0 = mean(ScoreDataB(labelB==0,:));
threshold.std0 = std(ScoreDataB(labelB==0,:));
threshold.mu1 = mean(ScoreDataB(labelB==1,:));
threshold.std1 = std(ScoreDataB(labelB==1,:));
threshold.mus = mean(ScoreDataB);

testList = 'testCleanList.txt';
[FPR_BC, FNR_BC] = testClassifier(testList,featureDict,threshold);

testList = 'testBabbleList.txt';
[FPR_BB, FNR_BB] = testClassifier(testList,featureDict,threshold);

%%
disp(['The CC FPR is ',num2str(FPR_CC*100),'%.'])
disp(['The CC FNR is ',num2str(FNR_CC*100),'%.'])
disp(['The CB FPR is ',num2str(FPR_CB*100),'%.'])
disp(['The CB FNR is ',num2str(FNR_CB*100),'%.'])
disp(['The MC FPR is ',num2str(FPR_MC*100),'%.'])
disp(['The MC FNR is ',num2str(FNR_MC*100),'%.'])
disp(['The MB FPR is ',num2str(FPR_MB*100),'%.'])
disp(['The MB FNR is ',num2str(FNR_MB*100),'%.'])
disp(['The BC FPR is ',num2str(FPR_BC*100),'%.'])
disp(['The BC FNR is ',num2str(FNR_BC*100),'%.'])
disp(['The BB FPR is ',num2str(FPR_BB*100),'%.'])
disp(['The BB FNR is ',num2str(FNR_BB*100),'%.'])