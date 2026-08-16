data {
  int<lower=0> N;
  int<lower=0, upper=N> y;
}
parameters {
  real<lower=0, upper=1> theta;  // batting ability
}
model {
  theta ~ beta(1, 1);
  y ~ binomial(N, theta);
}
generated quantities {
  real batting_average = 1000 * theta;
}
