"""Aliased frequency given a sampling rate.

SIO221a Lecture 14.  MATLAB twin: mha_code/alias_frequency.m
"""

import numpy as np


def alias_frequency(f_signal, f_sample):
    """Frequency a signal aliases to, given a sampling frequency.

    Returns (f_alias, M) where M is the fold number.  Same units in, same out.

    >>> fa, M = alias_frequency(24/12, 24/9)   # 12 h signal, 9 h sampling
    >>> round(1/fa*24)
    36
    """
    f_ny = f_sample/2
    M = int(np.floor(f_signal/f_ny))
    d = f_signal - M*f_ny
    return (f_ny - d if M % 2 == 1 else d), M
