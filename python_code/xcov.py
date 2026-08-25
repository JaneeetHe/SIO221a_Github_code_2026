"""Lagged cross-covariance and autocovariance, matching MATLAB's xcov.

MATLAB has xcov built in; numpy does not, so here it is.  The convention
follows MATLAB exactly so the two versions of the SIO221a notes agree.

SIO221a Lecture 6.
"""

import numpy as np


def xcov(x, y=None, scale='unbiased'):
    """Lagged cross-covariance of x and y, as MATLAB's xcov(x, y, scale).

    The mean is removed from each series first (that is what makes it a
    *co-variance* rather than a cross-correlation), then

        C(k) = sum_i (x[i+k] - xbar) * (y[i] - ybar)

    Parameters
    ----------
    x : 1D array
    y : 1D array, optional
        If omitted, computes the autocovariance of x.
    scale : {'unbiased', 'biased', 'coeff', 'none'}
        'unbiased' divides each lag by N - |k|, which is what you usually
        want; 'biased' divides everything by N; 'coeff' normalizes so that
        C(0) = 1; 'none' leaves the raw sums.

    Returns
    -------
    lags : ndarray of int, from -(N-1) to N-1
    c    : ndarray, the covariance at each lag

    Examples
    --------
    >>> import numpy as np
    >>> x = np.array([1.0, 2.0, 3.0, 4.0])
    >>> lags, c = xcov(x)
    >>> int(lags[np.argmax(c)])
    0
    """
    x = np.asarray(x, dtype=float).ravel()
    y = x if y is None else np.asarray(y, dtype=float).ravel()
    if len(x) != len(y):
        raise ValueError('x and y must be the same length')

    N = len(x)
    xd = x - np.mean(x)
    yd = y - np.mean(y)

    # full correlation gives lags -(N-1) ... (N-1)
    c = np.correlate(xd, yd, mode='full')
    lags = np.arange(-(N - 1), N)

    if scale == 'unbiased':
        c = c / (N - np.abs(lags))
    elif scale == 'biased':
        c = c / N
    elif scale == 'coeff':
        c = c / np.sqrt(np.sum(xd**2) * np.sum(yd**2))
    elif scale != 'none':
        raise ValueError(f'unknown scale {scale!r}')

    return lags, c
