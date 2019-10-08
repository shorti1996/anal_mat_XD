A = [8.5 7.6 9.3 5.5 11.4 6.9 6.5 12.9 8.7 4.8 4.2 8.1 6.5 5.8 6.7 2.4 11.1 7.1 8.8 7.2];
figure('Name', 'zadanie8 boxplot');
boxplot(A);
fprintf('mean: %f, median: %f, standard deviation: %f\n', mean(A), median(A), std(A));
figure('Name', 'zadanie8 histogram');
hist(A, 10);