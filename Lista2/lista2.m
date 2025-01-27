function lista2
    %zadanie1();
    zadanie2();
    %zadanie3();
    %zadanie4();
    %zadanie5();
end

function zadanie1
    mean = 31.5; %warto�� oczekiwana
    sigma = 5; %odchylenie standardowe
    meanHypothesis = 28; %hipoteza
    X = normrnd(mean, sigma, [1, 100]);
    alpha = 0.05;
    [~, p] = ttest(X, meanHypothesis, 'Alpha', alpha);
    printResult('Zadanie1', 'ttest', p, alpha);
end

function zadanie2
    meanHypothesis = 3; %hipoteza
    X = [1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7];
    alpha = 0.05;
    [~, p] = ttest(X, meanHypothesis, 'Alpha', alpha);
    printResult('Zadanie2', 'ttest', p, alpha);
end

function zadanie3
    n = 18; %liczno�� pr�by
    mean = 38; %warto�� oczekiwana
    sigma = 14; %odchylenie standardowe
    meanHypothesis = 49; %hipoteza
    alpha = 0.01;
    t = ((mean - meanHypothesis) / sigma) * sqrt(n);
    pStud = tcdf(t, n-1);
    X = normrnd(mean, sigma, [1, 18]);
    [~, p] = ttest(X, meanHypothesis, 'Alpha', alpha);
    printResult('Zadanie3', 'normalny', p, alpha);
    printResult('Zadanie3', 'student', pStud, alpha);
end

function zadanie4
    varHipothesis = 1.6; %hipoteza (wariancja)
    mean = 5; %wartosc oczekiwana
    sigma = 1.5; %odchylenie standardowe
    X = normrnd(mean, sigma, [1, 25]);
    alpha = 0.05;
    [~, p] = vartest(X, varHipothesis, 'Alpha', alpha, 'Tail', 'left');
    printResult('Zadanie4', 'vartest(1.6, 0.05)', p, alpha);
    
    alpha = 0.1;
    [~, p] = vartest(X, varHipothesis, 'Alpha', alpha, 'Tail', 'left');
    printResult('Zadanie4', 'vartest(1.6, 0.1)', p, alpha);
end

function zadanie5
    meanNew = 27.7; %wartosc oczekiwana
    sigmaNew = 5.5; %odchylenie standardowe
    Xnew = normrnd(meanNew, sigmaNew, [1, 20]);

    meanOld = 32.1; %wartosc oczekiwana
    sigmaOld = 6.3; %odchylenie standardowe
    Xold = normrnd(meanOld, sigmaOld, [1, 22]);
    
    alpha = 0.05;
    [~, p] = vartest2(Xnew, Xold, 'Alpha', alpha);
    
    result = 'R�nica jest znacz�ca';
    if (p > alpha) 
       result = 'R�nica jest nieznacz�ca';
    end;
    resultString = '\n%s\n%s wynik: %s, s1 = %f, s2 = %f, p = %f, alfa = %f \n';
    fprintf(resultString, 'zadanie5', 'vartest2', result, std(Xnew), std(Xold), p, alpha);
end

function printResult(task, name, p, alpha)
    result = 'Hipoteza Ho odrzucona';
    if (p > alpha)
       result = 'Nie ma podstaw do odrzucenia hipotezy Ho';
    end;
    fprintf('\n%s\n%s wynik: %s, p = %f, alfa = %f \n', task, name, result, p, alpha);
end