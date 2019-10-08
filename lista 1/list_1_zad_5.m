iris = importdata('iris.txt', '', 1);
iris_col = iris.data(:,3);
figure('Name', 'zadanie5 iris');
hist(iris_col, 30);

glass = importdata('glass.txt', '', 1);
glass_col = glass.data(:,7);
figure('Name', 'zadanie5 glass');
hist(glass_col, 30);