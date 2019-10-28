import csv

import scipy
from matplotlib import pyplot as plt
from matplotlib.collections import Collection
import numpy as np
from Lista3.plot_utils import cdfplot, qqplot, prepare_x_y_for_cdfplot
from Lista3.file_utils import read_csv_file
from scipy.stats import norm


def zad1():
    control_b = [0.08, 0.10, 0.15, 0.17, 0.24, 0.34, 0.38, 0.42, 0.49, 0.50, 0.70,
                 0.94, 0.95, 1.26, 1.37, 1.55, 1.75, 3.20, 6.98, 50.57]
    cdfplot(control_b)

    qqplot(control_b)


def zad2():
    control_b = [0.08, 0.10, 0.15, 0.17, 0.24, 0.34, 0.38, 0.42, 0.49, 0.50, 0.70,
                 0.94, 0.95, 1.26, 1.37, 1.55, 1.75, 3.20, 6.98, 50.57]
    cdfplot(control_b, xscale="log")

    qqplot(control_b)


def zad3():
    control_a = [0.22, -0.87, -2.39, -1.79, 0.37, -1.54, 1.28, -0.31, -0.74, 1.72,
                 0.38, -0.17, -0.62, -1.10, 0.30, 0.15, 2.30, 0.19, -0.50, -0.09]
    treatment_a = [-5.13, -2.19, -2.43, -3.83, 0.50, -3.25, 4.32, 1.63, 5.18,
                   -0.43, 7.11, 4.87, -3.10, -5.81, 3.76, 6.31, 2.58, 0.07, 5.76, 3.50]
    x1, y1 = prepare_x_y_for_cdfplot(control_a)
    x2, y2 = prepare_x_y_for_cdfplot(treatment_a)
    plt.step(x1, y1)
    plt.step(x2, y2)
    plt.show()


# function zadanie4
#     fprintf('\nZadanie4.\n');
#     [height,~,~,sex] = importPacjenci();%A(A(:, end) == 2, :);
#     sex = char(sex);
#     men = height(sex(:) == 'M');
#     women = height(sex(:) == 'K');
#     evaluateKStest('kstest Mezczyzni', men);
#     evaluateKStest('kstest Kobiety', women);
#     evaluateKS2test('kstest2', men, women);
#     figure('Name', 'zadanie4 qqplot men');
#     qqplot(men);
#     figure('Name', 'zadanie4 qqplot woman');
#     qqplot(women);
# end
def zad4():
    filename = "pacjenci.csv"
    pacjenci = read_csv_file(filename)
    men_heights = [int(x["wzrost"]) for x in pacjenci if x["plec"] == "M"]
    women_heights = [int(x["wzrost"]) for x in pacjenci if x["plec"] == "K"]

    qqplot(men_heights)
    qqplot(women_heights)

    eval_KS_test(men_heights, "kstest men")
    eval_KS_test(women_heights, "kstest women")

    eval_KS2_test(men_heights, women_heights, "kstest2 men vs women")


def print_hypothesis(alpha, name, pvalue):
    print(name)
    if pvalue > alpha:
        print(f"Nie ma podstaw do odrzucenia hipotezy Ho\npvalue: {pvalue:f} > alpha: {alpha:f}")
    else:
        print(f"Hipoteza Ho odrzucona\npvalue: {pvalue:f} <= alpha: {alpha:f}")


def eval_KS_test(data, name: str = ""):
    alpha = 0.05
    # CDFall = norm.cdf(data, loc=np.mean(data), scale=np.std(data))
    # statistic, pvalue = scipy.stats.kstest(CDFall, norm.cdf)
    statistic, pvalue = scipy.stats.kstest(data, lambda x: norm.cdf(x, loc=np.mean(x), scale=np.std(x)))

    print_hypothesis(alpha, name, pvalue)


def eval_KS2_test(data1, data2, name: str = ""):
    alpha = 0.05
    statistic, pvalue = scipy.stats.ks_2samp(data1, data2)
    print_hypothesis(alpha, name, pvalue)

zad4()
