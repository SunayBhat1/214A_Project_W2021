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

    dtwVec = zeros(15,1);
    for idt = 1:15
        dtwVec(i) = dtw(featureDict(fileList1{i}).MFCC_F0(:,idt),featureDict(fileList2{i}).MFCC_F0(:,idt));
    end
    
    scores(i) = -sum(dtwVec);

    if(mod(i,1000)==0)
        disp(['Completed ',num2str(i),' of ',num2str(length(labels)),' files.']);
    end

end

scores = -(scores-max(scores))/min(scores);

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

    dtwVec = zeros(15,1);
    for idt = 1:15
        dtwVec(i) = dtw(featureDict(fileList1{i}).MFCC_F0(:,idt),featureDict(fileList2{i}).MFCC_F0(:,idt));
    end
    
    scores(i) = -sum(dtwVec);
    
    
    if(mod(i,1000)==0)
        disp(['Completed ',num2str(i),' of ',num2str(length(labels)),' files.']);
    end


end

scores = -(scores-max(scores))/min(scores);

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