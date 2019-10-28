import numpy as np
import scipy.stats as stats

from matplotlib import pyplot as plt


def prepare_x_y_for_cdfplot(data):
    x = np.sort(data)
    y = np.arange(1, len(x) + 1) / len(x)
    return x, y


def cdfplot(data, xscale=None):
    x, y = prepare_x_y_for_cdfplot(data)
    plt.step(x, y, marker=' ', linestyle='-')
    plt.ylabel("ECDF")
    if xscale:
        plt.xscale(xscale)
    plt.margins(0.02)
    # plt.hist(controlB, normed=False, cumulative=True, histtype='step')
    plt.show()


def qqplot(data, title: str = None):
    fig, axs = plt.subplots(1, 1)
    stats.probplot(data, dist='norm', plot=plt)
    if title:
        axs.set_title(title)
    plt.show()
