clear all; clc;

allFiles = 'allList.txt';
 
tic
iR = 1;
for iSpecWindow = 200:5:320
    
    % Extract features
    featureDict = containers.Map;
    fid = fopen(allFiles);
    myData = textscan(fid,'%s');
    fclose(fid);
    myFiles = myData{1};
    for(i = 1:length(myFiles))
        [snd,fs] = audioread(strrep(myFiles{i},'\','/'));
        [s] = spectrogram(snd,iSpecWindow);
        s = abs(s);
        labeledImage = bwlabel(true(size(s)));
        props = regionprops(labeledImage, s, 'Centroid', 'WeightedCentroid');
        Centroid = abs(props.WeightedCentroid);
        featureDict(myFiles{i}) = s(1:60,fix(Centroid(2)-12):fix(Centroid(2)+12));
        if(mod(i,10)==0)
            disp(['Completed ',num2str(i),' of ',num2str(length(myFiles)),' files.']);
        end
    end

    % Train Clean, test Clean
    trainList = 'trainCleanList.txt';
    threshold = trainClassifier(trainList,featureDict);
    testList = 'testCleanList.txt';
    [TotalError_CC, FPR_CC, FNR_CC] = testClassifier(testList,featureDict,threshold);

    % Test Babble
    testList = 'testBabbleList.txt';
    [TotalError_CB, FPR_CB, FNR_CB] = testClassifier(testList,featureDict,threshold);

    % Train Multil, test clean
    trainList = 'trainMultiList.txt';
    threshold = trainClassifier(trainList,featureDict);
    testList = 'testCleanList.txt';
    [TotalError_MC, FPR_MC, FNR_MC] = testClassifier(testList,featureDict,threshold);

    % Test Babble
    testList = 'testBabbleList.txt';
    [TotalError_MB, FPR_MB, FNR_MB] = testClassifier(testList,featureDict,threshold);

    disp(['The CC false positive rate is ',num2str(FPR_CC*100),'%.'])
    disp(['The CC false negative rate is ',num2str(FNR_CC*100),'%.'])
    disp(['The CC Total Error is ',num2str(TotalError_CC*100),'%.'])


    Results(iR).Window = iSpecWindow;
    Results(iR).Data = [TotalError_CC, FPR_CC, FNR_CC, TotalError_CB, FPR_CB, FNR_CB, TotalError_MC, FPR_MC, FNR_MC,...
        TotalError_MB, FPR_MB, FNR_MB];

    iR = iR + 1;
    
end % for iSpecWindow = 200:5:320

toc