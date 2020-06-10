//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

// The input data is a vector 'y' of length 'N'.
data {
  int L;
  int D;
  int N;
  matrix[D, L] u;
  matrix[D, N] x;
  matrix[D, 1] m;
  matrix[D, 1] y;
  matrix[D, L+1] m_and_u;
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  vector[L] mu;
  matrix[L, N] alpha;
  matrix[N, 1] beta;
  matrix[L+1, 1] gamma;
}
transformed parameters {
  matrix[D, N] x_loc;
  matrix[D, 1] m_loc;
  matrix[D, 1] y_loc;
  for (i in 1:D){
    x_loc[i, ] = u[i, ] * alpha;
    m_loc[i, ] = x[i, ] * beta;
    y_loc[i, ] = m_and_u[i,] * gamma;
  }
}
// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  target += normal_lpdf(mu | 0, 1);
  for (j in 1:L){
    target += normal_lpdf(alpha[j, ] | 0, 1);
  }
  for (j in 1:N){
    target += normal_lpdf(beta[j, ] | 0, 1);
  }
  for (j in 1:(L+1)){
    target += normal_lpdf(gamma[j, ] | 0, 1);
  }
  for (i in 1:D){
    target += normal_lpdf(u[i, ] | mu, 10);      // likelihood
    target += normal_lpdf(x[i, ] | x_loc[i, ], 1);
    target += normal_lpdf(m[i, ] | m_loc[i, ], 1);
    target += normal_lpdf(y[i, ] | y_loc[i, ], 1);
  }
}

