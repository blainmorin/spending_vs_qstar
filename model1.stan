data {
  int<lower=1> N;
  real episode[N];                     //outcome
  int<lower=1> K;                  //number of markets
  int<lower=1, upper=K> hrr[N];   //market id
}

parameters {
  vector[1] beta;			            // intercept 
  vector[K] w;                    //market intercepts
  real<lower=0> sigma_e;		    // error sd
  real<lower=0> sigma_w;        //residual sd
}

model {
  real mu;
  w ~ normal(0,sigma_w);    //market random effects
  for (i in 1:N){
    mu = beta[1] + w[hrr[i]];
    episode[i] ~ normal(mu,sigma_e);        // likelihood
  }
}

generated quantities{
  real episode_tilde[N];
  real mu;
  real minimum;
  real maximum;
  for (i in 1:N){
    mu = beta[1] + w[hrr[i]];
    episode_tilde[i] = normal_rng(mu,sigma_e);
  }
  minimum = min(episode_tilde);
  maximum = max(episode_tilde);
}
