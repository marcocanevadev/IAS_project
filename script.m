addpath(genpath(pwd))

winle = 0.015;
stple = winle/3*2;


[BreathTrain_freq, BreathTrain_time] = estrai_da_percorso('/sfiles/BreathingTrain','ogg',winle,stple);
[SneezeTrain_freq, SneezeTrain_time] = estrai_da_percorso('/sfiles/SneezingTrain','ogg',winle,stple);
[SnoreTrain_freq, SnoreTrain_time] = estrai_da_percorso('/sfiles/SnoringTrain','ogg',winle,stple);

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


