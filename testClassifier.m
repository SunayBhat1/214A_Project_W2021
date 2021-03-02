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

% MFCC_F0  
for i = 1:length(labels)
    dtwVec = [];
    for idt = 1:15
        dtwVec = [dtwVec dtw(featureDict(fileList1{i}).MFCC_F0(:,idt),featureDict(fileList2{i}).MFCC_F0(:,idt))];
    end
    scores(i) = -sum(dtwVec);

    if(mod(i,100)==0)
        disp(['Completed ',num2str(i),' of ',num2str(length(labels)),' files.']);
    end

end

scores = -(scores-max(scores))/min(scores);

figure; hold on; grid on;
histogram(scores(find(labels== 0)));
histogram(scores(find(labels== 1)));
xline(threshold,'--r','Threshold','linewidth',3);

% Error Rates
prediction = (scores>threshold);
FPR = sum(~labels & prediction)/sum(~labels);
FNR = sum(labels & ~prediction)/sum(labels);
TotalError = sum(xor(labels,prediction))/size(labels,1);

end % function threshold = testClassifier(testList)