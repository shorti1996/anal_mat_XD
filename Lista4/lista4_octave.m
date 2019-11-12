function lista4
    #zadanie1();
    #zadanie2();
    #zadanie3();
    # nope zadanie4();
    #zadanie5();
    #zadanie6();
    #zadanie7();
    #zadanie8();
end

function zadanie1
    fprintf('\nzadanie1.\n');
    data13 = [175.26,177.8,167.64000000000001,160.02,172.72,177.8,175.26,170.18,157.48,160.02,...
        193.04,149.86,157.48,157.48,190.5,157.48,182.88,160.02];
    
    data17 = [172.72,157.48,170.18,172.72,175.26,170.18,154.94,149.86,157.48,154.94,175.26,...
         167.64000000000001,157.48,157.48,154.94,177.8];
    
    alpha = 0.05;
    tail = 'both';
    vartype = 'equal';
    evaluateSWtest('swtest data13', data13, alpha);
    evaluateSWtest('swtest data17', data17, alpha);
    %evaluateTtest2('ttest2', data13, data17, alpha, tail, vartype);

    alpha = 0.1;
    tail = 'left';
    vartype = 'unequal';
    evaluateSWtest('swtest data13', data13, alpha);
    evaluateSWtest('swtest data17', data17, alpha);
    %evaluateTtest2('ttest2', data13, data17, alpha, tail, vartype);
    
    figure('Name', 'zadanie1 qqplot data13');
    qqplot(data13);
    figure('Name', 'zadanie1 qqplot data17');
    qqplot(data17);
end

function zadanie2
    fprintf('\nzadanie2.\n');
    nerwowi = [3, 3, 4, 5, 5];
    spokojni = [4, 6, 7, 9, 9];
    % h0 - nerwowi i spokojni wykonuja srednio tyle samo ruchow (średnie takie same)
    % h1 - nerwowi wykonuja srednio wiecej ruchow niz spokojni (m1 > m2)
    alpha = 0.05;
    tail = 'right';
    evaluateSWtest('swtest nerwowi', nerwowi, alpha);
    evaluateSWtest('swtest spokojni', spokojni, alpha);
    evaluateTtest2('ttest2', nerwowi, spokojni, alpha, tail);
    
    figure('Name', 'zadanie2 qqplot nerwowi');
    qqplot(nerwowi);
    figure('Name', 'zadanie2 qqplot spokojni');
    qqplot(spokojni);
end

function zadanie3
    fprintf('\nzadanie3.\n');
    przed30 = [6, 7, 10, 9];
    po30 = [5, 6, 2, 3];
    % h0 - przed30 i po30 tak samo dowcipni (średnie takie same)
    % h1 - przed30 bardziej dowcipni niz po30 (m1 > m2)
    alpha = 0.05;
    tail = 'right';
    evaluateSWtest('swtest przed30', przed30, alpha);
    evaluateSWtest('swtest po30', po30, alpha);
    evaluateTtest2('ttest2', przed30, po30, alpha, tail);
    
    figure('Name', 'zadanie4 qqplot przed30');
    qqplot(przed30);
    figure('Name', 'zadanie4 qqplot po30');
    qqplot(po30);
end

function zadanie4
    fprintf('\nzadanie4.\n');
    % Nie mozna zastosowac testu dla prób zależnych. Próby są niezależne.
    % Trzeba by zebrać dane ponownie np. po zmianie wyksztalcenia dla tych
    % samych osob
end

function zadanie5
    fprintf('\nZadanie5.\n');
    data13 = [175.26,177.8,167.64000000000001,160.02,172.72,177.8,175.26,170.18,...
        157.48,160.02,193.04,149.86,157.48,157.48,190.5,157.48,182.88,160.02];
    alpha = 0.05;
    meanHypothesis = 169.051;
    
    evaluateSWtest('swtest data13', data13, alpha);
    [~, p] = ttest(data13, meanHypothesis, 'Alpha', alpha);
    printResult('ttest data13', p, alpha);
    
    figure('Name', 'zadanie5 qqplot data13');
    qqplot(data13);
end

function zadanie6
    fprintf('\nZadanie6.\n');
    data17 = [172.72,157.48,170.18,172.72,175.26,170.18,154.94,149.86,157.48,...
        154.94,175.26,167.64000000000001,157.48,157.48,154.94,177.8];
    alpha = 0.05;
    
    evaluateSWtest('swtest data17', data17, alpha);
    % hipoteza H0 ze dane pochodza z rozkladu normalnego zostala odrzucona
    % nie mozna przeprowadzic ttestu
    
    figure('Name', 'zadanie6 qqplot data17');
    qqplot(data17);
end

function zadanie7
    fprintf('\nzadanie7.\n');
    nerwowi = [3, 3, 4, 5, 5];
    spokojni = [4, 6, 7, 9, 9];
    % h0 - probki sa jednakowo duze
    % h1 - probki nie sa jednakowo duze
    alpha = 0.05;
    [p, stats] = u_test(nerwowi,spokojni);
    #disp(stats);
    #p = stats.p(2);
    printResult('u_test nerwowi spokojni', p, alpha);
    
    figure('Name', 'zadanie7 qqplot nerwowi');
    qqplot(nerwowi);
    figure('Name', 'zadanie7 qqplot spokojni');
    qqplot(spokojni);
end

function zadanie8
    fprintf('\nzadanie8.\n');
    data13 = [175.26,177.8,167.64,160.02,172.72,177.8,175.26,170.18,157.48,...
        160.02,193.04,149.86,157.48,157.48,190.5,157.48,182.88,160.02];
    
    data17 = [172.72,157.48,170.18,172.72,175.26,170.18,154.94,149.86,...
        157.48,154.94,175.26,167.64,157.48,157.48,154.94,177.8];
    
    % h0 - wzrost studentów jest jednakowo duży
    % h1 - wzrost studentów nie jest jednakowo duży
    alpha = 0.05;
    [p, stats] = u_test(data13,data17);
    #disp(stats);
    #p = stats.p(2);
    printResult('u_test data13 data17', p, alpha);
    
    figure('Name', 'zadanie8 qqplot data13');
    qqplot(data13);
    figure('Name', 'zadanie8 qqplot data17');
    qqplot(data17);
end

function evaluateTtest2(name, X, Y, alpha, tail, vartype)
    if ~exist('vartype','var')
        vartype = 'equal';
    end
    if ~exist('tail','var')
        tail = 'both';
    end
    [H, p, ci, stats] = ttest2(X, Y, 'Alpha', alpha, 'Tail', tail, 'Vartype', vartype);
    
    result = 'Hipoteza Ho odrzucona';
    if (p > alpha)
       result = 'Nie ma podstaw do odrzucenia hipotezy Ho';
    end;
    resultString = '\n%s, wynik: %s, p: %f, alfa: %f, H: %d, m1: %f, m2: %f\n';
    fprintf(resultString, name, result, p, alpha, H, mean(X), mean(Y));
end

function evaluateSWtest(name, X, alpha)
    [~, P, W] = swtest(X, alpha);
    %fprintf('W: %f\n',W);
    printResult(name, P, alpha);
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
