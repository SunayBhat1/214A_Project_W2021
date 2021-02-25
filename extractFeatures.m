function featureDict = extractFeatures(featVect,hyperParms)
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
%   3: 
%------------- BEGIN CODE --------------

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
    
    % Baseline mean F0 (like is >0.45
    if featVect(1)
        [F0,lik] = fast_mbsc_fixedWinlen_tracking(snd,fs);
        features.meanF0 = mean(F0(lik>0.45));
    end
    
    % Weighted Spectrogram
    if featVect(2)
        if isfield(hyperParms, 'SpecWindow')
            SpecWindow = hyperParms.SpecWindow;
        else
            SpecWindow = 320;
        end
        
        [s] = spectrogram(snd,SpecWindow);
        s = abs(s);
        labeledImage = bwlabel(true(size(s)));
        props = regionprops(labeledImage, s, 'Centroid', 'WeightedCentroid');
        Centroid = abs(props.WeightedCentroid);
        features.weightedSpec = s(1:60,fix(Centroid(2)-12):fix(Centroid(2)+12));
    end
    
    % Save features stuctures in dictionary
    featureDict(myFiles{i}) = features;

    if(mod(i,10)==0)
        disp(['Completed ',num2str(i),' of ',num2str(length(myFiles)),' files.']);
    end
    
end % for i = 1:length(myFiles)

end % function featureDict = extractFeatures(featVect,hyperParms)