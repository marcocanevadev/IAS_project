        %---- Perform kNN with best group for different winsizes ----

clear;clc;        
wins = [0.015, 0.03, 0.05, 0.1, 0.5];
rates = zeros(1,length(wins));

for i = 1:length(wins)
    disp(['setting up... winlen = ', mat2str(wins(i)*1000),'ms'])
    win = wins(i);
    stp = win/3*2;
    [BreathTrain_freq, BreathTrain_time] = estrai_da_percorso('/sfiles/BreathingTrain','ogg',win,stp);
    [SneezeTrain_freq, SneezeTrain_time] = estrai_da_percorso('/sfiles/SneezingTrain','ogg',win,stp);
    [SnoreTrain_freq, SnoreTrain_time] = estrai_da_percorso('/sfiles/SnoringTrain','ogg',win,stp);

    [BreathTest_freq, BreathTest_time] = estrai_da_percorso('/sfiles/BreathingTest','ogg',win,stp);
    [SneezeTest_freq, SneezeTest_time] = estrai_da_percorso('/sfiles/SneezingTest','ogg',win,stp);
    [SnoreTest_freq, SnoreTest_time] = estrai_da_percorso('/sfiles/SnoringTest','ogg',win,stp);


    flagB = zeros(1,length(BreathTrain_freq));
    flagSz = ones(1, length(SneezeTrain_freq));
    flagSr = ones(1, length(SnoreTrain_freq))+ones(1,length(SnoreTrain_freq));

    flagTr = [flagB flagSz flagSr];


    BreathTrain_all = BreathTrain_freq;
    BreathTrain_all(19:21,:) = BreathTrain_time;
    SneezeTrain_all = SneezeTrain_freq;
    SneezeTrain_all(19:21,:) = SneezeTrain_time;
    SnoreTrain_all = SnoreTrain_freq;
    SnoreTrain_all(19:21,:) = SnoreTrain_time;


    allfeatures = [BreathTrain_all SneezeTrain_all SnoreTrain_all];
    allfeatures = allfeatures';

    allfeatures(isnan(allfeatures))=0;

    mn = mean(allfeatures);
    stdev = std(allfeatures);

    allfeaturesNorm = (allfeatures - repmat(mn,size(allfeatures,1),1))./repmat(stdev,size(allfeatures,1),1);


            %---- Ground Truth Flags ----

    flagBTest = zeros(1,length(BreathTest_freq));
    flagSzTest = ones(1, length(SneezeTest_freq));
    flagSrTest = ones(1, length(SnoreTest_freq))+ones(1,length(SnoreTest_freq));

    ground_Truth = [flagBTest flagSzTest flagSrTest];

            %---- Concatenate Features ----

    BreathTest_all = BreathTest_freq;
    BreathTest_all(19:21,:) = BreathTest_time;
    SneezeTest_all = SneezeTest_freq;
    SneezeTest_all(19:21,:) = SneezeTest_time;
    SnoreTest_all = SnoreTest_freq;
    SnoreTest_all(19:21,:) = SnoreTest_time;


    allfeaturesTest = [BreathTest_all SneezeTest_all SnoreTest_all];
    allfeaturesTest = allfeaturesTest';

    %---- Normalization ----

    allfeaturesTest(isnan(allfeatures))=0;

    mnT = mean(allfeaturesTest);
    stdevT = std(allfeaturesTest);

    allfeaturesTestNorm = (allfeaturesTest - repmat(mn,size(allfeaturesTest,1),1))./repmat(stdev,size(allfeaturesTest,1),1);
    

    group_c_allTR = allfeaturesNorm;
    group_c_allTE = allfeaturesTestNorm;
    k = [100];
    disp(['Setting up kNN for all domains Feats.'])
    [pred_all,rate_all] = kappaNN(k,group_c_allTR,flagTr,group_c_allTE,ground_Truth);
    mrate = max(rate_all);
    rates(i) = mrate
   
    disp(['-------------']);

end
figure(4)
plot(rates)
xticks(wins)
hold on
stem(rates)
ylim([50,60])
xlabel('winlen')
ylabel('recognition rate')
legend('all','')
title('winlength optimization')

[mx, ind] = max(rates);
disp(['best winlength: ',mat2str(wins(ind)),' with a recognition rate of: ',mat2str(mx),'%'])


