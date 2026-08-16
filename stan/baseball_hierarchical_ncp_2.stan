data {
  int<lower=0> N; // players
  array[N] int<lower=0> K; // at-bats
  array[N] int<lower=0> y; // hits
}
parameters {
  real mu; // population mean of success log-odds
  real<lower=0> sigma; // population sd of success log-odds
  vector[N] alpha_std; // success log-odds - non-centered
}
model {
  mu ~ normal(-1, 1); // hyperprior
  sigma ~ std_normal(); // hyperprior
  alpha_std ~ std_normal(); // prior (hierarchical)
  y ~ binomial_logit(K, mu + sigma * alpha_std); // likelihood
}
generated quantities {
  vector[N] theta = inv_logit(mu + sigma * alpha_std);
  vector[N] batting_average = 1000 * theta;
}
