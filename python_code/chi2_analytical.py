"""Analytical chi-squared probability density.

SIO221a Lecture 4.  MATLAB twin: mha_code/chi2_analytical.m
"""

import numpy as np
from scipy.special import gamma


def chi2_analytical(vals, n):
    """Return the PDF of a chi2 variable with n degrees of freedom, evaluated
    at `vals`.

    This is equation (20) of the Lecture 4 notes:

        p(x) = x**(n/2 - 1) * exp(-x/2) / (2**(n/2) * Gamma(n/2))
    """
    vals = np.asarray(vals, dtype=float)
    return (1.0/2.0**(n/2)/gamma(n/2)) * np.exp(-vals/2) * vals**(n/2 - 1)
