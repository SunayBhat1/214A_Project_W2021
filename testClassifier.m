function [FPR,FNR,ScoreData] = testClassifier(testList,featureDict,threshold)
% trainClassifier - train classifier against any combo of features with
%                   weights
% Syntax:  threshold = trainClassifier(trainList,featureDict,featVect,weigthVect)
%
% Inputs:
%    trainList - 
%    featureDict - 
%    featVect - 
%    weigthVect - 
%
% Outputs:
%    threshold - 
% 
% Features:
%   1: LPC Mean
%   2: Weighted Spectrogram
%   3: Weighted Mel Spectrogram
%------------- BEGIN CODE --------------


% Open Training Files
fid = fopen(testList);
myData = textscan(fid,'%s %s %f');
fclose(fid);
fileList1 = myData{1};
fileList2 = myData{2};
labels = myData{3};

% Init Scores
ScoreData = zeros(length(labels),15);

% MFCC_F0  
for i = 1:length(labels)
    for idt = 1:15
        ScoreData(i,idt) = dtw(featureDict(fileList1{i}).MFCC_F0(:,idt),featureDict(fileList2{i}).MFCC_F0(:,idt));
    end

    if(mod(i,100)==0)
        disp(['Completed ',num2str(i),' of ',num2str(length(labels)),' files.']);
    end

end

% Mal Distance
meanOffset = mean(ScoreData) - threshold.mus;
mu0Offset = threshold.mu0 + meanOffset;
mu1Offset = threshold.mu1 + meanOffset;

Dist_0 =  zeros(15,1000);
Dist_1 =  zeros(15,1000);
for i=1:15
    Dist_0(i,:) = normrnd(mu0Offset(i),threshold.std0(i),1,1000);
    Dist_1(i,:) = normrnd(mu1Offset(i),threshold.std1(i),1,1000);
end

M0 = mahal(ScoreData,Dist_0');
M1 = mahal(ScoreData,Dist_1');

prediction = M0 > M1;
    

% % Sum Diff and Scores;
% scores = sum(ScoreData,2);
% scores = -(scores-min(scores))/mean(scores);
% prediction = (scores>threshold);
% 
% figure; hold on; grid on;
% histogram(scores(find(labels== 0)));
% histogram(scores(find(labels== 1)));
% xline(threshold,'--r','Threshold','linewidth',3);

% % K-means
% mu = zeros(1,15);
% sigma = zeros(1,15);
% 
% for i = 1:15
%     [mu(i),sigma(i)] = normfit(ScoreData(:,i));
% end
% 
% C0 = threshold.C0 .* sigma + mu;
% C1 = threshold.C1 .* sigma + mu;
% 
% prediction = logical(sign(vecnorm(ScoreData - C0,2,2) - vecnorm(ScoreData - C1,2,2)) + 1);


% Error Rates
FPR = sum(~labels & prediction)/sum(~labels)
FNR = sum(labels & ~prediction)/sum(labels)

end % function threshold = testClassifier(testList)