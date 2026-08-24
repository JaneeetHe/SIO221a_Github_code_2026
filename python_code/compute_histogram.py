"""Histogram / probability density by explicit loop.

SIO221a Lecture 3.  MATLAB twin: mha_code/compute_histogram.m
"""

import numpy as np


def compute_histogram(variable, bin_min, bin_max, dbin, pdf=False):
    """Compute a 1D histogram, or a probability density, for a given variable.

    Parameters
    ----------
    variable : 1D array
    bin_min, bin_max : float
        Range of the bin centres.
    dbin : float
        Bin width.
    pdf : bool
        If True, normalize to a probability density (integrates to 1).

    Returns
    -------
    bins : ndarray
        Bin centres.
    counts : ndarray
        Either counts or probability density.
    """
    bins = np.arange(bin_min, bin_max, dbin)
    count = []
    for i in range(len(bins)):
        ind = (variable > bins[i] - dbin/2) & (variable <= bins[i] + dbin/2)
        count.append(ind.sum())
    count = np.array(count)

    if pdf:
        norm_hist = count/count.sum()/dbin
        assert np.allclose(norm_hist.sum()*dbin, 1.0), "PDF doesn't integrate to 1"
        return bins, norm_hist

    return bins, count
