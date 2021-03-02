function [TotalError,FPR,FNR] = testClassifier(testList,featureDict,threshold,featVect,weigthVect)
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
scores = zeros(length(labels),1);

%%% 1: Baseline mean F0 (lik is >0.45)
if featVect(1)
    scores1 = zeros(length(labels),1);
    
    for i = 1:length(labels)
        scores1(i) = -abs(featureDict(fileList1{i}).meanF0-featureDict(fileList2{i}).meanF0) * weigthVect(1);
    end
    scores = scores + scores1;
end


%%% 2: Weighted Spectrogram
if featVect(2)
    scores2 = zeros(length(labels),1);
    
    for(i = 1:length(labels))
        scores2(i) = -ssim(featureDict(fileList1{i}).weightedSpec,featureDict(fileList2{i}).weightedSpec) * weigthVect(2);
    end
    scores = scores + scores2;
end

%%% 3: ZCR
if featVect(3)
    scores3 = zeros(length(labels),1);
    
    for(i = 1:length(labels))
        scores3(i) = -abs(featureDict(fileList1{i}).ZCR - featureDict(fileList2{i}).ZCR) * weigthVect(3);
    end
    scores = scores + scores3;
end

plot(scores)

% Error Rates
prediction = (scores>threshold);
FPR = sum(~labels & prediction)/sum(~labels);
FNR = sum(labels & ~prediction)/sum(labels);
TotalError = sum(xor(labels,prediction))/size(labels,1);

end % function threshold = testClassifier(testList)