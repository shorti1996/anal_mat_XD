import numpy as np
import scipy
from matplotlib import pyplot as plt
from scipy.stats import norm
from statsmodels.stats.diagnostic import lilliefors

from Lista3.file_utils import read_csv_file
from Lista3.plot_utils import cdfplot, qqplot, prepare_x_y_for_cdfplot

alpha = 0.05


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
    # qqplot(control_a)
    # qqplot(treatment_a)


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


def zad5():
    delikates = [23.4, 30.9, 18.8, 23.0, 21.4, 1, 24.6, 23.8, 24.1, 18.7, 16.3,
                 20.3, 14.9, 35.4, 21.6, 21.2, 21.0, 15.0, 15.6, 24.0, 34.6, 40.9, 30.7,
                 24.5, 16.6, 1, 21.7, 1, 23.6, 1, 25.7, 19.3, 46.9, 23.3, 21.8, 33.3,
                 24.9, 24.4, 1, 19.8, 17.2, 21.5, 25.5, 23.3, 18.6, 22.0, 29.8, 33.3,
                 1, 21.3, 18.6, 26.8, 19.4, 21.1, 21.2, 20.5, 19.8, 26.3, 39.3, 21.4, 22.6,
                 1, 35.3, 7.0, 19.3, 21.3, 10.1, 20.2, 1, 36.2, 16.7, 21.1, 39.1, 19.9, 32.1,
                 23.1, 21.8, 30.4, 19.62, 15.5]
    reneta = [16.5, 1, 22.6, 25.3, 23.7, 1, 23.3, 23.9, 16.2, 23.0, 21.6, 10.8,
              12.2, 23.6, 10.1, 24.4, 16.4, 11.7, 17.7, 34.3, 24.3, 18.7, 27.5, 25.8,
              22.5, 14.2, 21.7, 1, 31.2, 13.8, 29.7, 23.1, 26.1, 25.1, 23.4, 21.7, 24.4,
              13.2, 22.1, 26.7, 22.7, 1, 18.2, 28.7, 29.1, 27.4, 22.3, 13.2, 22.5, 25.0,
              1, 6.6, 23.7, 23.5, 17.3, 24.6, 27.8, 29.7, 25.3, 19.9, 18.2, 26.2, 20.4, 23.3,
              26.7, 26.0, 1, 25.1, 33.1, 35.0, 25.3, 23.6, 23.2, 20.2, 24.7, 22.6, 39.1, 26.5, 22.7]

    # cdfplot(delikates)
    # cdfplot(reneta)
    x1, y1 = prepare_x_y_for_cdfplot(delikates)
    x2, y2 = prepare_x_y_for_cdfplot(reneta)
    plt.step(x1, y1)
    plt.step(x2, y2)
    plt.show()

    eval_KS_test(delikates, "kstest delikates")
    eval_KS_test(reneta, "kstest reneta")

    eval_KS2_test(delikates, reneta, "kstest2 delikates vs reneta")

    qqplot(delikates)
    qqplot(reneta)


def zad6():
    pacjenci = read_csv_file("pacjenci.csv")
    men_heights = [int(x["wzrost"]) for x in pacjenci if x["plec"] == "M"]
    women_heights = [int(x["wzrost"]) for x in pacjenci if x["plec"] == "K"]

    eval_lilliefors(men_heights, "kstest men")
    eval_lilliefors(women_heights, "kstest women")

    qqplot(men_heights)
    qqplot(women_heights)
    # eval_lilliefors([1,2,3,4,3,2,1,2,2,2,2,2,2,2], "kstest aaa")


def zad7():
    pacjenci = read_csv_file("pacjenci.csv")
    sugar = [float(x["cukier"]) for x in pacjenci]
    # eval_KS_test(sugar, "KS test")
    # eval_lilliefors(sugar, "lilliefors test")
    eval_SW_test(sugar, "SW test")
    qqplot(sugar)


def zad8():
    zarowki = read_csv_file("zarowki.csv")
    times = [float(x["czas"]) for x in zarowki]
    # eval_KS_test(times, "KS test")
    # eval_lilliefors(times, "lilliefors test")
    eval_SW_test(times, "SW test")
    qqplot(times)


def zad9():
    kondensatory = read_csv_file("kondensatory.csv")
    pojemnosc = [float(x["pojemnosc"]) for x in kondensatory]
    # eval_KS_test(pojemnosc, "KS test")
    # eval_lilliefors(pojemnosc, "lilliefors test")
    eval_SW_test(pojemnosc, "SW test")
    qqplot(pojemnosc)


def zad10():
    absolwenci = read_csv_file("absolwenci.csv", delimiter=';')
    rolnictwo = [int(x["SALARY"]) for x in absolwenci if x["COLLEGE"] == "Rolnictwo"]
    pedagogika = [int(x["SALARY"]) for x in absolwenci if x["COLLEGE"] == "Pedagogika"]

    qqplot(rolnictwo, title="Rolnictwo")
    qqplot(pedagogika, title="Pedagogika")

    eval_KS_test(rolnictwo, "Rolnictwo KS test")
    eval_lilliefors(rolnictwo, "Rolnictwo lilliefors test")
    eval_SW_test(rolnictwo, "Rolnictwo SW test")

    print("\n\n\n")
    eval_KS_test(pedagogika, "Pedagogika KS test")
    eval_lilliefors(pedagogika, "Pedagogika lilliefors test")
    eval_SW_test(pedagogika, "Pedagogika SW test")


def print_hypothesis(alpha, name, hypothesis, pvalue):
    print(f"{name}, H0={hypothesis}")
    if pvalue > alpha:
        print(f"Nie ma podstaw do odrzucenia hipotezy Ho\npvalue: {pvalue:f} > alpha: {alpha:f}")
    else:
        print(f"Hipoteza Ho odrzucona\npvalue: {pvalue:f} <= alpha: {alpha:f}")


def eval_KS_test(data, name: str = ""):
    # CDFall = norm.cdf(data, loc=np.mean(data), scale=np.std(data))
    # statistic, pvalue = scipy.stats.kstest(CDFall, norm.cdf)
    statistic, pvalue = scipy.stats.kstest(data, lambda x: norm.cdf(x, loc=np.mean(x), scale=np.std(x)))

    print_hypothesis(alpha, name, statistic, pvalue)


def eval_KS2_test(data1, data2, name: str = ""):
    statistic, pvalue = scipy.stats.ks_2samp(data1, data2)
    print_hypothesis(alpha, name, statistic, pvalue)


def eval_lilliefors(data, name: str = ""):
    ksstat, pvalue = lilliefors(data, dist="norm")
    print_hypothesis(alpha, name, ksstat, pvalue)


def eval_SW_test(data, name: str = ""):
    statistic, pvalue = scipy.stats.shapiro(data)
    print_hypothesis(alpha, name, statistic, pvalue)


# zad10()

if __name__ == '__main__':
    while True:
        print("\ndawaj numera 1-10".upper())
        choice = input("dej mnie ")
        zad = f"zad{choice}"
        print(f"i cyk {zad}()")
        # noinspection PyUnresolvedReferences
        from Lista3 import lista_3 as l3

        try:
            getattr(l3, zad)()
        except AttributeError:
            print("ojeje 😭")
