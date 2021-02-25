function threshold = trainClassifier(trainList,featureDict)

% Train the classifier
fid = fopen(trainList);
myData = textscan(fid,'%s %s %f');
fclose(fid);
fileList1 = myData{1};
fileList2 = myData{2};
labels = myData{3};
scores = zeros(length(labels),1);
for(i = 1:length(labels))
    scores(i) = -immse(featureDict(fileList1{i}),featureDict(fileList2{i}));
end
[~,threshold] = compute_eer(scores,labels);

end % function [threshold] = trainClassifier(trainList)