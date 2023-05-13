addpath(genpath(pwd))

winle = 0.015;
stple = winle/3*2;


[BreathTrain_freq, BreathTrain_time] = estrai_da_percorso('/sfiles/BreathingTrain','ogg',winle,stple);
[SneezeTrain_freq, SneezeTrain_time] = estrai_da_percorso('/sfiles/SneezingTrain','ogg',winle,stple);
[SnoreTrain_freq, SnoreTrain_time] = estrai_da_percorso('/sfiles/BreathingTrain','ogg',winle,stple);

b = zeros(1,length(BreathTrain_freq));
Sz = ones(1, length(SneezeTrain_freq));
Sr = ones(1, length(SnoreTrain_freq))+ones(1,length(SnoreTrain_freq));



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

[coeff, score, latent, tsquared, explained] = pca(allfeaturesNorm);

C=[repmat([1 0.2 0],length(BreathTrain_all),1); repmat([1 0 0.5],length(SneezeTrain_all),1); repmat([0 0 1], length(SnoreTrain_all),1)];


