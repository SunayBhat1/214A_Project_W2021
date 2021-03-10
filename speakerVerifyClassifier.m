function prediction = speakerVerifyClassifier(testList,trainList)
% speakerVerifyClassifier - function to test (and train) our speaker verififcation 
%   classifier for W2021 214A Project. 
%   By: Sunay Bhat and Pong Chan
% 
%   Syntax:  featureDict = speakerVerifyClassifier(testList)
%
% Inputs: 
%   testList - txt file containing list of test data
%   trainList - 'optional' text file containing list of train data
%       Note: Training takes significantly longer since code was modified to 
%       extract features per comparison and not intially on with an 
%       all files list
%
% Outputs:
%   prediction - Binary classification vector (0 - different, 1 - match)
% 
% Other files needed:
%   trainedParms.mat - Saved paramters from trained model
%   trainClassifier.m - Finction to train classifier
%   testClassifier.m - Function to test classifier with loaded parms or
%       trained thresholds
%   
%    
%------------- BEGIN CODE --------------

% Determine if training data file exists
trainFlag = ~(nargin == 1);

% Train or load paramters if no train file
if trainFlag
    disp('Training New Parameters and Testing...');
    threshold = trainClassifier(trainList);
else
    disp('Loading Parameters and Testing...');
    load('TrainedParms.mat');
end

% Test Clean
prediction = testClassifier(testList,threshold);


end