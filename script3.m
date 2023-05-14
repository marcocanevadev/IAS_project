        %---- Extract Test Features ----

addpath(genpath(pwd))

winle = 0.015;
stple = winle/3*2;

        %---- Extract from path ----

[BreathTest_freq, BreathTest_time] = estrai_da_percorso('/sfiles/BreathingTest','ogg',winle,stple);
[SneezeTest_freq, SneezeTest_time] = estrai_da_percorso('/sfiles/SneezingTest','ogg',winle,stple);
[SnoreTest_freq, SnoreTest_time] = estrai_da_percorso('/sfiles/SnoringTest','ogg',winle,stple);

        %---- Ground Truth Flags ----

flagBTest = zeros(1,length(BreathTest_freq));
flagSzTest = ones(1, length(SneezeTrain_freq));
flagSrTest = ones(1, length(SnoreTrain_freq))+ones(1,length(SnoreTrain_freq));

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

