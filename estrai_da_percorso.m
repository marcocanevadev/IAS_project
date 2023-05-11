function feats = estrai_da_percorso(path,ext,winlen,stplen)
addpath(genpath(pwd))
list = dir([pwd,path,'/*',ext]);
for i 