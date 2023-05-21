function [pred_label, rate] = kappaNN(k, train, trainlab, test, testlab)

rate =zeros(1,length(k));
for ks = 1:length(k)
    
    Md1 = fitcknn(train,trainlab,'NumNeighbors',k(ks));

    pred_label = predict(Md1,test);

    correct = 0;

    for i=1:length(pred_label)
        if pred_label(i) == testlab(i)
            correct = correct +1;
        end
    end
    disp(['rec rate at ', mat2str(k(ks)),' nn:'])
    rate(ks) = correct/length(pred_label)*100;
    disp(rate(ks))

end

[maxrate, ind]= max(rate);

disp(['maxrate: ',mat2str(maxrate)])
disp(['with ',mat2str(k(ind)),' nearest neighrbors.'])

