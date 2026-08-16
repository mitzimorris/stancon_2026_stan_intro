setwd("~/github/zmorris/workshops/applied_bayes_stan_2026")
#| echo: false
#| output: false
suppressMessages(library(brms))
suppressMessages(library(lme4))
suppressMessages(library(cmdstanr))
suppressMessages(library(posterior))
suppressMessages(library(bayesplot))
suppressMessages(library(loo))
suppressMessages(library(cmdstanr))
options(digits=3)
options(width = 120)
options(scipen=20)
options(mc.cores=4)
options(brms.backend="cmdstanr")
library(ggplot2)

(ggplot(sleepstudy, aes(Days, Reaction, group=Subject, colour=Subject)) +
geom_point() +
facet_wrap(~Subject, ncol=9) +
scale_x_continuous(limits=c(0, 10),breaks=c(0,10)) +
theme_minimal())

sleep_simple = brm(Reaction ~ 1 + Days, data = sleepstudy)
sleep_fit = brm(Reaction ~ 1 + Days + (1 + Days|Subject), data = sleepstudy)

# show input data, stanfile
make_standata(sleep_fit)
make_stancode(sleep_fit)

# check fit, diagnostics
summary(sleep_simple)
pp_check(sleep_simple, ndraws=100)



summary(sleep_fit)
pp_check(sleep_fit, ndraws=100)

# prior predictive checkint
sleep_prior = brm(Reaction ~ 1 + Days + (1 + Days|Subject),
                 data = sleepstudy,
                 prior= prior(normal(0, 10), class="b"),
                 sample_prior="only")
pp_check(sleep_prior, ndraws=100)



# model comparison with loo
loo_complete_pool = loo(sleep_simple)
loo_complete_pool

loo_hierarchical = loo(sleep_fit)
loo_hierarchical

loo_compare(loo_complete_pool, loo_hierarchical)
