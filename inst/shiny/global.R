library(stringr)
library(ggplot2)
library(gastempt)
suppressPackageStartupMessages(library(dplyr))
library(readxl)
suppressPackageStartupMessages(library(shinyBS))


presets = na.omit(read_excel("gastempt_presets.xlsx")) %>%
  mutate(
    id = as.character(id)
  )
numcols = which(sapply(presets, is.numeric))

pop_content = c(
  model_a = "<code>linexp</code>, <b>vol = v0 * (1 + kappa * t / tempt) * exp(-t / tempt):</b><br>Recommended for gastric emptying curves with an initial volume overshoot from secretion. With parameter kappa &gt; 1, there is a maximum after t=0. When all emptying curves start with a steep drop, this model can be difficult to fit.<hr><code>powexp</code>, <b>vol = v0 * exp(-(t / tempt) ^ beta):</b><br>The power exponential function introduced by Elashof et. al. to fit scintigraphic emptying data; this type of data does not have an initial overshoot by design. Compared to the linexp model, fitting powexp is more reliable and rarely fails to converge in the presence of noise and outliers. The power exponential can be useful with MRI data when there is an unusual late phase in emptying.",

  variant = "<b>Variant 1:</b> The most generic assumptions to estimate the per-record parameters is also the most likely to fail to converge. If this variant works, use it. Otherwise, try one of the other variants.<br><b>Variant 2</b>: A slightly more restricted version; sometimes converges when variant 1 fails.<br><b>Variant 3</b>: Parameters beta or kappa, which are most difficult to estimate for each curve individually, are computed once only for all records, so these parameters cannot be tested for between-treatment differences. If you are only interested in a good estimate of t50 and v0 and the other variants do not work, use this method.",

  stan_model = "Try the simple model without covariance first, it runs faster. The model with covariance estimation between kappa/beta and tempt possibly follows the points not as good, but provide a higher degree of shrinkage.",

  data = "Enter data from Excel-clipboard or other tab-separated data here. Column headers must be present and named <code>record, minute, vol</code>.<br>Lines starting with <code>#</code> are comments that will be shown in plots and output files.<br>Avoid editing details in this table because curves are recalculated on every key press; use the Clear button, and paste in the full edited data set from source instead.",

seed = "The seed used to initialize the random generator that produces noise and between-record variance of parameters. With the same parameters and the same seed, the full analyzed data set is exactly reproduced. Try to change the seed to see how with different record sets the fit toggles between convergence failure and success.",

model_s = "The model used to <b>generate</b> the simulated data set; this is different from the model used to <b>analyze</b> the data, which is selected in the top box. When you add your own data from the clipboard, only the top box is used. Normally, one should manually select the same model for simulation and analysis, but using different settings can help understanding the effect of fitting different models to your experimental data. Presets do not automatically switch to the correct role - this is by design to force the user to think what she is doing.",

kappa_beta = "<b>kappa</b> is used for the linexp model; values of kappa &gt; 1 indicate that a maximum after t=0 is present, i.e. an overshoot from secretion. <br><b>beta</b> is used for the powexp model only; values above 1 indicate that the curve starts with an horizontal slope at t=0, but the volume never rised above the initial volume v0.",

student_t_df = "Gaussian noise is the usual nice-behaved noise that never occurs in the real world of medical research. With three variants of Student-t distributed noise, outliers can be generated to test the methods for robustness. ",

noise_perc = "Noise amplitude, measured in % of the initial volume v0",
missing = "Fraction of randomly missing data to test the method for robustness"

)

stan_models = ####################### add powexp_gastro_1d ++++
  matrix(c("linexp_gastro_1b", "linexp_gastro_2b",
           "powexp_gastro_1b", "powexp_gastro_2c"),
         nrow = 2, dimnames = list(c("nocov", "withcov"), c("linexp", "powexp")))

preset_description = function(id){
  as.character(presets[presets$id == id, "description"])
}
