% Get unique values in C
colors = unique(C, 'rows');

% Create three separate color matrices for each category
color1 = ismember(C, colors(1, :), 'rows');
color2 = ismember(C, colors(2, :), 'rows');
color3 = ismember(C, colors(3, :), 'rows');

% Plot the scatter plots for each category
scatter3(score(color1, 1), score(color1, 2), score(color1, 3), [], C(color1, :));
hold on;
scatter3(score(color2, 1), score(color2, 2), score(color2, 3), [], C(color2, :));
scatter3(score(color3, 1), score(color3, 2), score(color3, 3), [], C(color3, :));

% Set labels and title
xlabel('PCA1');
ylabel('PCA2');
zlabel('PCA3');
title('After PCA');

% Set legend
legend('Category 1', 'Category 2', 'Category 3');