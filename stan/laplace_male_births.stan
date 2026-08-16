transformed data {
  int male = 251527;
  int female = 241945;
}
parameters {
  real<lower=0, upper=1> theta;  // probability male birth
}
model {
  theta ~ beta(1, 1);
  male ~ binomial(male + female, theta);
}
generated quantities {
  // is a male birth more likely?
  int<lower=0, upper=1> theta_gt_half = (theta > 0.5);
}
