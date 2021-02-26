function [eer1,eer2] = plotScores_fastMSBC(featureDict)
%plotScores - test script to visualize score for a given feature
%------------- BEGIN CODE --------------

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
    scores(i) = abs(featureDict(fileList1{i}).meanF0 - featureDict(fileList2{i}).meanF0);
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
    scores(i) = abs(featureDict(fileList1{i}).meanF0 - featureDict(fileList2{i}).meanF0);
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

end