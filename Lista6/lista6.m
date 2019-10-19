function lista6
    zadanie5();
end

function zadanie1
    fprintf('\nzadanie1.\n');
    anova = load('anova_data.mat');
    koala = anova.koala;
    alpha = 0.05;
    evaulateSWtestN('swtest koala', koala, alpha);
    
    p = vartestn(koala);
    printResult('vartestn koala', p, alpha);
    
    % h0 - probki pochodza z populacji o jednakowych wartosciach srednich
    % h1 - probki nie pochodza z populacji o jednakowych wartosciach srednich
    p = anova1(koala);
    printResult('anova1 koala', p, alpha);
end

function zadanie2
    fprintf('\nzadanie2.\n');
    anova = load('anova_data.mat');
    wombats = anova.wombats;
    wombat_groups = anova.wombat_groups;
    alpha = 0.05;
    % h0 - probki pochodza z populacji o jednakowych wartosciach srednich
    % h1 - probki nie pochodza z populacji o jednakowych wartosciach srednich
    [p, ~, stats] = anova1(wombats, wombat_groups);
    printResult('anova1 wombats', p, alpha);
    
    % Column 6 contains the p-value for the hypothesis test that the corresponding mean difference is not equal to 0.
    [c,m] = multcompare(stats);
    disp(c);
    disp(m);
end

function zadanie3
    fprintf('\nzadanie3.\n');
    kwartaly = [3415 4556 5772 5432;
                1593 1937 2242 2794;
                1976 2056 2240 2085;
                1526 1594 1644 1705;
                1538 1634 1866 1769;
                983 1086 1135 1177;
                1050 1209 1245 977;
                1861 2087 2054 2018;
                1714 2415 2361 2424;
                1320 1621 1624 1551;
                1276 1377 1522 1412;
                1263 1279 1350 1490;
                1271 1417 1583 1513;
                1436 1310 1357 1468]';
    group = (1:14);
    alpha = 0.05;
    evaulateSWtestN('swtest kwartaly', kwartaly', alpha);
    
    % h0 - kampania nie mia³a wp³wu (ró¿nice median nieznacz¹ce)
    % h1 -  kampania mia³a wp³w (ró¿nice median znacz¹ce)
    [p,table] = kruskalwallis(kwartaly, group);
    disp(table);
    printResult('kruskalwallis kwartaly', p, alpha);

    p = friedman(kwartaly);
    printResult('friedman kwartaly', p, alpha);
end

function zadanie4
    fprintf('\nzadanie4.\n');
    % Z niezale¿nych pomiarów wiemy, ¿e liczba kubków w ka¿dym z przypadków ma rozk³ad normalny
    % o jednakowej wariancji. Wiemy te¿, ¿e pomiary dokonane w poszczególnych populacjach s¹ niezale¿ne.
    % Poniewa¿ ponadto grupy s¹ równoliczne (na ka¿dej populacji dokonano trzech pomiarów), 
    % mo¿na wykorzystaæ dwuczynnikow¹ analizê wariancji w celu weryfikacji wp³ywu 
    % poszczególnych czynników na uzyskiwan¹ iloœæ popcornu.
    popcorn = [5.5000 4.5000 3.5000;
                5.5000 4.5000 4.0000;
                6.0000 4.0000 3.0000;
                6.5000 5.0000 4.0000;
                7.0000 5.5000 5.0000;
                7.0000 5.0000 4.5000];
    alpha = 0.05;
    
    % H01: œrednia liczba kubków dla ka¿dego z producentów jest jednakowa
    % H02: œrednia liczba kubków jest niezale¿na od typu maszyny
    % H03: producent i typ maszyny nie maj¹ synergicznego wp³ywu na œrednie populacyjne
    [p, ~, stats] = anova2(popcorn,3);
    printResult('anova2 popcorn H01', p(1), alpha);
    printResult('anova2 popcorn H02', p(2), alpha);
    printResult('anova2 popcorn H03', p(3), alpha);
    fprintf('\n');
        
    [c,m] = multcompare(stats);
    disp(c);
    disp(m);
end

function zadanie5
    fprintf('\nZadanie5.\n');
    data = [4.64 5.12 4.64 3.21 3.92 4.95 3.75 2.95 2.95;
            5.92 6.10 4.32 3.17 3.75 5.22 2.50 3.21 2.80;
            5.25 4.85 4.13 3.88 4.01 5.16 2.65 3.15 3.63;
            6.17 4.72 5.17 3.50 4.64 5.35 2.84 3.25 3.85;
            4.20 5.36 3.77 2.47 3.63 4.35 3.09 2.30 2.19;
            5.90 5.41 3.85 4.12 3.46 4.89 2.90 2.76 3.32;
            5.07 5.31 4.12 3.51 4.01 5.61 2.62 3.01 2.68;
            4.13 4.78 5.07 3.85 3.39 4.98 2.75 2.31 3.35;
            4.07 5.08 3.25 4.22 3.78 5.77 3.10 2.50 3.12;
            5.30 4.97 3.49 3.07 3.51 5.23 1.99 2.02 4.11;
            4.37 5.85 3.65 3.62 3.19 4.76 2.42 2.64 2.90;
            3.76 5.26 4.10 2.95 4.04 5.15 2.37 2.27 2.75];
        
    alpha = 0.05;
    evaulateSWtestN('swtest data', data, alpha);
    
    p = vartestn(data);
    printResult('vartestn data', p, alpha);
    
    Z1 = vertcat(data(:,1), data(:,4), data(:,7));
    Z2 = vertcat(data(:,2), data(:,5), data(:,8));
    Z3 = vertcat(data(:,3), data(:,6), data(:,9));
    data2 = [Z1, Z2, Z3];
    % H01: œrednia wydajnoœæ oddechowa dla ka¿dego zak³adu przemys³owego jest jednakowa
    % H02: œrednia wydajnoœæ oddechowa jest niezale¿na od rodzaju substancji toksycznej
    % H03: substancje i zak³ad nie maj¹ synergicznego wp³ywu na œredni¹ wydajnoœæ oddechow¹ 
    %      (ich kombinacja nie ma dodatkowych efektów - dodatkowej zmiany œredniej)
    [p, ~, stats] = anova2(data2, 12);

    printResult('anova2 popcorn H01', p(1), alpha);
    printResult('anova2 popcorn H02', p(2), alpha);
    printResult('anova2 popcorn H03', p(3), alpha);
    fprintf('\n');
        
    [c,m] = multcompare(stats);
    disp(c);
    disp(m);
    
    %
    % index1    index2   dolny     estymata   górny     p-value
    % --------------------------------------------------------
    % 1.0000    2.0000   -0.4904   -0.1994    0.0915    0.2374
    % 1.0000    3.0000   -0.7159   -0.4250   -0.1341    0.0022
    % 2.0000    3.0000   -0.5165   -0.2256    0.0654    0.1605
    %                      ^ przedzia³y ufnoœci ^
    
    % 
    % mean      std err (sigma / ?N)
    % ----------------
    % 3.7036    0.0865
    % 3.9031    0.0865
    % 4.1286    0.0865
end

function evaulateSWtestN(name, X, alpha) 
    [~, N] = size(X);
    for i=1:N
        evaluateSWtest(strcat(name, num2str(i)), X(:,i), alpha);
    end
end

function evaluateSWtest(name, X, alpha)
    [~, P, W] = swtest(X, alpha);
    % fprintf('W: %f\n',W);
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