function mfccs = estraiMFCCS(filename, winlen, stplen)
[y,fs]=audioread(filename);

[M,nf]=finestrare(y,floor(winlen*fs),floor(stplen*fs));

h = hamming(floor(winlen*fs));

disp(length(h))

w = waitbar(nf,'Extracting MFCCs...');

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
    mfccs(1:13,i) = feature_mfccs(frameFFT,parametri);
end
close(w)
