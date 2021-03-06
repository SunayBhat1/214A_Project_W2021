function [threshold,ScoreData] = trainClassifier(trainList,featureDict)
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
fid = fopen(trainList);
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

    if(mod(i,1000)==0)
        disp(['Completed ',num2str(i),' of ',num2str(length(labels)),' files.']);
    end

end

% Mal Distance Distibutions
threshold.mu0 = mean(ScoreData(labels==0,:));
threshold.std0 = std(ScoreData(labels==0,:));
threshold.mu1 = mean(ScoreData(labels==1,:));
threshold.std1 = std(ScoreData(labels==1,:));
threshold.mus = mean(ScoreData);


% % K-means Supervised Training
% [idx,C0] = kmeans(ScoreData(labels==0,:),1);
% [idx,C1] = kmeans(ScoreData(labels==1,:),1);
% 
% mu = zeros(1,15);
% sigma = zeros(1,15);
% for i = 1:15
%     [mu(i),sigma(i)] = normfit(ScoreData(:,i));
% end
% 
% threshold.C0 = (C0 - mu)./sigma;
% threshold.C1 = (C1 - mu)./sigma;

% % Sum Diff and Scores;
% scores = sum(ScoreData,2);
% scores = -(scores-min(scores))/mean(scores);
% 
% [eer,threshold] = compute_eer(scores,labels);


end % function [threshold] = trainClassifier(trainList)