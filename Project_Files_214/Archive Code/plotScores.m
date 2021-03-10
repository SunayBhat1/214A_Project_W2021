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

ScoreDataT = zeros(length(labels),15);

% MFCC_F0  
for i = 1:length(labels)
    for idt = 1:15
        ScoreDataT(i,idt) = dtw(featureDict(fileList1{i}).MFCC_F0(:,idt),featureDict(fileList2{i}).MFCC_F0(:,idt));
    end

    if(mod(i,1000)==0)
        disp(['Completed ',num2str(i),' of ',num2str(length(labels)),' files.']);
    end

end

scores = -sum(ScoreDataT,2);

[eer1,threshold] = compute_eer(scores, labelT,1,'Clean');
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

ScoreDataM = zeros(length(labels),15);

% MFCC_F0  
for i = 1:length(labels)
    for idt = 1:15
        ScoreDataM(i,idt) = dtw(featureDict(fileList1{i}).MFCC_F0(:,idt),featureDict(fileList2{i}).MFCC_F0(:,idt));
    end

    if(mod(i,1000)==0)
        disp(['Completed ',num2str(i),' of ',num2str(length(labels)),' files.']);
    end

end

scores = -sum(ScoreDataM,2);

[eer2,threshold] = compute_eer(scores, labelM,1,'Multi');
figure; hold on; grid on;
histogram(scores(find(labels== 0)));
histogram(scores(find(labels== 1)));
xline(threshold,'--r','Threshold','linewidth',3);
legend('Different','Same');
xlabel('Score Value','FontWeight','bold','FontSize',13);
ylabel('n','FontWeight','bold','FontSize',13);
title('Multi Train Score Distributions','FontWeight','bold','FontSize',18);

%% Babble
trainList = 'trainBabbleList.txt';
fid = fopen(trainList);
myData = textscan(fid,'%s %s %f');
fclose(fid);
fileList1 = myData{1};
fileList2 = myData{2};
labels = myData{3};
scores = zeros(length(labels),1);

ScoreDataB = zeros(length(labels),15);

% MFCC_F0  
for i = 1:length(labels)
    for idt = 1:15
        ScoreDataB(i,idt) = dtw(featureDict(fileList1{i}).MFCC_F0(:,idt),featureDict(fileList2{i}).MFCC_F0(:,idt));
    end

    if(mod(i,1000)==0)
        disp(['Completed ',num2str(i),' of ',num2str(length(labels)),' files.']);
    end

end

scores = -sum(ScoreDataB,2);

[eer2,threshold] = compute_eer(scores, labelB,1,'Babble');
figure; hold on; grid on;
histogram(scores(find(labels== 0)));
histogram(scores(find(labels== 1)));
xline(threshold,'--r','Threshold','linewidth',3);
legend('Different','Same');
xlabel('Score Value','FontWeight','bold','FontSize',13);
ylabel('n','FontWeight','bold','FontSize',13);
title('Babble Train Score Distributions','FontWeight','bold','FontSize',18);
%%
toc
end