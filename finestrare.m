function [M,nf] = finestrare(x,wl,hop);


lenx = length(x);
nf = floor(lenx/hop);
%disp([wl,nf]);
start = 1;
M = repmat(zeros(floor(wl),nf),1);

for i = 1:nf-1
    M(:,i)=x(start:start+wl-1);
    start = start +hop;
end

