        %---- Perform kNN Classification on three Groups of features ----

        %---- Divide in Three Groups ----
group_a_timeTR = allfeaturesNorm(:,19:21);
group_b_freqTR = allfeaturesNorm(:,1:18);
group_c_allTR = allfeaturesNorm;

group_a_timeTE = allfeaturesTestNorm(:,19:21);
group_b_freqTE = allfeaturesTestNorm(:,1:18);
group_c_allTE = allfeaturesTestNorm;

k = [1,2,3,5,7,10,15,20,50,75,100,250];
disp(['Setting up kNN for Time domain Feats.'])
[pred_time,rate_time] = kappaNN(k,group_a_timeTR,flagTr,group_a_timeTE,ground_Truth);
disp(['Setting up kNN for Freq domain Feats.'])
[pred_freq,rate_freq] = kappaNN(k,group_b_freqTR,flagTr,group_b_freqTE,ground_Truth);
disp(['Setting up kNN for all domains Feats.'])
[pred_all,rate_all] = kappaNN(k,group_c_allTR,flagTr,group_c_allTE,ground_Truth);
   

plot(k,rate_all,'Color','red')
hold on
stem(k,rate_all,'--diamondr')

plot(k,rate_freq,'Color','green')
hold on
stem(k,rate_freq,'--diamondg')

plot(k,rate_time,'Color','blue')
hold on
stem(k,rate_time,'--diamondb')
ylim([38,55])
xlabel('k')
ylabel('recognition rate')
legend('all','','freq','','time','')
title('kNN recog rate comparison')
