data {
  int<lower=1> N;                  //number of data points
  real episode[N];                  //episode
  int<lower=1> K;                  //number of markets
  int<lower=1, upper=K> hrr[N];   //hrr id
}

parameters {
  vector[1] beta;            //fixed intercept 
  vector[K] w;               //market intercepts
  real<lower=0> sigma_e;     //error sd
  real<lower=0> sigma_w;     //market sd
}

model {
  real mu;
  //priors
  w ~ normal(0,sigma_w);    //market random effects
  // likelihood
  for (i in 1:N){
    mu = beta[1]  + w[hrr[i]];
    episode[i] ~ normal(mu,sigma_e);
  }
}
