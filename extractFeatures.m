function featureMatrx = extractFeatures(filename)
%extractFeatures - extract MFCC coefficients and F0
% Syntax:  featureDict = extractFeatures(filename)
%
% Inputs: filename - Path/name of  audio file
%
% Outputs:
%    featureMatrx - Feature Matrix
% 
% Other .m files needed:
%    isVoicedSpeech.m - determine voiced sections of speech
%
%   Source: https://www.mathworks.com/help/audio/ug/speaker-identification-using-pitch-and-mfcc.html
%    
%------------- BEGIN CODE --------------


[snd,fs] = audioread(strrep(filename,'\','/'));

%%% MATLAB MFCC + F0 (See Source in header)
windowLength = round(0.03*fs);
overlapLength = round(0.025*fs);
[melC] = mfcc(snd,fs,'Window',hamming(windowLength,'periodic'),'OverlapLength',overlapLength);
f0 = pitch(snd,fs,'WindowLength',windowLength,'OverlapLength',overlapLength);
featureMatrx = [melC f0];
voicedSpeech = isVoicedSpeech(snd,fs,windowLength,overlapLength);
featureMatrx(~voicedSpeech,:) = [];
M = mean(featureMatrx,1);
S = std(featureMatrx,[],1);
featureMatrx = (featureMatrx-M)./S;


end % function featureMatrx = extractFeatures(filename)