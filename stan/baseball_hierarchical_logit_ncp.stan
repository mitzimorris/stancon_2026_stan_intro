data {
  int<lower=0> N; // players
  array[N] int<lower=0> K; // at-bats
  array[N] int<lower=0> y; // hits
}
parameters {
  real mu; // population mean of success log-odds
  real<lower=0> sigma; // population sd of success log-odds
  vector<offset=mu, multiplier=sigma>[N] alpha; // success log-odds - non-centered
}
model {
  mu ~ normal(-1, 1); // hyperprior
  sigma ~ std_normal(); // hyperprior
  alpha ~ normal(mu, sigma); // prior (hierarchical)
  y ~ binomial_logit(K, alpha); // likelihood
}
generated quantities {
  vector[N] theta = inv_logit(alpha);
  vector[N] batting_average = 1000 * theta;
}
