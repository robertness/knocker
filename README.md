# Knocker

![knocker](https://i.imgur.com/CoJIUke.png)

Experiments in causal latent variable models. In vignettes file, First look into example_DAmour.Rmd. It contains an example of a causal model without a mediator. We learn the parameters in 2 cases: 1) There is no hidden confounder 2) U is a hidden confounder. In both cases we learn the paramaters with MLE, HMC and SVI. Then, look into example_unconstraint_hmc.Rmd and example_unconstraint_svi.Rmd. Both contain example of the same causal model with a mediator. We learn the parameters like in DAmour's example in 2 cases and with MLE, HMC and SVI approaches.
