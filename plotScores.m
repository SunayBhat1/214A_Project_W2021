function [eer1,eer2] = plotScores(featureDict)
%plotScores - test script to visualize score for a given feature
%------------- BEGIN CODE --------------
tic;
warning off;
%% Clean
trainList = 'trainCleanList.txt';
fid = fopen(trainList);
myData = textscan(fid,'%s %s %f');
fclose(fid);
fileList1 = myData{1};
fileList2 = myData{2};
labels = myData{3};
scores = zeros(length(labels),1);

for i = 1:length(labels)
%     
    % ZCR Diff
    scores(i) = -abs(featureDict(fileList1{i}).ZCR - featureDict(fileList2{i}).ZCR);
%     
%     % FO autocorr
%     F0Corr = xcorr(featureDict(fileList1{i}).F0vec,featureDict(fileList1{2}).F0vec);
%     scores(i) = sum(F0Corr(ceil(size(F0Corr,1)/4):ceil(3*size(F0Corr,1)/4)) .^2);
%     
%     % Full autocorr windowed middle squared
%     autoCorr = xcorr(featureDict(fileList1{i}).snd,featureDict(fileList1{2}).snd);
%     scores(i) = max(autoCorr);
%     scores(i) = sum(autoCorr(ceil(size(autoCorr,1)/4):ceil(3*size(autoCorr,1)/4)) .^2);

%     % Conv Images ssim 
%     image1 = featureDict(fileList1{i}).MFCC_F0;
%     image2 = featureDict(fileList2{i}).MFCC_F0;
%     convIm = conv2(image1,image2);
%     if  size(image1,1) > size(image2,1)
%         medfiltconv = medfilt2(abs(convIm),size(image2));
%     elseif size(image2,1) > size(image1,1)
%         medfiltconv = medfilt2(abs(convIm),size(image1));
%     end
%     
    
%     scores(i) = -max(medfiltconv(:));
    
    

%     % Weighted Spec
%     
%     scores(i) = -immse(featureDict(fileList1{i}).MFCC_F0,featureDict(fileList2{i}).MFCC_F0);
%     
%     % fast MSBC
%     scores(i) = abs(featureDict(fileList1{i}).meanF0 - featureDict(fileList2{i}).meanF0);

    if(mod(i,100)==0)
        disp(['Completed ',num2str(i),' of ',num2str(length(labels)),' files.']);
    end

end

[eer1,threshold] = compute_eer(scores, labels,1,'Clean');
figure; hold on; grid on;
histogram(scores(find(labels== 0)));
histogram(scores(find(labels== 1)));
xline(threshold,'--r','Threshold','linewidth',3);
legend('Different','Same','Threshold');
xlabel('Score Value','FontWeight','bold','FontSize',13);
ylabel('n','FontWeight','bold','FontSize',13);
title('Clean Train Score Distributions','FontWeight','bold','FontSize',18);

%% Multi
trainList = 'trainMultiList.txt';
fid = fopen(trainList);
myData = textscan(fid,'%s %s %f');
fclose(fid);
fileList1 = myData{1};
fileList2 = myData{2};
labels = myData{3};
scores = zeros(length(labels),1);

for i = 1:length(labels)
    
    % ZCR Diff
    scores(i) = -abs(featureDict(fileList1{i}).ZCR - featureDict(fileList2{i}).ZCR);
% 
%     % Weighted Spec
%     scores(i) = -immse(featureDict(fileList1{i}).MFCC_F0,featureDict(fileList2{i}).MFCC_F0);

%     % Conv Images ssim 
%     image1 = featureDict(fileList1{i}).MFCC_F0;
%     image2 = featureDict(fileList2{i}).MFCC_F0;
%     convIm = conv2(image1,image2);
%     if  size(image1,1) > size(image2,1)
%         medfiltconv = medfilt2(abs(convIm),size(image2,1));
%     elseif size(image2,1) > size(image1,1)
%         medfiltconv = medfilt2(abs(convIm),size(image1,1));
%     end
%     
% 
%     scores(i) = -max(medfiltconv(:));
    
    
    if(mod(i,100)==0)
        disp(['Completed ',num2str(i),' of ',num2str(length(labels)),' files.']);
    end
%     
    % FO autocorr
%     F0Corr = xcorr(featureDict(fileList1{i}).F0vec,featureDict(fileList1{2}).F0vec);
%     scores(i) = -sum(F0Corr(ceil(size(F0Corr,1)/4):ceil(3*size(F0Corr,1)/4)) .^2);

%     % Full autocorr windowed middle squared
%     autoCorr = xcorr(featureDict(fileList1{i}).snd,featureDict(fileList1{2}).snd);
%     scores(i) = max(autoCorr);
%     scores(i) = sum(autoCorr(ceil(size(autoCorr,1)/4):ceil(3*size(autoCorr,1)/4)) .^2);
%     
%     % fast MSBC
%     scores(i) = abs(featureDict(fileList1{i}).meanF0 - featureDict(fileList2{i}).meanF0);

end

[eer2,threshold] = compute_eer(scores, labels,1,'Multi');
figure; hold on; grid on;
histogram(scores(find(labels== 0)));
histogram(scores(find(labels== 1)));
xline(threshold,'--r','Threshold','linewidth',3);
legend('Different','Same');
xlabel('Score Value','FontWeight','bold','FontSize',13);
ylabel('n','FontWeight','bold','FontSize',13);
title('Multi Train Score Distributions','FontWeight','bold','FontSize',18);


%%
toc
end