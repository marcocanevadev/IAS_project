function [freqFeats, timefeats] = estrai_Time_Freq_MFCCs(filename, winlen, stplen)

[y,fs]=audioread(filename);
[M,nf]=finestrare(y,floor(winlen*fs),floor(stplen*fs));

h = hamming(floor(winlen*fs));

%disp(length(h))

Ce=zeros(1,nf);
Sp=zeros(1,nf);
Et=zeros(1,nf);
Fx=zeros(1,nf);
Rf=zeros(1,nf);

mfccs = zeros(13,nf);
parametri = feature_mfccs_init(winlen*fs, fs);

E = zeros(1,nf);
Z = zeros(1,nf);
EE = zeros(1,nf);


w = waitbar(nf,['Extracting features for: ',filename,' ...']);

%disp([size(h,1),size(h,2)])
%disp(nf)

for i= 1:nf
    waitbar(i/nf)
                %-----take i-th column and Hamming------
 
    frame = M(:,i);
    %disp([size(frame,1),size(frame,2)])
    frame = frame .* h;
    frameFFT = getDFT(frame, fs);


                %---- TIME FEATS ------
    E(i) = feature_energy(frame);
    Z(i) = feature_zcr(frame);
    EE(i) = feature_energy_entropy(frame,15); %num of short blocks
        

                %---- FREQUENCY FEATS-----
    [Ce(i),Sp(i)] = feature_spectral_centroid(frameFFT,fs);
    Et(i) = feature_spectral_entropy(frameFFT, 15); %numOfShortBlocks
    
    if i == 1       %special case for first frame
        Fx(i) = feature_spectral_flux(frameFFT, zeros(length(frameFFT),1));
    else 
        lastframe = M(:,i-1);
        lastframe = lastframe .* h;
        lastFFT = getDFT(lastframe,fs);
        Fx(i) = feature_spectral_flux(frameFFT,lastFFT);
    end
    
    Rf(i) = feature_spectral_rolloff(frameFFT,0.9); %percent of Freqs

    mfccs(1:13,i) = feature_mfccs(frameFFT,parametri);
end
            %------ Concatenate in two groups ------
freqFeats=mfccs;

freqFeats(14,:) = Ce;
freqFeats(15,:) = Sp;
freqFeats(16,:) = Et;
freqFeats(17,:) = Rf;
freqFeats(18,:) = Fx;

timefeats(1,:) = E;
timefeats(2,:) = Z;
timefeats(3,:) = EE;





close(w)
