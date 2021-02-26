function [eer,threshold] = compute_eer(scores, labels,plotEER,plotName)
% Computes equal error rate

if nargin < 3
    plotEER = 0;
    plotName = '';
end

[sortScores,I] = sort(scores);
x = labels(I);

FNR = cumsum( x == 1 ) / (sum( x == 1 ) + eps);
TN = cumsum( x == 0 ) / (sum( x == 0 ) + eps);
FPR = 1 - TN;

difs = FNR - FPR;
idx1 = find(difs < 0, 1, 'last');
idx2 = find(difs >= 0, 1);
x = [FNR(idx1); FPR(idx1)];
y = [FNR(idx2); FPR(idx2)];
a = ( x(1) - x(2) ) / ( y(2) - x(2) - y(1) + x(1) );
eer = 100 * ( x(1) + a * ( y(1) - x(1) ) );
threshold = (sortScores(idx1)+sortScores(idx2))/2;

if plotEER
    figure; hold on; grid on;
    plot(FNR*100)
    plot(FPR*100)
    xlabel('Index','FontWeight','bold','FontSize',13);
    ylabel('% Error','FontWeight','bold','FontSize',13);
    title({[plotName ' FNR FPR Plot, EER = ' num2str(ceil(eer)) '%'],['Threshold = ' num2str(threshold)]},...
        'FontWeight','bold','FontSize',18);
    
end

end

