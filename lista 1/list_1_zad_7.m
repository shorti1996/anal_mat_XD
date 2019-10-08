pkg load statistics;

P1 = stdnormal_cdf(2);
P2 = P1 - stdnormal_cdf(-2);

fprintf('\nP(Z<2) = %f, P(|Z|<2) = %f\n\n', P1, P2);
