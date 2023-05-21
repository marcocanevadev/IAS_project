        %---- Perform and plot PCA in 3D space ----

[coeff, score, latent, tsquared, explained] = pca(allfeaturesNorm);

C=[repmat([1 0.2 0],length(BreathTrain_all),1); repmat([0 1 0.5],length(SneezeTrain_all),1); repmat([0.2 0 1], length(SnoreTrain_all),1)];
figure(1)

scatter3(score(:,1),score(:,2),score(:,3),[],C)
xlabel('PCA1')
ylabel('PCA2')
zlabel('PCA3')
title('After PCA')
legend('1','2','3')

        %---- Plot Data before PCA ----

correlation = corr(allfeaturesNorm, flagTr');

[~, indices] = sort(abs(correlation), 'descend');
sel_features = indices(1:3);

beforedata = allfeaturesNorm(:, sel_features);

figure(2)
scatter3(beforedata(:, 1), beforedata(:, 2), beforedata(:, 3), [], C);
xlabel('Feature 1');
ylabel('Feature 2');
zlabel('Feature 3');
title('Before PCA')
legend('breath','sneeze','snore')

        %---- Find N° of components that cover 80% of variance ----

explainedcumu = cumsum(explained);
indice80 = find(explainedcumu >= 80, 1);

fprintf('Number of coefficients with at least 80%% of variance: \n\t%d\nIndexes:\n', indice80);

disp(indices(1:indice80))