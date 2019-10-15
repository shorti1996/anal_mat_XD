norm = normrnd(10,10, [1, 300]);
figure(1);
plot(norm);
figure(2);
hist(norm,20);
figure(3);
hist(norm,100);
figure(4);
boxplot(norm);