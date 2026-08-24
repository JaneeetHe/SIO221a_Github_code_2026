"""SIO221a helper functions (Python).

Python counterpart to the MATLAB routines in SIO221a_Github_code/mha_code.
Add this directory to your path with

    import sys; sys.path.append('../python_code')

and then `from mha_sum_squares_fcn import mha_sum_squares_fcn`.
"""

import numpy as np


def mha_sum_squares_fcn(n):
    """Return a vector of the sum of the first c squares, for c = 1...n.

    Parameters
    ----------
    n : int
        Number of terms.

    Returns
    -------
    fs : ndarray of float, length n
        fs[c] = sum_{i=1}^{c+1} i**2   (note Python's 0-based indexing!)

    Examples
    --------
    >>> mha_sum_squares_fcn(4)
    array([ 1.,  5., 14., 30.])

    2026-08-24  Matthew Alford  (Python version of mha_sum_squares_fcn.m)
    """
    fs = np.full(n, np.nan)     # make an array for the answer
    c = 0                       # initialize an index (Python starts at 0!)
    fs[0] = 1.0 ** 2            # and initialize the first one

    # A while loop.
    while c < n - 1:            # execute while c is less than n-1
        fs[c + 1] = fs[c] + (c + 2) ** 2   # compute the next one and add it on
        c = c + 1                          # increment the counter

    return fs
