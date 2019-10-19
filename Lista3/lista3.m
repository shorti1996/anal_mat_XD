function lista3
    zadanie5();
end

function zadanie1
    fprintf('\nzadanie1.\n');
    controlB = [0.08, 0.10, 0.15, 0.17, 0.24, 0.34,0.38, 0.42, 0.49, 0.50, 0.70,...
        0.94, 0.95, 1.26, 1.37, 1.55, 1.75, 3.20, 6.98, 50.57];
    figure('Name', 'zadanie1 Dystrybuanta linear scale');
    cdfplot(controlB);
    figure('Name', 'zadanie1 qqplot');
    qqplot(controlB);
end

function zadanie2
    fprintf('\nzadanie2.\n');
    controlB = [0.08, 0.10, 0.15, 0.17, 0.24, 0.34,0.38, 0.42, 0.49, 0.50, 0.70,...
        0.94, 0.95, 1.26, 1.37, 1.55, 1.75, 3.20, 6.98, 50.57];
    figure('Name', 'zadanie2 Dystrybuanta log scale');
    [~, stats] = cdfplot(controlB);
    set(gca,'XScale','log'); %gcs - gca returns the handle to the current axes for the current figure.
    fprintf('\nZadanie2: median: %f\n\n', stats.median);
    figure('Name', 'zadanie2 qqplot');
    qqplot(controlB);
end

function zadanie3
    fprintf('\nzadanie3.\n');
    controlA = [0.22, -0.87, -2.39, -1.79, 0.37, -1.54, 1.28, -0.31, -0.74, 1.72,...
        0.38, -0.17, -0.62, -1.10, 0.30, 0.15, 2.30, 0.19, -0.50, -0.09];
    treatmentA = [-5.13, -2.19, -2.43, -3.83, 0.50, -3.25, 4.32, 1.63, 5.18,...
        -0.43, 7.11, 4.87, -3.10, -5.81, 3.76, 6.31, 2.58, 0.07, 5.76, 3.50];
    figure('Name', 'zadanie3 Dystrybuanta controlA treatmentA');
    cdfplot(controlA);
    hold on;
    cdfplot(treatmentA);
    figure('Name', 'zadanie3 qqplot');
    qqplot(controlA);
end

function zadanie4
    fprintf('\nZadanie4.\n');
    [height,~,~,sex] = importPacjenci();%A(A(:, end) == 2, :);
    sex = char(sex);
    men = height(sex(:) == 'M');
    women = height(sex(:) == 'K');
    evaluateKStest('kstest Mezczyzni', men);
    evaluateKStest('kstest Kobiety', women);
    evaluateKS2test('kstest2', men, women);
    figure('Name', 'zadanie4 qqplot men');
    qqplot(men);
    figure('Name', 'zadanie4 qqplot woman');
    qqplot(women);
end

function zadanie5
    fprintf('\nZadanie5.\n');
    delikates = [23.4, 30.9, 18.8, 23.0, 21.4, 1, 24.6, 23.8, 24.1, 18.7, 16.3,...
        20.3, 14.9, 35.4, 21.6, 21.2, 21.0, 15.0, 15.6, 24.0, 34.6, 40.9, 30.7,...
        24.5, 16.6, 1, 21.7, 1, 23.6, 1, 25.7, 19.3, 46.9, 23.3, 21.8, 33.3,...
        24.9, 24.4, 1, 19.8, 17.2, 21.5, 25.5, 23.3, 18.6, 22.0, 29.8, 33.3,...
        1, 21.3, 18.6, 26.8, 19.4, 21.1, 21.2, 20.5, 19.8, 26.3, 39.3, 21.4, 22.6,...
        1, 35.3, 7.0, 19.3, 21.3, 10.1, 20.2, 1, 36.2, 16.7, 21.1, 39.1, 19.9, 32.1,...
        23.1, 21.8, 30.4, 19.62, 15.5]';
    renety = [16.5, 1, 22.6, 25.3, 23.7, 1, 23.3, 23.9, 16.2, 23.0, 21.6, 10.8,...
        12.2, 23.6, 10.1, 24.4, 16.4, 11.7, 17.7, 34.3, 24.3, 18.7, 27.5, 25.8,...
        22.5, 14.2, 21.7, 1, 31.2, 13.8, 29.7, 23.1, 26.1, 25.1, 23.4, 21.7, 24.4,...
        13.2, 22.1, 26.7, 22.7, 1, 18.2, 28.7, 29.1, 27.4, 22.3, 13.2, 22.5, 25.0,...
        1, 6.6, 23.7, 23.5, 17.3, 24.6, 27.8, 29.7, 25.3, 19.9, 18.2, 26.2, 20.4, 23.3,...
        26.7, 26.0, 1, 25.1, 33.1, 35.0, 25.3, 23.6, 23.2, 20.2, 24.7, 22.6, 39.1, 26.5, 22.7]';
    cdfplot(delikates);
    hold on;
    cdfplot(renety);
    evaluateKStest('kstest delikates', delikates);
    evaluateKStest('kstest renety', renety);
    alpha = 0.05;
    evaluateKS2test('kstest2', renety, delikates, alpha);
    fprintf('\n');
    figure('Name', 'zadanie5 qqplot delikates');
    qqplot(delikates);
    figure('Name', 'zadanie5 qqplot renety');
    qqplot(renety);
end

function zadanie6
    fprintf('\nZadanie6.\n');
    [height,~,~,sex] = importPacjenci();%A(A(:, end) == 2, :);
    sex = char(sex);
    men = height(sex(:) == 'M');
    women = height(sex(:) == 'K');
    evaluateLilietest('lilietest Mezczyzni', men);
    evaluateLilietest('lilietest Kobiety', women);
    fprintf('\n');
    figure('Name', 'zadanie6 qqplot men');
    qqplot(men);
    figure('Name', 'zadanie6 qqplot women');
    qqplot(women);
end


function zadanie7
    fprintf('\nZadanie7.\n');
    [~,~,sugar,~] = importPacjenci();
    alpha = 0.05;
    evaluateSWtest('swtest', sugar, alpha);
    fprintf('\n');
    figure('Name', 'zadanie7 qqplot sugar');
    qqplot(sugar);
end

function zadanie8
    fprintf('\nZadanie8.\n');
    czas = importZarowki();
    alpha = 0.1;
    evaluateSWtest('swtest', czas, alpha);
    fprintf('\n');
    figure('Name', 'zadanie8 qqplot czas');
    qqplot(czas);
end

function zadanie9
    fprintf('\nZadanie9.\n');
    pojemnosc = importKondensatory();
    alpha = 0.05;
    evaluateSWtest('swtest', pojemnosc, alpha);
    evaluateKStest('kstest', pojemnosc);
    evaluateLilietest('lilietest', pojemnosc);
    %cdfplot(pojemnosc);
    fprintf('\n');
    figure('Name', 'zadanie9 qqplot pojemnosc');
    qqplot(pojemnosc);
end

function zadanie10
    fprintf('\nZadanie10.\n');
    [~,~,COLLEGE,SALARY,~,~] = importAbsolwenci();
    rolnictwo = SALARY(strcmp(COLLEGE(:),'Rolnictwo'));
    pedagogika = SALARY(strcmp(COLLEGE(:), 'Pedagogika'));
    alpha = 0.05;

    [x,~] = size(rolnictwo);
    fprintf('rolnictwo size: %d\n', x);
    evaluateSWtest('swtest rolnictwo', rolnictwo, alpha);
    evaluateKStest('kstest rolnictwo', rolnictwo);
    evaluateLilietest('lilietest rolnictwo', rolnictwo);
    
    [x, ~] = size(pedagogika);
    fprintf('pedagogika size: %d\n', x);
    evaluateSWtest('swtest pedagogika', pedagogika, alpha);
    evaluateKStest('kstest pedagogika', pedagogika);
    evaluateLilietest('lilietest pedagogika', pedagogika);
    
    figure('Name', 'zadanie10 qqplot rolnictwo');
    qqplot(rolnictwo);

    figure('Name', 'zadanie10 qqplot pedagogika');
    qqplot(pedagogika);
    
    fprintf('\n');
end

function evaluateSWtest(name, X, alpha)
    [~, P, W] = swtest(X, alpha);
    fprintf('W: %f\n',W);
    printResult(name, P, alpha);
end

function evaluateKStest(name, X)
    CDFall = normcdf(X,mean(X),std(X,1));
    alpha = 0.05;
    [H,P,KSSTAT,CV] = kstest(X, 'CDF', [X,CDFall], 'Alpha', alpha);
    result = 'Hipoteza Ho odrzucona';
    if (P > alpha)
       result = 'Nie ma podstaw do odrzucenia hipotezy Ho';
    end;
    fprintf('%s: H: %d, P: %f, KSSTAT: %f, CV: %f, wynik: %s\n', name, H,P,KSSTAT,CV, result);
end

function evaluateKS2test(name, X, Y, alpha)
    if ~exist('alpha','var')
        alpha = 0.05;
    end
    [H,P,KSSTAT] = kstest2(X,  Y, 'Alpha', alpha);
    result = 'Hipoteza Ho odrzucona';
    if (P > alpha)
       result = 'Nie ma podstaw do odrzucenia hipotezy Ho';
    end;
    fprintf('%s: H: %d, P: %f, KSSTAT: %f, wynik: %s\n', name, H,P,KSSTAT, result);
end

function printResult(name, p, alpha)
    H = 1;
    result = 'Hipoteza Ho odrzucona';
    if (p > alpha)
       result = 'Nie ma podstaw do odrzucenia hipotezy Ho';
       H = 0;
    end;
    fprintf('%s: H: %d, p: %f, wynik: %s\n', name, H, p, result);
end

function evaluateLilietest(name, X)
    alpha = 0.05;
    [H,P,LSTAT,CV] = lillietest(X);
    result = 'Hipoteza Ho odrzucona';
    if (P > alpha)
       result = 'Nie ma podstaw do odrzucenia hipotezy Ho';
    end;
    fprintf('%s: H: %d, P: %f, LSTAT: %f, CV: %f, wynik: %s\n', name, H,P,LSTAT,CV, result);
end