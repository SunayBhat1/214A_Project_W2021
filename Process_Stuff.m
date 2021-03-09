% DTW MFCC
dtw1_2 = [];
dtw2_3 = [];
dtw1_3 = [];

for i = 1:15
  dtw1_2 = [dtw1_2 dtw(feat(:,i),feat2(:,i))];
  dtw2_3 = [dtw2_3 dtw(feat2(:,i),feat3(:,i))];
  dtw1_3 = [dtw1_3 dtw(feat(:,i),feat3(:,i))];
end


figure; hold on;
plot(dtw1_2)
plot(dtw1_3)
plot(dtw2_3)

sum(dtw1_2)
sum(dtw1_3)
sum(dtw2_3)