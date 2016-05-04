# For Gastric functions, per record only
data{
  real prior_v0;
  int<lower=0> n; # Number of data
  int<lower=0> n_record; # Number of records, used for v0
  int record[n];
  real minute[n];
  real volume[n];
}

parameters{
  real <lower=0> v0[n_record];
  real <lower=0> kappa[n_record];
  real <lower=0> tempt[n_record];
  real <lower=0> sigma;
  real <lower=0> mu_kappa;
  real <lower=0> sigma_kappa;
}


model{
  int  rec;
  real v0r;
  real kappar;
  real temptr;

  mu_kappa ~ normal(1.5,0.5);
  sigma_kappa ~ normal(1,0.5);

  v0    ~ normal(prior_v0, 100);
  kappa ~ lognormal(mu_kappa, sigma_kappa);
  tempt ~ normal(60, 20);
  sigma ~ gamma(20, 0.5);

for (i in 1:n){
   rec <- record[i];
   v0r <- v0[rec];
   kappar <- kappa[rec];
   temptr <- tempt[rec];
   volume[i] ~ normal(v0r*(1+kappar*minute[i]/temptr)*exp(-minute[i]/temptr), sigma);
  }
}


