function prediction = testClassifier(testList,threshold)
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
%------------- BEGIN CODE --------------


% Open Training Text File
fid = fopen(testList);
myData = textscan(fid,'%s %s %f');
fclose(fid);
fileList1 = myData{1};
fileList2 = myData{2};

% Init Scores Matrix
ScoreData = zeros(length(myData{1}),15);

% MFCC_F0 DTW
for i = 1:length(myData{1})
    
    % Extract Features for each file
    Feat_1 = extractFeatures(fileList1{i});
    Feat_2 = extractFeatures(fileList2{i});
    
    % Loop through and determine Dynamic Time Warping Euclidean Distance on
    % a per featurs basis
    for idt = 1:15
        ScoreData(i,idt) = dtw(Feat_1(:,idt),Feat_2(:,idt));
    end

    % Loop Counter
    if(mod(i,100)==0)
        disp(['Completed ',num2str(i),' of ',num2str(length(myData{1})),' files.']);
    end

end

% Determine mean offset from test and train set
meanOffset = mean(ScoreData) - threshold.mus;

% Offset means for test data
mu0Offset = threshold.mu0 + meanOffset;
mu1Offset = threshold.mu1 + meanOffset;

% Generate normal random distirbutions for same and different scores from
% threshold
Dist_0 =  zeros(15,1000);
Dist_1 =  zeros(15,1000);
for i=1:15
    Dist_0(i,:) = normrnd(mu0Offset(i),threshold.std0(i),1,1000);
    Dist_1(i,:) = normrnd(mu1Offset(i),threshold.std1(i),1,1000);
end

% Calculate Mahalanobis distance from each distribution
M0 = mahal(ScoreData,Dist_0');
M1 = mahal(ScoreData,Dist_1');

% Predict base don closer distribution
prediction = M0 > M1;

end % function threshold = testClassifier(testList)