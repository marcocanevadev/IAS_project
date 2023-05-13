function allfeats = estrai_da_percorso(path,ext,winlen,stplen)
addpath(genpath(pwd))
list = dir([pwd,path,'/*',ext]);
allfeats = [];
wa = waitbar(length(list));
for i =1:length(list)

    waitbar(i/length(list));
    feature = estrai_Freq_MFCCs(list(i).name,winlen,stplen);
    allfeats = [allfeats feature];
end

close(wa)