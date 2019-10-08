function lista1
    %zadanie1();
    %zadanie2();
    %zadanie3();
    %zadanie4();
    %zadanie5();
    %zadanie6();
    zadanie7();
    %zadanie8();
end

function zadanie1
    [m,s] = stat(1:10);
    disp(m);
    disp(s);
end

function zadanie2
    X = 3*(randn(100,1)-1);
    figure(1);
    plot(X);
    figure(2);
    hist(X);
end

function zadanie3
    norm = normrnd(10,10, [1, 300]);
    figure(1);
    plot(norm);
    figure(2);
    hist(norm,20);
    figure(3);
    hist(norm,100);
    figure(4);
    boxplot(norm);
end

function zadanie4
    V1 = randn(1,100);
    V2 = gen1(10,100)';
    V3 = gen2(10,100)';
    V4 = gen3(10,100)';
    displayDetails(1, 'v1', V1);
    displayDetails(2, 'v2', V2);
    displayDetails(3, 'v3', V3);
    displayDetails(4, 'v4', V4);
end

function zadanie5
    iris = importdata('iris.txt', ' ', 1);
    glass = readtable('glass.txt','Delimiter', '\t');
    colIris = iris.data(:,2);
    colGlass = glass.Na;
    figure('Name', 'zadanie5 iris');
    hist(colIris, 30);
    figure('Name', 'zadanie5 glass');
    hist(colGlass, 30);
end

function zadanie6
    A = normrnd(3,7, [1, 300]);
    figure('Name', 'zadanie6 histogram');
    hist(A, 30);
    figure('Name', 'zadanie6 Dystrybuanta');
    normplot(A);
    %cdfplot(A);
end

function zadanie7
    mu = 0;
    sigma = 1;
    pd = makedist('Normal',mu,sigma);
    P1 = cdf(pd, 2);
    P2 = P1 - cdf(pd, -2);
    fprintf('\nP(Z<2) = %f, P(|Z|<2) = %f\n\n', P1, P2);
end

function zadanie8
    A = [8.5 7.6 9.3 5.5 11.4 6.9 6.5 12.9 8.7 4.8 4.2 8.1 6.5 5.8 6.7 2.4 11.1 7.1 8.8 7.2];
    figure('Name', 'zadanie8 boxplot');
    boxplot(A);
    fprintf('mean: %f, median: %f, standard deviation: %f\n', mean(A), median(A), std(A));
    figure('Name', 'zadanie8 histogram');
    hist(A, 10);
end

function [mean,stdev] = stat(x)
    %STAT (not) Interesting statistics.
    n = length(x);
    mean = sum(x) / n;
    stdev = sqrt(sum((x - mean).^2)/n);
end

function y=gen1(x,N)
    m=8191;
    a=101;
    c=1731;
    y=zeros(N,1);
    for i=1:N
        x=mod(a.*x+c,m);
        y(i)=x/m;
    end
end

function y=gen2(x,N)
    a=517;
    m=32767;
    c=6923;
    y=zeros(N,1);
    for i=1:N
        x=mod(a.*x+c,m);
        y(i)=x/m;
    end
end

function y=gen3(x,N)
    c=65536;
    y=zeros(N,1);
    for i=1:N
        x=x*25;
        x=mod(x,c);
        x=x*125;
        x=mod(x,c);
        y(i)=x/c;
    end
end

function displayDetails(index, name, A)
    figure('Name', 'zadanie4 ' + name);
    hist(A, 100);
    m = mean(A);
    v = var(A);
    fprintf('%d.%s, mean: %f, var: %f\n',index, name, m, v);
    %disp(A);
end