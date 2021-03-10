function voicedSpeech = isVoicedSpeech(x,fs,windowLength,overlapLength)
% isVoicedSpeech - determine voiced sections of speech verctor
% Syntax:  voicedSpeech = isVoicedSpeech(x,fs,windowLength,overlapLength)
%
%   Source: https://www.mathworks.com/help/audio/ug/speaker-identification-using-pitch-and-mfcc.html
%    
%------------- BEGIN CODE --------------

% Utilize Zero Corssing Rate to determine voiced section of speech 
% (see source in header)
pwrThreshold = -40;
[segments,~] = buffer(x,windowLength,overlapLength,'nodelay');
pwr = pow2db(var(segments));
isSpeech = (pwr > pwrThreshold);

zcrThreshold = 1000;
zeroLoc = (x==0);
crossedZero = logical([0;diff(sign(x))]);
crossedZero(zeroLoc) = false;
[crossedZeroBuffered,~] = buffer(crossedZero,windowLength,overlapLength,'nodelay');
zcr = (sum(crossedZeroBuffered,1)*fs)/(2*windowLength);
isVoiced = (zcr < zcrThreshold);

voicedSpeech = isSpeech & isVoiced;

end % function voicedSpeech = isVoicedSpeech(x,fs,windowLength,overlapLength)