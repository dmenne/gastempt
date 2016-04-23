[![Travis-CI Build Status](https://travis-ci.org/dmenne/gastempt.svg?branch=master)](https://travis-ci.org/dmenne/gastempt)
[![Coverage Status](https://coveralls.io/repos/github/dmenne/gastempt/badge.svg?branch=master)](https://coveralls.io/github/dmenne/gastempt?branch=master)
# Fitting gastric emptying curve

By dieter.menne@menne-biomed.de, Menne Biomed Consulting Tübingen, D-72074 Tübingen

A package and a Shiny web application to create simulated gastric emptying data, and to analyze experimental gastric emptying data using population fit with R and package nlme.

The package is available from github: https://github.com/dmenne/gastempt

Part of the work has been supported by section GI MRT, Klinik für Gastroenterologie und Hepatologie, Universitätsspital Zürich.

Two models are implemented:

* `linexp, vol = v0 * (1 + kappa * t / tempt) * exp(-t / tempt):`Recommended for gastric emptying curves with an initial volume overshoot from secretion. With parameter kappa > 1, there is a maximum after t=0.  When all emptying curves start with a steep drop, this model can be difficult to fit.
* `powexp, vol = v0 * exp(-(t / tempt) ^ beta):` The power exponential function introduced by Elashof et. al. to fit scintigraphic emptying data; this type of data does not have an initial overshoot by design. Compared to the `linexp` model, fitting `powexp` is more reliable and rarely fails to converge in the presence of noise and outliers. The power exponential can be useful with MRI data when there is an unusual late phase in emptying.

Data can be entered directly from the clipboard copied from Excel, or can be simulated. Several preset simulations are provided. Robustness of models can be tested by manipulating noise quality and between-subject variance. Fits are displayed as curves, and the coefficients of the analysis including t50 and the slope in t50 can be downloaded in .csv format.

Hopefully coming (looking for sponsors... ):

* Post-hoc analysis in Shiny application by treatment groups, both for cross-over and fully randomized designs.
* Overcoming the convergence constraints of nlme fits: Using Bayesian models and Stan (http://mc-stan.org/). 
* Tutorial: Why are single curve fits not useful in clinical research? How to analyze studies, and how to fit single curves anyway, e.g. for clinical practice.
* Tutorial: How to fit curves in more complex cases that cannot be handled by the Shiny application using R,  package gastempt, and Stan directly.

![Screenshot](inst/shiny/screenshot.png)

