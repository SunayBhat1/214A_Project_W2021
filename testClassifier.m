function [TotalError, FPR, FNR] = testClassifier(testList,featureDict,threshold)


% Test the classifier
fid = fopen(testList);
myData = textscan(fid,'%s %s %f');
fclose(fid);
fileList1 = myData{1};
fileList2 = myData{2};
labels = myData{3};
scores = zeros(length(labels),1);
for(i = 1:length(labels))
    scores(i) = -ssim(featureDict(fileList1{i}),featureDict(fileList2{i}));
end
prediction = (scores>threshold);
FPR = sum(~labels & prediction)/sum(~labels);
FNR = sum(labels & ~prediction)/sum(labels);
TotalError = sum(xor(labels,prediction))/size(labels,1);



end % function threshold = testClassifier(testList)