figure; hold on; grid on;
plot(min(ScoreDataT),'linewidth',2);
plot(max(ScoreDataT),'linewidth',2)
plot(threshold.C0);
plot(threshold.C1);

xlabel('Distance of Feature','FontWeight','bold','FontSize',13);
ylabel('Value','FontWeight','bold','FontSize',13);
title({'Centroid Locations vs Min/Max','Clean Train Data'},'FontWeight','bold','FontSize',18);
legend('Min Clean Train','Max Clean Train','C0','C1');

figure; hold on; grid on;
plot(min(ScoreData),'linewidth',2);
plot(max(ScoreData),'linewidth',2)
plot(threshold.C0);
plot(threshold.C1);

xlabel('Distance of Feature','FontWeight','bold','FontSize',13);
ylabel('Value','FontWeight','bold','FontSize',13);
title({'Centroid Locations vs Min/Max','Babble Test Data Unscaled'},'FontWeight','bold','FontSize',18);
legend('Min Babble Test','Max Babble Test','C0','C1');

[~,C0] = kmeans(ScoreDataT(labels==0,:),1);
[~,C1] = kmeans(ScoreDataT(labels==1,:),1);

mu = zeros(1,15);
sigma = zeros(1,15);
for i = 1:15
    [mu(i),sigma(i)] = normfit(ScoreDataT(:,i));
end

threshold.C0 = (C0 - mu)./sigma;
threshold.C1 = (C1 - mu)./sigma;

mu = zeros(1,15);
sigma = zeros(1,15);

for i = 1:15
    [mu(i),sigma(i)] = normfit(ScoreData(:,i));
end

C0 = threshold.C0 .* sigma + mu;
C1 = threshold.C1 .* sigma + mu;

figure; hold on; grid on;
plot(min(ScoreData),'linewidth',2);
plot(max(ScoreData),'linewidth',2)
plot(C0);
plot(C1);

xlabel('Distance of Feature','FontWeight','bold','FontSize',13);
ylabel('Value','FontWeight','bold','FontSize',13);
title({'Centroid Locations vs Min/Max','Babble Test Data **Scaled**'},'FontWeight','bold','FontSize',18);
legend('Min Babble Test','Max Babble Test','C0 Scaled','C1 Scaled');

figure; hold on; grid on;
histogram(ScoreDataT(:,1));
title({'Clean Train','1st Cepstral Coeff Distirbution'},'FontWeight','bold','FontSize',20);
xlim([0 300])

figure; hold on; grid on;
histogram(ScoreData(:,1));
title({'Babble Test','1st Cepstral Coeff Distirbution'},'FontWeight','bold','FontSize',20);
