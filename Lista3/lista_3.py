import numpy as np
import scipy.stats as stats
from matplotlib import pyplot as plt


def prepare_x_y_for_cdfplot(data):
    x = np.sort(data)
    y = np.arange(1, len(x) + 1) / len(x)
    return x, y


def cdfplot(data, xscale=None):
    x, y = prepare_x_y_for_cdfplot(data)
    plt.step(x, y, marker='.', linestyle='-')
    plt.ylabel("ECDF")
    if xscale:
        plt.xscale(xscale)
    plt.margins(0.02)
    # plt.hist(controlB, normed=False, cumulative=True, histtype='step')
    plt.show()


def qqplot(data):
    stats.probplot(data, dist='norm', plot=plt)
    plt.show()


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


zad2()
