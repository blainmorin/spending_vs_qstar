data {
  int<lower=1> N;
  real episode[N];                  //outcome
  real qstar[N];                   //predictor
  real qieffort[N];                //predictor
  real accredited[N];              //predictor
  real urban[N];                   //predictor
  real mdaffiliation[N];           //predictor
  real ownership[N];               //predictor
  real bedsize[N];                 //predictor
  real cmi[N];                     //predictor
  real dsh[N];                     //predictor
  real mdadjadmitrank[N];          //predictor
  int<lower=1> K;                  //number of markets
  int<lower=1, upper=K> hrr[N];     //market id
  int<lower=1, upper=N> id[N];      //hospital id
  
}

parameters {
  vector[11] beta;			           // intercept and slopes 
  vector[K] w;                    //market intercepts
  real<lower=0> sigma_w;          // residual sd
  real<lower=0> sigma_e;		    // error sd
}

model {
  real mu;
  w ~ normal(0, sigma_w);    //market random effects
  for (i in 1:N){
    mu = beta[1] + w[hrr[i]] +
      beta[2]*qstar[i] +
      beta[3]*qieffort[i] +
      beta[4]*accredited[i] +
      beta[5]*urban[i] +
      beta[6]*mdaffiliation[i] +
      beta[7]*ownership[i] +
      beta[8]*bedsize[i] +
      beta[9]*cmi[i] +
      beta[10]*dsh[i] +
      beta[11]*mdadjadmitrank[i];
      
    episode[i] ~ normal(mu,sigma_e);        // likelihood
  }
}

generated quantities{
  real episode_tilde[N];
  real mu;
  real minimum;
  real maximum;
  for (i in 1:N){
    mu = beta[1] + w[hrr[i]] +
      beta[2]*id[i] +
      beta[3]*id[i] +
      beta[4]*id[i] +
      beta[5]*id[i] +
      beta[6]*id[i] +
      beta[7]*id[i] +
      beta[8]*id[i] +
      beta[9]*id[i] +
      beta[10]*id[i] +
      beta[11]*id[1];
    episode_tilde[i] = normal_rng(mu,sigma_e);
  }
  minimum = min(episode_tilde);
  maximum = max(episode_tilde);
}
