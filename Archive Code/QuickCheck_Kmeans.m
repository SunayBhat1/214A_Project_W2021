% QuickCheck Kmeans

%% Clean Train
[~,C0] = kmeans(ScoreDataT(labelsT==0,:),1);
[~,C1] = kmeans(ScoreDataT(labelsT==1,:),1);
mu = zeros(1,15);
sigma = zeros(1,15);
for i = 1:15
    [mu(i),sigma(i)] = normfit(ScoreDataT(:,i));
end

threshold.C0 = (C0 - mu)./sigma;
threshold.C1 = (C1 - mu)./sigma;


testList = 'testCleanList.txt';
[FPR_CC, FNR_CC] = testClassifier(testList,featureDict,threshold);

testList = 'testBabbleList.txt';
[FPR_CB, FNR_CB] = testClassifier(testList,featureDict,threshold);

disp(['The CC FPR is ',num2str(FPR_CC*100),'%.'])
disp(['The CC FNR is ',num2str(FNR_CC*100),'%.'])
disp(['The CB FPR is ',num2str(FPR_CB*100),'%.'])
disp(['The CB FNR is ',num2str(FNR_CB*100),'%.'])

%% Multi Train
[~,C0] = kmeans(ScoreDataM(labelsM==0,:),1);
[~,C1] = kmeans(ScoreDataM(labelsM==1,:),1);
mu = zeros(1,15);
sigma = zeros(1,15);
for i = 1:15
    [mu(i),sigma(i)] = normfit(ScoreDataM(:,i));
end

threshold.C0 = (C0 - mu)./sigma;
threshold.C1 = (C1 - mu)./sigma;


testList = 'testCleanList.txt';
[FPR_MC, FNR_MC] = testClassifier(testList,featureDict,threshold);

testList = 'testBabbleList.txt';
[FPR_MB, FNR_MB] = testClassifier(testList,featureDict,threshold);

disp(['The MC FPR is ',num2str(FPR_MC*100),'%.'])
disp(['The MC FNR is ',num2str(FNR_MC*100),'%.'])
disp(['The MB FPR is ',num2str(FPR_MB*100),'%.'])
disp(['The MB FNR is ',num2str(FNR_MB*100),'%.'])

%% Babble Train
[~,C0] = kmeans(ScoreDataB(labelsB==0,:),1);
[~,C1] = kmeans(ScoreDataB(labelsB==1,:),1);
mu = zeros(1,15);
sigma = zeros(1,15);
for i = 1:15
    [mu(i),sigma(i)] = normfit(ScoreDataB(:,i));
end

threshold.C0 = (C0 - mu)./sigma;
threshold.C1 = (C1 - mu)./sigma;


testList = 'testCleanList.txt';
[FPR_BC, FNR_BC] = testClassifier(testList,featureDict,threshold);

testList = 'testBabbleList.txt';
[FPR_BB, FNR_BB] = testClassifier(testList,featureDict,threshold);

disp(['The BC FPR is ',num2str(FPR_BC*100),'%.'])
disp(['The BC FNR is ',num2str(FNR_BC*100),'%.'])
disp(['The BB FPR is ',num2str(FPR_BB*100),'%.'])
disp(['The BB FNR is ',num2str(FNR_BB*100),'%.'])

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