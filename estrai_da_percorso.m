function feats = estrai_da_percorso(path,ext,winlen,stplen)
addpath(genpath(pwd))
list = dir([pwd,path,'/*',ext]);
feats = [];
for i =1:length(list)
    mfccs = estraiMFCCs(list(i).name,winlen,stplen);
    feats = [feats mfccs];
end