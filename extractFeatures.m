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

    
    %%% 1: Baseline mean F0 (lik is >0.45)
    if featVect(1)
        [F0,lik] = fast_mbsc_fixedWinlen_tracking(snd,fs);
        features.meanF0 = mean(F0(lik>0.45));
    end
    
    %%% 6: MATLAB MFCC + F0
    if featVect(2)
        windowLength = round(0.03*fs);
        overlapLength = round(0.025*fs);
        melC = mfcc(snd,fs,'Window',hamming(windowLength,'periodic'),'OverlapLength',overlapLength);
        f0 = pitch(snd,fs,'WindowLength',windowLength,'OverlapLength',overlapLength);
        feat = [melC,f0];
        voicedSpeech = isVoicedSpeech(snd,fs,windowLength,overlapLength);
        feat(~voicedSpeech,:) = [];
        M = mean(feat,1);
        S = std(feat,[],1);
        features.MFCC_F0 = (feat-M)./S;
    end
    
    %%% 2: Weighted Spectrogram
    if featVect(3)
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
    
    %%% 4: Mel Spectrogram
    if featVect(4)
        if isfield(hyperParms, 'MelNumBands')
            MelNumBands = hyperParms.MelNumBands;
        else
            MelNumBands = 200;
        end
        
        ZCRconv1 = conv(abs(diff(sign(snd))),ones(100,1));
        snd_ZCRfilt = snd(ZCRconv1(50:end-49)>5);
        
        [s] = melSpectrogram(snd_ZCRfilt,8000,'Window',hann(512,'periodic'),'OverlapLength',256,'FFTLength',4096,'NumBands',MelNumBands);
        features.MelSpec = s(1:150,ceil(size(s,2)/2-9):ceil(size(s,2)/2+9));
        
    end
    
    %%% 5: ZCR Mean
    if featVect(5)
        features.ZCR = mean(abs(diff(sign(snd))));
    end
    
    % Save features stuctures in dictionary
    featureDict(myFiles{i}) = features;

    if(mod(i,10)==0)
        disp(['Completed ',num2str(i),' of ',num2str(length(myFiles)),' files.']);
    end
    
end % for i = 1:length(myFiles)

toc

end % function featureDict = extractFeatures(featVect,hyperParms)