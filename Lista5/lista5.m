function lista5
    zadanie5();
end

function zadanie1
    fprintf('\nzadanie1.\n');
    w1 = [88 69 86 59 57 82 94 93 64 91 86 59 91 60 57 92 70 88 70 85];
    w2 = [73 68 75 54 53 84 84 86 66 84 78 58 91 57 59 88 71 84 64 85];
    
    figure('Name', 'zadanie1 plot w1 w2');
    plot(w1,'-ro');
    hold on;
    plot(w2,'-bo');
    
    figure('Name', 'zadanie1 qqplot w1');
    qqplot(w1);
    figure('Name', 'zadanie1 qqplot w2');
    qqplot(w2);
    
    figure('Name', 'zadanie1 boxplot w1');
    boxplot(w1);
    figure('Name', 'zadanie1 boxplot w2');
    boxplot(w2);
    
    alpha = 0.05;
    evaluateSWtest('swtest w1', w1, alpha);
    evaluateSWtest('swtest w2', w2, alpha);
    % h0 - dieta nie wplywa na wage ciala - mediana = 0
    % h1 - dieta powoduje zmniejszenie wagi ciala - mediana < 0 (w1 > w2)
    [p,~,~] = signtest(w1,w2, 'Alpha', alpha, 'Tail', 'right');
    printResult('signtest w1 w2', p, alpha);
end

function zadanie2
    fprintf('\nzadanie2.\n');
    [przed, po] = importCzytelnictwo();
    
    figure('Name', 'zadanie2 plot przed po');
    plot(przed,'-ro');
    hold on;
    plot(po,'-bo');
    
    figure('Name', 'zadanie2 qqplot przed');
    qqplot(przed);
    figure('Name', 'zadanie2 qqplot po');
    qqplot(po);
    
    figure('Name', 'zadanie2 boxplot przed');
    boxplot(przed);
    figure('Name', 'zadanie2 boxplot po');
    boxplot(po);
    
    alpha = 0.05;
    
    evaluateSWtest('swtest przed', przed, alpha);
    evaluateSWtest('swtest po', po, alpha);
    % h0 - zatrudnienie w firmie nie ma plywu na ilosc czasu poswiecanego na lekture (mediana = 0)
    % h1 - zatrudnienie w firmie ma plyw na ilosc czasu poswiecanego na lekture (mediana <> 0)
    [p,~,~] = signtest(przed , po, 'Alpha', alpha);
    printResult('signtest przed po', p, alpha);
end

function zadanie3
    fprintf('\nzadanie3.\n');
    [zapylona, niezapylona] = importChmiel();
    
    figure('Name', 'zadanie3 plot zapylona niezapylona');
    plot(zapylona,'-ro');
    hold on;
    plot(niezapylona,'-bo');
    
    figure('Name', 'zadanie3 qqplot zapylona');
    qqplot(zapylona);
    figure('Name', 'zadanie3 qqplot niezapylona');
    qqplot(niezapylona);
    
    figure('Name', 'zadanie3 boxplot zapylona');
    boxplot(zapylona);
    figure('Name', 'zadanie3 boxplot niezapylona');
    boxplot(niezapylona);
    
  
    
    alpha = 0.05;
    evaluateSWtest('swtest zapylona', zapylona, alpha);
    evaluateSWtest('swtest niezapylona', niezapylona, alpha);
    [~, p] = vartest2(zapylona, niezapylona, 'Alpha', alpha);
    printResult('vartest2 zapylona niezapylona', p, alpha);
    % h0 - zapylenie nie ma wplywu na mase nasion (mediana = 0)
    % h1 - zapylenie ma wplyw na mase nasion (mediana <> 0)
    [p,~,~] = ranksum(zapylona , niezapylona, 'Alpha', alpha);
    printResult('ranksum zapylona niezapylona', p, alpha);
end

function zadanie4
    fprintf('\nzadanie4.\n');
    [przed, po] = importCzytelnictwo();
    
    figure('Name', 'zadanie4 plot przed po');
    plot(przed,'-ro');
    hold on;
    plot(po,'-bo');
    
    figure('Name', 'zadanie4 qqplot przed');
    qqplot(przed);
    figure('Name', 'zadanie4 qqplot po');
    qqplot(po);
    
    figure('Name', 'zadanie4 boxplot przed');
    boxplot(przed);
    figure('Name', 'zadanie4 boxplot po');
    boxplot(po);
    
    alpha = 0.05;
    
    evaluateSWtest('swtest przed', przed, alpha);
    evaluateSWtest('swtest po', po, alpha);
    % h0 - zatrudnienie w firmie nie ma plywu na ilosc czasu poswiecanego na lekture (mediana = 0)
    % h1 - zatrudnienie w firmie ma plyw na ilosc czasu poswiecanego na lekture (mediana <> 0)
    [p,~,~] = ranksum(przed , po, 'Alpha', alpha);
    printResult('ranksum przed po', p, alpha);
end

function zadanie5
    fprintf('\nZadanie5.\n');
    [time,group] = importDaneZKoronografii();
    group1 = time(group == 1);
    group2 = time(group == 2);
    
    figure('Name', 'zadanie5 plot group1 group2');
    plot(group1,'-ro');
    hold on;
    plot(group2,'-bo');
    
    figure('Name', 'zadanie5 qqplot group1');
    qqplot(group1);
    figure('Name', 'zadanie5 qqplot group2');
    qqplot(group2);
    
    figure('Name', 'zadanie5 boxplot group1');
    boxplot(group1);
    figure('Name', 'zadanie5 boxplot group2');
    boxplot(group2);
    
    alpha = 0.1;
    
    evaluateSWtest('swtest group1', group1, alpha);
    evaluateSWtest('swtest group2', group2, alpha);
    % h0 - czas cwiczenia nie zalezy od stanu zdrowia (mediana = 0)
    % h1 - czas cwiczenia zalezy od stanu zdrowia (mediana <> 0)
    [p,~,~] = ranksum(group1 , group2, 'Alpha', alpha);
    printResult('ranksum group1 group2', p, alpha);
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