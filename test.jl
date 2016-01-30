include("polynomial.jl")
using Polynomial
using Base.Test

# Tests for polynomial.jl
params = [32,3,5.4]
@test compute_polynomial(params,0) == 32
@test compute_polynomial(params,-1) == 34.4
@test compute_polynomial(params,1) == 40.4
@test compute_polynomial(params,100) == 54332.0
@test compute_polynomial(params,-100) == 53732.0


