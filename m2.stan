data {
  int<lower=1> N;                   //number of data points
  real  episode[N];                 //episode
  real  qstar[N];                   //predictor
  real  qieffort[N];                //predictor
  real  accredited[N];              //predictor
  real  urban[N];                   //predictor
  real  mdaffiliation[N];           //predictor
  real  ownership[N];               //predictor
  real  bedsize[N];                 //predictor
  real  cmi[N];                     //predictor
  real  dsh[N];                     //predictor
  real  mdadjadmitrank[N];          //predictor
  int<lower=1> K;                   //number of markets
  int<lower=1, upper=K> hrr[N];     //market id
  int<lower=1, upper=N> id[N];      //hospital id
}

parameters {
  vector[10] beta;                  //fixed intercept and slopes
  vector[K] w;                      //markets
  real<lower=0> sigma_e;            //error sd
  real<lower=0> sigma_w;            //market sd
}

model {
  real mu;
  //priors
  w ~ normal(0,sigma_w);            //market random effects
  // likelihood
  for (i in 1:N){
    mu = beta[1] + w[hrr[i]] + beta[2]*id[i] +
      beta[3]*id[i] +
      beta[4]*id[i] +
      beta[5]*id[i] +
      beta[6]*id[i] +
      beta[7]*id[i] +
      beta[8]*id[i] +
      beta[9]*id[i] +
      beta[10]*id[i];
    episode[i] ~ normal(mu,sigma_e);
  }
}
