% QuickCheck Sum

%% Clean Train
eer = zeros(1,10);
for i = 1:10
    weights = [i i i i i 1 1 1 1 1 1 i*2 i*3 i*4 i*5];
    scores = -sum(ScoreDataT.*weights,2);
    % scores = -(scores-min(scores))/mean(scores);
    [eer(i),threshold] = compute_eer(scores,labelsT,0);
    threshold = threshold/mean(scores);
end
plot(eer)

testList = 'testCleanList.txt';
[FPR_CC, FNR_CC] = testClassifier(testList,featureDict,threshold);

testList = 'testBabbleList.txt';
[FPR_CB, FNR_CB] = testClassifier(testList,featureDict,threshold);

disp(['The CC FPR is ',num2str(FPR_CC*100),'%.'])
disp(['The CC FNR is ',num2str(FNR_CC*100),'%.'])
disp(['The CB FPR is ',num2str(FPR_CB*100),'%.'])
disp(['The CB FNR is ',num2str(FNR_CB*100),'%.'])

%% Multi Train
scores = sum(ScoreDataM,2);
scores = -(scores-min(scores))/mean(scores);
[eer,threshold] = compute_eer(scores,labelsM);

testList = 'testCleanList.txt';
[FPR_MC, FNR_MC] = testClassifier(testList,featureDict,threshold);

testList = 'testBabbleList.txt';
[FPR_MB, FNR_MB] = testClassifier(testList,featureDict,threshold);

disp(['The MC FPR is ',num2str(FPR_MC*100),'%.'])
disp(['The MC FNR is ',num2str(FNR_MC*100),'%.'])
disp(['The MB FPR is ',num2str(FPR_MB*100),'%.'])
disp(['The MB FNR is ',num2str(FNR_MB*100),'%.'])

%% Babble Train
scores = sum(ScoreDataB,2);
scores = -(scores-min(scores))/mean(scores);
[eer,threshold] = compute_eer(scores,labelsB);
threshold = threshold/mean(scores);

testList = 'testCleanList.txt';
[FPR_BC, FNR_BC] = testClassifier(testList,featureDict,threshold);

testList = 'testBabbleList.txt';
[FPR_BB, FNR_BB] = testClassifier(testList,featureDict,threshold);

disp(['The BC FPR is ',num2str(FPR_BC*100),'%.'])
disp(['The BC FNR is ',num2str(FNR_BC*100),'%.'])
disp(['The BB FPR is ',num2str(FPR_BB*100),'%.'])
disp(['The BB FNR is ',num2str(FNR_BB*100),'%.'])