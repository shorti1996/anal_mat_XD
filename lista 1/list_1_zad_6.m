A = normrnd(3, 7, [1, 300]);

figure('Name', 'zadanie6 histogram');
hist(A, 30);

figure('Name', 'zadanie6 Dystrybuanta');
normplot(A);
