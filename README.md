![Status](https://img.shields.io/badge/Access-Read--Only-blue)
![License](https://img.shields.io/badge/License-CC%20BY--NC--ND%204.0-lightgrey)

This repository is made publicly available **for consultation only** as part of research and academic evaluation.

The code solves the Einstein-Klein-Gordon field equations for constructing
spinning (mini) boson stars. The scalar field is governed by the equation:

\box\Phi = \mu^2\Phi with \mu^2=1,

and the convention for the Einstein equation is 4\pi*G=1.

The code uses the metric parametrisation,

ds^2=-exp(2*f)*dt^2 + exp(2*m)*dr^2 + exp(2*m)*r^2*d\theta^2 + exp(2*l)*r^2*sin(\theta)^2*(d\varphi - w/r^2*dt)^2,

and the scalar field ansatz: \Phi = \phi(r,\theta)*exp(-i\omega*t + i*m*\varphi).

It uses a compactified radial coordinate: r(x) = c*x/(1-x),

and a redefinition: \hat{m} = m - l.
