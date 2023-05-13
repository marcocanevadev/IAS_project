function freqFeats = estrai_Freq_MFCCs(filename, winlen, stplen)
[y,fs]=audioread(filename);

[M,nf]=finestrare(y,floor(winlen*fs),floor(stplen*fs));

h = hamming(floor(winlen*fs));

disp(length(h))

Ce=zeros(1,nf);
Sp=zeros(1,nf);
Et=zeros(1,nf);
Fx=zeros(1,nf);
Rf=zeros(1,nf);


w = waitbar(nf,['Extracting Freq. features for: ',filename,' ...']);

%disp([size(h,1),size(h,2)])
parametri = feature_mfccs_init(winlen*fs, fs);
disp(nf)

mfccs = zeros(13,nf);

for i= 1:nf
    waitbar(i/nf)
    %take i-th column each time
    frame = M(:,i);
    %disp([size(frame,1),size(frame,2)])
    %apply hamming windowing to smooth
    frame = frame .* h;
    frameFFT = getDFT(frame, fs);

    [Ce(i),Sp(i)] = feature_spectral_centroid(frameFFT,fs);
    Et(i) = feature_spectral_entropy(frameFFT, 15);
    
    if i == 1
        Fx(i) = feature_spectral_flux(frameFFT, zeros(length(frameFFT),1));
    else 
        lastframe = M(:,i-1);
        lastframe = lastframe .* h;
        lastFFT = getDFT(lastframe,fs);
        Fx(i) = feature_spectral_flux(frameFFT,lastFFT);
    end
    
    Rf(i) = feature_spectral_rolloff(frameFFT,0.9);

    mfccs(1:13,i) = feature_mfccs(frameFFT,parametri);
end

freqFeats=mfccs;

freqFeats(14,:) = Ce;
freqFeats(15,:) = Sp;
freqFeats(16,:) = Et;
freqFeats(17,:) = Rf;
freqFeats(18,:) = Fx;





close(w)
