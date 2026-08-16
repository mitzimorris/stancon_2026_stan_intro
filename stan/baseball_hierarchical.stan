data {
  int<lower=0> N; // players
  array[N] int<lower=0> K; // at-bats
  array[N] int<lower=0> y; // hits
}
parameters {
  real<lower=0, upper=1> phi; // population chance of success
  real<lower=1> kappa; // population concentration
  vector<lower=0, upper=1>[N] theta;  // batting ability
}
model {
  kappa ~ pareto(1, 1.5); // hyperprior
  theta ~ beta(phi * kappa, (1 - phi) * kappa);  // prior
  y ~ binomial(K, theta);
}
generated quantities {
  vector[N] batting_average = 1000 * theta;
}
