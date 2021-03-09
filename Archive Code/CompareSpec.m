figure; hold on; grid on;
plot([TotalError_CC, FPR_CC, FNR_CC],'r','LineWidth',3')
for i = 1:size(Results_SSIM,2)
    plot(Results_SSIM(i).Data(1:3))
end

xlabel('Hamm Error, FPR, FNR','FontWeight','bold','FontSize',13);
ylabel('% Error','FontWeight','bold','FontSize',13);
title('Weigthed Spectrogram SSIM Error Comparisons','FontWeight','bold','FontSize',18);


figure; hold on; grid on;
plot([TotalError_CC, FPR_CC, FNR_CC],'r','LineWidth',3')
for i = 1:size(Results,2)
    plot(Results(i).Data(1:3))
end

xlabel('Hamm Error, FPR, FNR','FontWeight','bold','FontSize',13);
ylabel('% Error','FontWeight','bold','FontSize',13);
title('Weigthed Spectrogram MSE Error Comparisons','FontWeight','bold','FontSize',18);
