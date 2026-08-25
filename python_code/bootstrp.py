"""Bootstrap resampling, matching MATLAB's bootstrp.

MATLAB has bootstrp in the Statistics Toolbox; this is the numpy equivalent so
that the two versions of the SIO221a notes stay parallel.

SIO221a Lecture 12.
"""

import numpy as np


def bootstrp(nboot, statfun, data, rng=None):
    """Resample `data` with replacement `nboot` times and apply `statfun`.

    Parameters
    ----------
    nboot : int
        Number of bootstrap replicates.
    statfun : callable
        Applied to each resampled data set.  May return a scalar or a sequence
        (e.g. ``lambda x: [np.mean(x), np.std(x, ddof=1)]``).
    data : 1D array
    rng : numpy Generator, optional
        Pass one for reproducibility.

    Returns
    -------
    stats : ndarray, shape (nboot,) or (nboot, k)
        One row per bootstrap replicate, as MATLAB's bootstrp returns.

    Notes
    -----
    Bootstrapping makes no assumption that the data are Gaussian - it uses the
    distribution the data actually have.  That is the whole point.
    """
    if rng is None:
        rng = np.random.default_rng()
    data = np.asarray(data)
    n = len(data)

    out = []
    for _ in range(nboot):
        idx = rng.integers(0, n, size=n)      # sample WITH replacement
        out.append(np.atleast_1d(np.asarray(statfun(data[idx]), dtype=float)))

    stats = np.vstack(out)
    return stats[:, 0] if stats.shape[1] == 1 else stats
