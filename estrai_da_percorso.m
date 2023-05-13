function [allfreq, alltime] = estrai_da_percorso(path,ext,winlen,stplen)
addpath(genpath(pwd))

list = dir([pwd,path,'/*',ext]);

allfreq = [];
alltime = [];

wa = waitbar(length(list));

for i =1:length(list)

    waitbar(i/length(list));
    [freq, time] = estrai_Time_Freq_MFCCs(list(i).name,winlen,stplen);
    allfreq = [allfreq freq];
    alltime = [alltime time];

end

close(wa)