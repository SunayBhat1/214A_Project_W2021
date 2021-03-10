function [threshold,ScoreData] = trainClassifier(trainList)
% trainClassifier - train classifier against any combo of features with
%                   weights
% Syntax:  threshold = trainClassifier(trainList,featureDict,featVect,weigthVect)
%
% Inputs:
%    trainList - 
%    featureDict - 
%
% Outputs:
%    threshold - 
% 
%------------- BEGIN CODE --------------


% Open Training Files
fid = fopen(trainList);
myData = textscan(fid,'%s %s %f');
fclose(fid);
fileList1 = myData{1};
fileList2 = myData{2};
labels = myData{3};

% Init Scores Matrix
ScoreData = zeros(length(labels),10);

% MFCC_F0  
for i = 1:length(labels)
    
    % Extract Features for each file
    Feat_1 = extractFeatures(fileList1{i});
    Feat_2 = extractFeatures(fileList2{i});
    
    for idt = 1:15
        ScoreData(i,idt) = dtw(Feat_1(:,idt),Feat_2(:,idt));
    end

    if(mod(i,1000)==0)
        disp(['Completed ',num2str(i),' of ',num2str(length(labels)),' files.']);
    end

end

% Mahal Distance Distibutions
threshold.mu0 = mean(ScoreData(labels==0,:));
threshold.std0 = std(ScoreData(labels==0,:));
threshold.mu1 = mean(ScoreData(labels==1,:));
threshold.std1 = std(ScoreData(labels==1,:));
threshold.mus = mean(ScoreData);


end % function [threshold] = trainClassifier(trainList)