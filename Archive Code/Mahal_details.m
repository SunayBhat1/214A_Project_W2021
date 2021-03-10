figure; hold on; grid on;
histogram(ScoreDataT(labels==0,1));
histogram(ScoreDataT(labels==1,1));

xlabel('Value','FontWeight','bold','FontSize',13);
ylabel('N','FontWeight','bold','FontSize',13);
title({'Clean Train','1st Cepstral Coeff Distirbution'},'FontWeight','bold','FontSize',18);
legend('Different Speakers','Same Speakers');

disp(['Mean Different(1) :' num2str(threshold.mu0(1))])
disp(['StDev Different(1) :' num2str(threshold.std0(1))])
disp(['Mean Same(1) :' num2str(threshold.mu1(1))])
disp(['StDev Same(1) :' num2str(threshold.sta d1(1))])


figure; hold on; grid on;
histogram(Dist_0(1,:));
histogram(Dist_1(1,:));

xlabel('Distance Values','FontWeight','bold','FontSize',13);
ylabel('N','FontWeight','bold','FontSize',13);
title({'Generated Babble Test','1st Cepstral Coeff Distirbution'},'FontWeight','bold','FontSize',18);
legend('Different Speakers','Same Speakers');

figure; hold on; grid on;
scatter(Dist_0(1,:)',Dist_0(2,:)',10,'.') % Scatter plot with points of size 10
scatter(ScoreData(1:10,1),ScoreData(1:10,2),100,M0(1:10),'o','filled')
hb = colorbar;
ylabel(hb,'Mahalanobis Distance')
legend('Train Data Different','Test Data Sample','Location','best')
xlabel('Cepstral Coeff 1','FontWeight','bold','FontSize',13);
ylabel('Cepstral Coeff 2','FontWeight','bold','FontSize',13);
title('Visualize Sample of M-Dist (2 of 15-D)','FontWeight','bold','FontSize',18);