#include <Rcpp.h>
using namespace Rcpp ;
#include "include/models.hpp"

RCPP_MODULE(stan_fit4linexp_gastro_1b_mod) {


    class_<rstan::stan_fit<model_linexp_gastro_1b_namespace::model_linexp_gastro_1b, boost::random::ecuyer1988> >("model_linexp_gastro_1b")

    .constructor<SEXP,SEXP>()


    .method("call_sampler", &rstan::stan_fit<model_linexp_gastro_1b_namespace::model_linexp_gastro_1b, boost::random::ecuyer1988> ::call_sampler)
    .method("param_names", &rstan::stan_fit<model_linexp_gastro_1b_namespace::model_linexp_gastro_1b, boost::random::ecuyer1988> ::param_names)
    .method("param_names_oi", &rstan::stan_fit<model_linexp_gastro_1b_namespace::model_linexp_gastro_1b, boost::random::ecuyer1988> ::param_names_oi)
    .method("param_fnames_oi", &rstan::stan_fit<model_linexp_gastro_1b_namespace::model_linexp_gastro_1b, boost::random::ecuyer1988> ::param_fnames_oi)
    .method("param_dims", &rstan::stan_fit<model_linexp_gastro_1b_namespace::model_linexp_gastro_1b, boost::random::ecuyer1988> ::param_dims)
    .method("param_dims_oi", &rstan::stan_fit<model_linexp_gastro_1b_namespace::model_linexp_gastro_1b, boost::random::ecuyer1988> ::param_dims_oi)
    .method("update_param_oi", &rstan::stan_fit<model_linexp_gastro_1b_namespace::model_linexp_gastro_1b, boost::random::ecuyer1988> ::update_param_oi)
    .method("param_oi_tidx", &rstan::stan_fit<model_linexp_gastro_1b_namespace::model_linexp_gastro_1b, boost::random::ecuyer1988> ::param_oi_tidx)
    .method("grad_log_prob", &rstan::stan_fit<model_linexp_gastro_1b_namespace::model_linexp_gastro_1b, boost::random::ecuyer1988> ::grad_log_prob)
    .method("log_prob", &rstan::stan_fit<model_linexp_gastro_1b_namespace::model_linexp_gastro_1b, boost::random::ecuyer1988> ::log_prob)
    .method("unconstrain_pars", &rstan::stan_fit<model_linexp_gastro_1b_namespace::model_linexp_gastro_1b, boost::random::ecuyer1988> ::unconstrain_pars)
    .method("constrain_pars", &rstan::stan_fit<model_linexp_gastro_1b_namespace::model_linexp_gastro_1b, boost::random::ecuyer1988> ::constrain_pars)
    .method("num_pars_unconstrained", &rstan::stan_fit<model_linexp_gastro_1b_namespace::model_linexp_gastro_1b, boost::random::ecuyer1988> ::num_pars_unconstrained)
    .method("unconstrained_param_names", &rstan::stan_fit<model_linexp_gastro_1b_namespace::model_linexp_gastro_1b, boost::random::ecuyer1988> ::unconstrained_param_names)
    .method("constrained_param_names", &rstan::stan_fit<model_linexp_gastro_1b_namespace::model_linexp_gastro_1b, boost::random::ecuyer1988> ::constrained_param_names)
    ;
}
#include <Rcpp.h>
using namespace Rcpp ;
#include "include/models.hpp"

RCPP_MODULE(stan_fit4linexp_gastro_1c_mod) {


    class_<rstan::stan_fit<model_linexp_gastro_1c_namespace::model_linexp_gastro_1c, boost::random::ecuyer1988> >("model_linexp_gastro_1c")

    .constructor<SEXP,SEXP>()


    .method("call_sampler", &rstan::stan_fit<model_linexp_gastro_1c_namespace::model_linexp_gastro_1c, boost::random::ecuyer1988> ::call_sampler)
    .method("param_names", &rstan::stan_fit<model_linexp_gastro_1c_namespace::model_linexp_gastro_1c, boost::random::ecuyer1988> ::param_names)
    .method("param_names_oi", &rstan::stan_fit<model_linexp_gastro_1c_namespace::model_linexp_gastro_1c, boost::random::ecuyer1988> ::param_names_oi)
    .method("param_fnames_oi", &rstan::stan_fit<model_linexp_gastro_1c_namespace::model_linexp_gastro_1c, boost::random::ecuyer1988> ::param_fnames_oi)
    .method("param_dims", &rstan::stan_fit<model_linexp_gastro_1c_namespace::model_linexp_gastro_1c, boost::random::ecuyer1988> ::param_dims)
    .method("param_dims_oi", &rstan::stan_fit<model_linexp_gastro_1c_namespace::model_linexp_gastro_1c, boost::random::ecuyer1988> ::param_dims_oi)
    .method("update_param_oi", &rstan::stan_fit<model_linexp_gastro_1c_namespace::model_linexp_gastro_1c, boost::random::ecuyer1988> ::update_param_oi)
    .method("param_oi_tidx", &rstan::stan_fit<model_linexp_gastro_1c_namespace::model_linexp_gastro_1c, boost::random::ecuyer1988> ::param_oi_tidx)
    .method("grad_log_prob", &rstan::stan_fit<model_linexp_gastro_1c_namespace::model_linexp_gastro_1c, boost::random::ecuyer1988> ::grad_log_prob)
    .method("log_prob", &rstan::stan_fit<model_linexp_gastro_1c_namespace::model_linexp_gastro_1c, boost::random::ecuyer1988> ::log_prob)
    .method("unconstrain_pars", &rstan::stan_fit<model_linexp_gastro_1c_namespace::model_linexp_gastro_1c, boost::random::ecuyer1988> ::unconstrain_pars)
    .method("constrain_pars", &rstan::stan_fit<model_linexp_gastro_1c_namespace::model_linexp_gastro_1c, boost::random::ecuyer1988> ::constrain_pars)
    .method("num_pars_unconstrained", &rstan::stan_fit<model_linexp_gastro_1c_namespace::model_linexp_gastro_1c, boost::random::ecuyer1988> ::num_pars_unconstrained)
    .method("unconstrained_param_names", &rstan::stan_fit<model_linexp_gastro_1c_namespace::model_linexp_gastro_1c, boost::random::ecuyer1988> ::unconstrained_param_names)
    .method("constrained_param_names", &rstan::stan_fit<model_linexp_gastro_1c_namespace::model_linexp_gastro_1c, boost::random::ecuyer1988> ::constrained_param_names)
    ;
}
#include <Rcpp.h>
using namespace Rcpp ;
#include "include/models.hpp"

RCPP_MODULE(stan_fit4linexp_gastro_1d_mod) {


    class_<rstan::stan_fit<model_linexp_gastro_1d_namespace::model_linexp_gastro_1d, boost::random::ecuyer1988> >("model_linexp_gastro_1d")

    .constructor<SEXP,SEXP>()


    .method("call_sampler", &rstan::stan_fit<model_linexp_gastro_1d_namespace::model_linexp_gastro_1d, boost::random::ecuyer1988> ::call_sampler)
    .method("param_names", &rstan::stan_fit<model_linexp_gastro_1d_namespace::model_linexp_gastro_1d, boost::random::ecuyer1988> ::param_names)
    .method("param_names_oi", &rstan::stan_fit<model_linexp_gastro_1d_namespace::model_linexp_gastro_1d, boost::random::ecuyer1988> ::param_names_oi)
    .method("param_fnames_oi", &rstan::stan_fit<model_linexp_gastro_1d_namespace::model_linexp_gastro_1d, boost::random::ecuyer1988> ::param_fnames_oi)
    .method("param_dims", &rstan::stan_fit<model_linexp_gastro_1d_namespace::model_linexp_gastro_1d, boost::random::ecuyer1988> ::param_dims)
    .method("param_dims_oi", &rstan::stan_fit<model_linexp_gastro_1d_namespace::model_linexp_gastro_1d, boost::random::ecuyer1988> ::param_dims_oi)
    .method("update_param_oi", &rstan::stan_fit<model_linexp_gastro_1d_namespace::model_linexp_gastro_1d, boost::random::ecuyer1988> ::update_param_oi)
    .method("param_oi_tidx", &rstan::stan_fit<model_linexp_gastro_1d_namespace::model_linexp_gastro_1d, boost::random::ecuyer1988> ::param_oi_tidx)
    .method("grad_log_prob", &rstan::stan_fit<model_linexp_gastro_1d_namespace::model_linexp_gastro_1d, boost::random::ecuyer1988> ::grad_log_prob)
    .method("log_prob", &rstan::stan_fit<model_linexp_gastro_1d_namespace::model_linexp_gastro_1d, boost::random::ecuyer1988> ::log_prob)
    .method("unconstrain_pars", &rstan::stan_fit<model_linexp_gastro_1d_namespace::model_linexp_gastro_1d, boost::random::ecuyer1988> ::unconstrain_pars)
    .method("constrain_pars", &rstan::stan_fit<model_linexp_gastro_1d_namespace::model_linexp_gastro_1d, boost::random::ecuyer1988> ::constrain_pars)
    .method("num_pars_unconstrained", &rstan::stan_fit<model_linexp_gastro_1d_namespace::model_linexp_gastro_1d, boost::random::ecuyer1988> ::num_pars_unconstrained)
    .method("unconstrained_param_names", &rstan::stan_fit<model_linexp_gastro_1d_namespace::model_linexp_gastro_1d, boost::random::ecuyer1988> ::unconstrained_param_names)
    .method("constrained_param_names", &rstan::stan_fit<model_linexp_gastro_1d_namespace::model_linexp_gastro_1d, boost::random::ecuyer1988> ::constrained_param_names)
    ;
}
#include <Rcpp.h>
using namespace Rcpp ;
#include "include/models.hpp"

RCPP_MODULE(stan_fit4linexp_gastro_2b_mod) {


    class_<rstan::stan_fit<model_linexp_gastro_2b_namespace::model_linexp_gastro_2b, boost::random::ecuyer1988> >("model_linexp_gastro_2b")

    .constructor<SEXP,SEXP>()


    .method("call_sampler", &rstan::stan_fit<model_linexp_gastro_2b_namespace::model_linexp_gastro_2b, boost::random::ecuyer1988> ::call_sampler)
    .method("param_names", &rstan::stan_fit<model_linexp_gastro_2b_namespace::model_linexp_gastro_2b, boost::random::ecuyer1988> ::param_names)
    .method("param_names_oi", &rstan::stan_fit<model_linexp_gastro_2b_namespace::model_linexp_gastro_2b, boost::random::ecuyer1988> ::param_names_oi)
    .method("param_fnames_oi", &rstan::stan_fit<model_linexp_gastro_2b_namespace::model_linexp_gastro_2b, boost::random::ecuyer1988> ::param_fnames_oi)
    .method("param_dims", &rstan::stan_fit<model_linexp_gastro_2b_namespace::model_linexp_gastro_2b, boost::random::ecuyer1988> ::param_dims)
    .method("param_dims_oi", &rstan::stan_fit<model_linexp_gastro_2b_namespace::model_linexp_gastro_2b, boost::random::ecuyer1988> ::param_dims_oi)
    .method("update_param_oi", &rstan::stan_fit<model_linexp_gastro_2b_namespace::model_linexp_gastro_2b, boost::random::ecuyer1988> ::update_param_oi)
    .method("param_oi_tidx", &rstan::stan_fit<model_linexp_gastro_2b_namespace::model_linexp_gastro_2b, boost::random::ecuyer1988> ::param_oi_tidx)
    .method("grad_log_prob", &rstan::stan_fit<model_linexp_gastro_2b_namespace::model_linexp_gastro_2b, boost::random::ecuyer1988> ::grad_log_prob)
    .method("log_prob", &rstan::stan_fit<model_linexp_gastro_2b_namespace::model_linexp_gastro_2b, boost::random::ecuyer1988> ::log_prob)
    .method("unconstrain_pars", &rstan::stan_fit<model_linexp_gastro_2b_namespace::model_linexp_gastro_2b, boost::random::ecuyer1988> ::unconstrain_pars)
    .method("constrain_pars", &rstan::stan_fit<model_linexp_gastro_2b_namespace::model_linexp_gastro_2b, boost::random::ecuyer1988> ::constrain_pars)
    .method("num_pars_unconstrained", &rstan::stan_fit<model_linexp_gastro_2b_namespace::model_linexp_gastro_2b, boost::random::ecuyer1988> ::num_pars_unconstrained)
    .method("unconstrained_param_names", &rstan::stan_fit<model_linexp_gastro_2b_namespace::model_linexp_gastro_2b, boost::random::ecuyer1988> ::unconstrained_param_names)
    .method("constrained_param_names", &rstan::stan_fit<model_linexp_gastro_2b_namespace::model_linexp_gastro_2b, boost::random::ecuyer1988> ::constrained_param_names)
    ;
}
#include <Rcpp.h>
using namespace Rcpp ;
#include "include/models.hpp"

RCPP_MODULE(stan_fit4linexp_gastro_2c_mod) {


    class_<rstan::stan_fit<model_linexp_gastro_2c_namespace::model_linexp_gastro_2c, boost::random::ecuyer1988> >("model_linexp_gastro_2c")

    .constructor<SEXP,SEXP>()


    .method("call_sampler", &rstan::stan_fit<model_linexp_gastro_2c_namespace::model_linexp_gastro_2c, boost::random::ecuyer1988> ::call_sampler)
    .method("param_names", &rstan::stan_fit<model_linexp_gastro_2c_namespace::model_linexp_gastro_2c, boost::random::ecuyer1988> ::param_names)
    .method("param_names_oi", &rstan::stan_fit<model_linexp_gastro_2c_namespace::model_linexp_gastro_2c, boost::random::ecuyer1988> ::param_names_oi)
    .method("param_fnames_oi", &rstan::stan_fit<model_linexp_gastro_2c_namespace::model_linexp_gastro_2c, boost::random::ecuyer1988> ::param_fnames_oi)
    .method("param_dims", &rstan::stan_fit<model_linexp_gastro_2c_namespace::model_linexp_gastro_2c, boost::random::ecuyer1988> ::param_dims)
    .method("param_dims_oi", &rstan::stan_fit<model_linexp_gastro_2c_namespace::model_linexp_gastro_2c, boost::random::ecuyer1988> ::param_dims_oi)
    .method("update_param_oi", &rstan::stan_fit<model_linexp_gastro_2c_namespace::model_linexp_gastro_2c, boost::random::ecuyer1988> ::update_param_oi)
    .method("param_oi_tidx", &rstan::stan_fit<model_linexp_gastro_2c_namespace::model_linexp_gastro_2c, boost::random::ecuyer1988> ::param_oi_tidx)
    .method("grad_log_prob", &rstan::stan_fit<model_linexp_gastro_2c_namespace::model_linexp_gastro_2c, boost::random::ecuyer1988> ::grad_log_prob)
    .method("log_prob", &rstan::stan_fit<model_linexp_gastro_2c_namespace::model_linexp_gastro_2c, boost::random::ecuyer1988> ::log_prob)
    .method("unconstrain_pars", &rstan::stan_fit<model_linexp_gastro_2c_namespace::model_linexp_gastro_2c, boost::random::ecuyer1988> ::unconstrain_pars)
    .method("constrain_pars", &rstan::stan_fit<model_linexp_gastro_2c_namespace::model_linexp_gastro_2c, boost::random::ecuyer1988> ::constrain_pars)
    .method("num_pars_unconstrained", &rstan::stan_fit<model_linexp_gastro_2c_namespace::model_linexp_gastro_2c, boost::random::ecuyer1988> ::num_pars_unconstrained)
    .method("unconstrained_param_names", &rstan::stan_fit<model_linexp_gastro_2c_namespace::model_linexp_gastro_2c, boost::random::ecuyer1988> ::unconstrained_param_names)
    .method("constrained_param_names", &rstan::stan_fit<model_linexp_gastro_2c_namespace::model_linexp_gastro_2c, boost::random::ecuyer1988> ::constrained_param_names)
    ;
}
#include <Rcpp.h>
using namespace Rcpp ;
#include "include/models.hpp"

RCPP_MODULE(stan_fit4powexp_gastro_2c_mod) {


    class_<rstan::stan_fit<model_powexp_gastro_2c_namespace::model_powexp_gastro_2c, boost::random::ecuyer1988> >("model_powexp_gastro_2c")

    .constructor<SEXP,SEXP>()


    .method("call_sampler", &rstan::stan_fit<model_powexp_gastro_2c_namespace::model_powexp_gastro_2c, boost::random::ecuyer1988> ::call_sampler)
    .method("param_names", &rstan::stan_fit<model_powexp_gastro_2c_namespace::model_powexp_gastro_2c, boost::random::ecuyer1988> ::param_names)
    .method("param_names_oi", &rstan::stan_fit<model_powexp_gastro_2c_namespace::model_powexp_gastro_2c, boost::random::ecuyer1988> ::param_names_oi)
    .method("param_fnames_oi", &rstan::stan_fit<model_powexp_gastro_2c_namespace::model_powexp_gastro_2c, boost::random::ecuyer1988> ::param_fnames_oi)
    .method("param_dims", &rstan::stan_fit<model_powexp_gastro_2c_namespace::model_powexp_gastro_2c, boost::random::ecuyer1988> ::param_dims)
    .method("param_dims_oi", &rstan::stan_fit<model_powexp_gastro_2c_namespace::model_powexp_gastro_2c, boost::random::ecuyer1988> ::param_dims_oi)
    .method("update_param_oi", &rstan::stan_fit<model_powexp_gastro_2c_namespace::model_powexp_gastro_2c, boost::random::ecuyer1988> ::update_param_oi)
    .method("param_oi_tidx", &rstan::stan_fit<model_powexp_gastro_2c_namespace::model_powexp_gastro_2c, boost::random::ecuyer1988> ::param_oi_tidx)
    .method("grad_log_prob", &rstan::stan_fit<model_powexp_gastro_2c_namespace::model_powexp_gastro_2c, boost::random::ecuyer1988> ::grad_log_prob)
    .method("log_prob", &rstan::stan_fit<model_powexp_gastro_2c_namespace::model_powexp_gastro_2c, boost::random::ecuyer1988> ::log_prob)
    .method("unconstrain_pars", &rstan::stan_fit<model_powexp_gastro_2c_namespace::model_powexp_gastro_2c, boost::random::ecuyer1988> ::unconstrain_pars)
    .method("constrain_pars", &rstan::stan_fit<model_powexp_gastro_2c_namespace::model_powexp_gastro_2c, boost::random::ecuyer1988> ::constrain_pars)
    .method("num_pars_unconstrained", &rstan::stan_fit<model_powexp_gastro_2c_namespace::model_powexp_gastro_2c, boost::random::ecuyer1988> ::num_pars_unconstrained)
    .method("unconstrained_param_names", &rstan::stan_fit<model_powexp_gastro_2c_namespace::model_powexp_gastro_2c, boost::random::ecuyer1988> ::unconstrained_param_names)
    .method("constrained_param_names", &rstan::stan_fit<model_powexp_gastro_2c_namespace::model_powexp_gastro_2c, boost::random::ecuyer1988> ::constrained_param_names)
    ;
}
