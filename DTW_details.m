
i = 300; idt =1;
figure; hold on; grid on;
x = featureDict(fileList1{i}).MFCC_F0(:,1);
y = featureDict(fileList2{i}).MFCC_F0(:,1);
plot(featureDict(fileList1{i}).MFCC_F0(:,1))
plot(featureDict(fileList2{i}).MFCC_F0(:,1))

xlabel('Sample','FontWeight','bold','FontSize',13);
ylabel('Value','FontWeight','bold','FontSize',13);
title('First Cepstral Coeff vs Sample','FontWeight','bold','FontSize',18);
legend(fileList1{i},fileList2{i});

dtw(featureDict(fileList1{i}).MFCC_F0(:,idt),featureDict(fileList2{i}).MFCC_F0(:,idt));
figure; hold on; grid on;
plot(x(iy))
plot(y(iy))

xlabel('Sample','FontWeight','bold','FontSize',13);
ylabel('Value','FontWeight','bold','FontSize',13);
title({'First Cepstral Coeff After DTW vs Sample',['Distance = ' num2str(dist)]},'FontWeight','bold','FontSize',18);
legend(fileList1{i},fileList2{i});
