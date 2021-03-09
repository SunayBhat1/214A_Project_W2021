function featureDict = extractFeatures()
%extractFeatures - extract and combo of listed features based on inputs
% Syntax:  featureDict = extractFeatures(featVect,hyperParms)
%
% Inputs:
%    featVect - Binary vector that corresponds to the features to extract.
%       See feature list below.
%    hyperParms - Optional Structure that contains any hperparms needed for
%       various feature extraction. See list below.
%
% Outputs:
%    featureDict - Description
% 
% Features:
%   1: LPC Mean
%   2: Weighted Spectrogram
%         |HyperParms:
%           -SpecWindow (Window size of spectrogram)
%   3: Weighted Mel Spectrogram
%         |HyperParms:
%           -SpecWindowMel (Window size of spectrogram)
%------------- BEGIN CODE --------------
tic;

allFiles = 'allList.txt';

% Init feature dictionary variable
featureDict = containers.Map;

% Read in files list
fid = fopen(allFiles);
myData = textscan(fid,'%s');
fclose(fid);
myFiles = myData{1};


% Loop through files
for i = 1:length(myFiles)
    [snd,fs] = audioread(strrep(myFiles{i},'\','/'));
    
    %%% MATLAB MFCC + F0
    windowLength = round(0.03*fs);
    overlapLength = round(0.025*fs);
    [melC delta deltadelta] = mfcc(snd,fs,'Window',hamming(windowLength,'periodic'),'OverlapLength',overlapLength);
    f0 = pitch(snd,fs,'WindowLength',windowLength,'OverlapLength',overlapLength);
    feat = [melC f0];
    voicedSpeech = isVoicedSpeech(snd,fs,windowLength,overlapLength);
    feat(~voicedSpeech,:) = [];
    M = mean(feat,1);
    S = std(feat,[],1);
    feat = (feat-M)./S;
    features.MFCC_F0 = feat;
    
    % Save features stuctures in dictionary
    featureDict(myFiles{i}) = features;

    if(mod(i,10)==0)
        disp(['Completed ',num2str(i),' of ',num2str(length(myFiles)),' files.']);
    end
    
end % for i = 1:length(myFiles)

toc

end % function featureDict = extractFeatures(featVect,hyperParms)