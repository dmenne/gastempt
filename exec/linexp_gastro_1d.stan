# A minimal program to fit linexp gastric emptying curves with Stan
# Vectorized version, manual subexpression optimization
# The prior mean of the initial volume can be set from the calling function.
# All other priors are fixed.
data{
  real prior_v0;
  int<lower=0> n; # Number of data
  int<lower=0> n_record; # Number of subjects
  int record[n];
  vector[n] minute;
  vector[n] volume;
}

parameters{
  vector<lower=0>[n_record] v0;
  vector<lower=0>[n_record] kappa;
  vector<lower=0>[n_record] tempt;
  real <lower=0> sigma;
  real <lower=0> mu_kappa;
  real <lower=0> sigma_kappa;
}

transformed parameters {
  vector[n] mt;
  mt = minute ./ tempt[record]; # manual optimization
}

model{
  vector[n] vol;
  mu_kappa ~ normal(1.5,0.5);
  sigma_kappa ~ normal(1,0.5);

  v0    ~ normal(prior_v0, 100);
  kappa ~ lognormal(mu_kappa, sigma_kappa);
  tempt ~ normal(60., 20.);
  sigma ~ gamma(20., 0.5);
  vol = v0[record] .* (1+ kappa[record] .* mt) .*  exp(-mt);
  volume ~ normal(vol, sigma);

}



